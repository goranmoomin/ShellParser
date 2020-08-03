
import Foundation

enum ParseError: Error {
    enum Reason {
        case expected(Id)
        case notAssignable
        case notIndexable
        case notCallable
        case notUsableAsPrefix
        case notUsableAsInfix
    }
    case unexpected(word: Word, because: Reason)
    case unexpected(token: Token)
}

extension Word {
    var arithId: Id {
        switch self {
        case .tokenWord(let tokenWord): return tokenWord.token.id
        case .compoundWord: return .wordCompound
        default: return .undefinedTok
        }
    }
}

func nullError(_ parser: PrattParser, word: Word, bp: Int) throws -> ArithExpr {
    throw ParseError.unexpected(word: word, because: .notUsableAsPrefix)
}

func nullConstant(_ parser: PrattParser, word: Word, bp: Int) -> ArithExpr {
    if case .compoundWord = word {
//        fatalError()
    }
    return .arithWord(w: word)
}

func nullParen(_ parser: PrattParser, word: Word, bp: Int) throws -> ArithExpr {
    let expr = try parser.parseUntil(rbp: bp)
    try parser.eat(token: .arithRParen)
    return expr
}

func leftError(_ parser: PrattParser, word: Word, left: ArithExpr, rbp: Int) throws -> ArithExpr {
    throw ParseError.unexpected(word: word, because: .notUsableAsInfix)
}

func leftBinaryOp(_ parser: PrattParser, word: Word, left: ArithExpr, rbp: Int) throws -> ArithExpr {
    return .arithBinary(op: word.arithId, left: left, right: try parser.parseUntil(rbp: rbp))
}

class PrattParser {
    struct Spec {
        struct NullInfo {
            typealias Handler = (PrattParser, Word, Int) throws -> ArithExpr
            let bp: Int
            let handler: Handler
        }

        struct LeftInfo {
            typealias Handler = (PrattParser, Word, ArithExpr, Int) throws -> ArithExpr
            let lbp: Int
            let rbp: Int
            let handler: Handler
        }

        var nullInfos: [Id : NullInfo] = [:]
        var leftInfos: [Id : LeftInfo] = [:]

        mutating func addNull(token: Id, bp: Int, handler: @escaping NullInfo.Handler) {
            nullInfos[token] = NullInfo(bp: bp, handler: handler)
        }

        mutating func addLeft(token: Id, bp: Int, handler: @escaping LeftInfo.Handler) {
            leftInfos[token] = LeftInfo(lbp: bp, rbp: bp, handler: handler)
        }

        mutating func addLeftRightAssoc(token: Id, bp: Int, handler: @escaping LeftInfo.Handler) {
            leftInfos[token] = LeftInfo(lbp: bp, rbp: bp - 1, handler: handler)
        }

        func nullInfo(for token: Id) -> NullInfo? {
            nullInfos[token]
        }

        func leftInfo(for token: Id) -> LeftInfo? {
            leftInfos[token]
        }
    }

    let spec: Spec
    let wordParser: WordParser
    var curWord: Word?

    init(spec: Spec, wordParser: WordParser) {
        self.spec = spec
        self.wordParser = wordParser
    }

    func isAt(token: Id) -> Bool {
        curWord?.arithId == token
    }

    func isAt(tokens: [Id]) -> Bool {
        tokens.contains { $0 == curWord?.arithId }
    }

    func eat(token: Id) throws {
        guard isAt(token: token) else {
            throw ParseError.unexpected(word: curWord!, because: .expected(token))
        }
        next()
    }

    func next() {
        curWord = wordParser.read(mode: .arith)
    }

    func parseUntil(rbp: Int) throws -> ArithExpr {
        var word = curWord
        next()
        // FIXME: Stop force unwrapping
        let nullInfo = spec.nullInfo(for: word!.arithId)!
        var node = try nullInfo.handler(self, word!, nullInfo.bp)
        while true {
            word = curWord
            let leftInfo = spec.leftInfo(for: word!.arithId)!
            if rbp >= leftInfo.lbp {
                break
            }
            next()
            node = try leftInfo.handler(self, word!, node, leftInfo.rbp)
        }
        return node
    }

    func parse() -> ArithExpr? {
        next()
        return try? parseUntil(rbp: 0)
    }
}
