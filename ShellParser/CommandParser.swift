
import Foundation

extension WordPart {
    var literalPartId: Id {
        guard case .literalPart(let literalPart) = self else {
            return .undefinedTok
        }
        return literalPart.token.id
    }
}

extension Word {
    var id: Id {
        switch self {
        case .tokenWord(let tokenWord): return tokenWord.token.id
        case .compoundWord(let compoundWord):
            let parts = compoundWord.parts
            if parts.count > 1 {
                return .wordCompound
            } else {
                return parts[0].literalPartId
            }
        default: return .undefinedTok
        }
    }

    var kind: Id.Kind {
        guard case .tokenWord(let tokenWord) = self else {
            return .word
        }
        return tokenWord.token.kind
    }
}

class CommandParser {
    var lexer: Lexer
    var wordParser: WordParser
    var reader: Reader
    var nextMode: Lexer.Mode? = .outer
    var curWord: Word?


    init(wordParser: WordParser) {
        self.wordParser = wordParser
        lexer = wordParser.lexer
        reader = lexer.reader
    }

    func peek() {
        if let nextMode = nextMode {
            if let word = wordParser.read(mode: nextMode) {
                if case let .tokenWord(tokenWord) = word,
                   tokenWord.token.id == .opNewline {
                    // TODO: Handle heredocs
                    fatalError()
                }
                curWord = word
            }
            self.nextMode = nil
        }
    }

    func next(mode: Lexer.Mode = .outer) {
        nextMode = mode
    }

    func eat(token: Id) {
        peek()
        if curWord?.id != token {
            fatalError()
        }
        next()
    }

    func reset() {
        nextMode = .outer
        curWord = nil
    }

    func parseRedirect() -> Redir? {
        peek()
        assert(curWord?.kind == .redir)
        guard case .tokenWord(let tokenWord) = curWord else {
            fatalError()
        }
        // TODO: Handle fd
        // TODO: Handle heredocs
        next()
        peek()
        return .redir(op: tokenWord.token.id, fd: 0, argWord: curWord!)
    }

    func scanSimpleCommand() -> (redirects: [Redir], words: [Word]) {
        var redirects: [Redir] = []
        var words: [Word] = []
        while true {
            peek()
            if let curWord = curWord,
               curWord.kind == .redir {
                if let redirect = parseRedirect() {
                    redirects.append(redirect)
                }
            } else if let curWord = curWord,
               curWord.kind == .word {
                words.append(curWord)
            } else {
                break
            }
            next()
        }
        return (redirects: redirects, words: words)
    }

    func parseSimpleCommand() -> Command {
        let (redirects: redirects, words: words) = scanSimpleCommand()
        return .simpleCommand(words: words, redirects: redirects, moreEnv: [])
    }
}
