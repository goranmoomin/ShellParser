
import Foundation

class WordParser {
    var lexer: Lexer
    var nextMode: Lexer.Mode?
    var curToken: Token = .undefined
    var prevToken: Token = .undefined

    init(lexer: Lexer, mode: Lexer.Mode = .outer) {
        self.lexer = lexer
        nextMode = mode
    }

    func peek() {
        if let nextMode = nextMode {
            prevToken = curToken
            curToken = lexer.read(mode: nextMode)
            self.nextMode = nil
        }

        // return curToken
    }

    func next(mode: Lexer.Mode) {
        nextMode = mode
    }

    func reset(mode: Lexer.Mode = .outer) {
        prevToken = .undefined
        curToken = .undefined
        nextMode = mode
    }

    func readVarOpArg(mode: Lexer.Mode, eof: Id = .undefinedTok, isEmptyAllowed: Bool = true) -> Word.CompoundWord? {
        next(mode: mode)
        peek()
        let word = readCompoundWord(mode: mode, eof: eof, isEmptyAllowed: isEmptyAllowed)
        // TODO: Append emptyPart if word.parts is empty
        return word
    }
    
    func readPatSubVarOp(mode: Lexer.Mode) -> SuffixOp.PatSub? {
        fatalError()
    }

    func readSubscript() -> BracketOp? {
        let token = lexer.lookAhead(mode: .arith)
        let op: BracketOp?
        if token.id == .litAt || token.id == .arithStar {
            op = .wholeArray(op: token.id)
            next(mode: .arith) // skip [
            peek()
            next(mode: .arith) // skip @/*
            peek()
        } else {
            let anode = readArithExpr()!
            op = .arrayIndex(expr: anode)
        }
        assert(curToken.id == .arithRBracket)
        next(mode: .vs2) // skip ]
        peek()
        return op
    }

    func parseVarOf() -> WordPart.BracedVarSub {
        peek()
        let nameToken = curToken
        next(mode: .vs2)
        peek()
        let bracketOp: BracketOp?
        if curToken.id == .vOp2LBracket {
            bracketOp = readSubscript()
        } else {
            bracketOp = nil
        }
        return WordPart.BracedVarSub(token: nameToken, bracketOp: bracketOp)
    }

    func parseVarExpr(mode: Lexer.Mode) -> WordPart.BracedVarSub? {
        var bracedVarSub = parseVarOf()
        peek()
        if curToken.id == .rightVarSub {
            return bracedVarSub
        }
        switch curToken.kind {
        case .vTest, .vOp1:
            let op = curToken.id
            guard let argWord: Word = .compoundWord(readVarOpArg(mode: mode)) else {
                return nil
            }
            guard curToken.id == .rightVarSub else {
                return nil
            }
            bracedVarSub.suffixOp = .stringUnary(op: op, argWord: argWord)
            return bracedVarSub
        case .vOp2:
            if curToken.id == .vOp2Slash {
                bracedVarSub.suffixOp = .patSub(readPatSubVarOp(mode: mode))
                assert(curToken.id == .rightVarSub)
            } else if curToken.id == .vOp2Colon {
                fatalError()
            } else {
                fatalError()
            }
            return bracedVarSub
        default: fatalError()
        }
    }

    func readBracedVarSub(isDoubleQuoted: Bool = false) -> WordPart? {
        let mode: Lexer.Mode
        if isDoubleQuoted {
            mode = .vsArgDq
        } else {
            mode = .vsArgUnq
        }
        next(mode: .vs1)
        peek()
        if curToken.id == .vSubPound || curToken.id == .vSubBang {
            let prefixOp = curToken.id
            let token = lexer.lookAhead(mode: .vs1)
            if token.id == .unknownTok || token.id == .rightVarSub {
                // prefixOp is not actually a prefix, process it as a variable
                return .bracedVarSub(parseVarExpr(mode: mode))
            } else {
                next(mode: .vs1)
                if curToken.id == .vSubPound {
                    var bracedVarSub = parseVarOf()
                    bracedVarSub.prefixOp = prefixOp
                    peek()
                    assert(curToken.id == .rightVarSub)
                    return .bracedVarSub(bracedVarSub)
                } else { // curToken.id == .vSubBang
                    var bracedVarSub = parseVarExpr(mode: mode)
                    bracedVarSub?.prefixOp = .vSubBang
                    return .bracedVarSub(bracedVarSub)
                }
            }
        } else if curToken.kind == .vSub {
            return .bracedVarSub(parseVarExpr(mode: mode))
        } else {
            fatalError()
        }
    }

    func readDoubleQuotedLeftParts() -> WordPart? {
        switch curToken.id {
        case .leftVarSub:
            return readBracedVarSub(isDoubleQuoted: true)
        default: fatalError()
        }
    }

    func readLeftParts() -> WordPart? {
        switch curToken.id {
        case .leftDoubleQuote: return readDoubleQuotedParts()
        case .leftVarSub: return readBracedVarSub()
        default: fatalError()
        }
    }

    func readDoubleQuotedParts(eof: Id = .undefinedTok) -> WordPart? {
        var parts: [WordPart] = []
        loop: while true {
            next(mode: .dq)
            peek()
            if curToken.id == eof {
                break
            }
            switch curToken.kind {
            case .lit:
                let part: WordPart
                if curToken.id == .litEscapedChar {
                    part = .escapedLiteralPart(token: curToken)
                } else {
                    part = .literalPart(token: curToken)
                }
                parts.append(part)
            case .left:
                guard let part = readDoubleQuotedLeftParts() else {
                    return nil
                }
                parts.append(part)
            case .vSub:
                let part: WordPart = .simpleVarSub(token: curToken)
                parts.append(part)
            case .right:
                assert(curToken.id == .rightDoubleQuote)
                // TODO: Handle heredocs.
                break loop
            default: fatalError()
            }
        }
        return .doubleQuotedPart(parts: parts)
    }

    func readArithExpr() -> ArithExpr? {
        next(mode: .arith)
        var spec = PrattParser.Spec()

        spec.addNull(token: .eofReal, bp: -1, handler: nullError(_:word:bp:))
        spec.addLeft(token: .eofReal, bp: -1, handler: leftError(_:word:left:rbp:))
        spec.addNull(token: .arithRBracket, bp: -1, handler: nullError(_:word:bp:))
        spec.addLeft(token: .arithRBracket, bp: -1, handler: leftError(_:word:left:rbp:))
        spec.addNull(token: .wordCompound, bp: -1, handler: nullConstant(_:word:bp:))
        spec.addNull(token: .arithLParen, bp: 0, handler: nullParen(_:word:bp:))
        spec.addLeft(token: .arithRParen, bp: -1, handler: leftError(_:word:left:rbp:))
        spec.addLeft(token: .arithStar, bp: 27, handler: leftBinaryOp(_:word:left:rbp:))
        let prattParser = PrattParser(spec: spec, wordParser: self)
        return prattParser.parse()
    }

    func readCompoundWord(
        mode: Lexer.Mode,
        eof: Id = .undefinedTok,
        isEmptyAllowed: Bool = false
    ) -> Word.CompoundWord? {
        var parts: [WordPart] = []
        loop: while true {
            peek()
            if (isEmptyAllowed || parts.count > 0) && curToken.id == eof {
                break
            }
            switch curToken.kind {
            case .lit:
                let part: WordPart
                if curToken.id == .litEscapedChar {
                    part = .escapedLiteralPart(token: curToken)
                } else {
                    part = .literalPart(token: curToken)
                }
                parts.append(part)
            case .left:
                guard let part = readLeftParts() else {
                    print("Hello!")
                    return nil
                }
                parts.append(part)
            case .right:
                // TODO: Handle rightDoubleQuote and rightCommandSub.
                break loop
            default:
                // TODO: Handle unbalanced case clause.
                break loop
            }
            next(mode: mode)
        }

        return Word.CompoundWord(parts: parts)
    }
    
    func readArithWord() -> (Word?, Bool) {
        peek()
        
        switch curToken.kind {
        case .unknown:
            return (nil, false)
        case .eof:
            return (.tokenWord(token: curToken), false)
        case .ignored:
            next(mode: .arith)
            return (nil, true)
        case .arith, .right:
            next(mode: .arith)
            return (.tokenWord(token: curToken), false)
        case .lit, .left:
            guard let word: Word = .compoundWord(readCompoundWord(mode: .arith)) else {
                return (nil, true)
            }
            return (word, false)
        case .vSub:
            let part: WordPart = .simpleVarSub(token: curToken)
            next(mode: .arith)
            let word: Word = .compoundWord(parts: [part])
            return (word, false)
        default:
            fatalError()
        }
    }

    func readWord(mode: Lexer.Mode) -> (Word?, Bool) {
        peek()

        switch curToken.kind {
        case .eof: return (.tokenWord(token: curToken), false)
        case .op, .redir, .arith:
            next(mode: mode)
            if curToken.id == .opNewline {
                fatalError()
            }
            return (.tokenWord(token: curToken), false)
        case .right:
            next(mode: mode)
            return (.tokenWord(token: curToken), false)
        case .ignored, .ws:
            next(mode: mode)
            return (nil, true)
        case .vSub, .lit, .left, .kw, .assign, .controlFlow, .boolUnary, .boolBinary, .extGlob:
            if curToken.id == .litPound {
                fatalError()
            } else {
                return (.compoundWord(readCompoundWord(mode: mode)), false)
            }
        default:
            fatalError()
        }
    }

    func read(mode: Lexer.Mode) -> Word? {
        var shouldContinue = true
        var word: Word?
        while shouldContinue {
            switch mode {
            case .arith:
                (word, shouldContinue) = readArithWord()
            case .outer, .dbracket, .bashRegex:
                (word, shouldContinue) = readWord(mode: mode)
            default:
                fatalError()
            }
        }
        return word
    }
}
