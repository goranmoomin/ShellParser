
import Foundation

func matchOshToken(lexMode: LexMode, input: CString, startPos: Int) -> (Id, Int) {
    var rawId: Int32 = 0
    var endPos: Int32 = 0
    input.withUnsafeBufferPointer { body in
        MatchOshToken(lexMode.rawValue, body.baseAddress, Int32(input.count), Int32(startPos),
                      &rawId, &endPos)
    }
    return (Id(rawValue: rawId)!, Int(endPos))
}

class LineLexer {
    typealias Mode = LexMode
    var line: CString
    var curPos: CString.Index

    init(line: CString) {
        self.line = line
        curPos = 0
    }

    convenience init(string: String) {
        self.init(line: string.utf8CString)
    }

    func read(mode: Mode) -> Token {
        let (id, endPos) = matchOshToken(lexMode: mode, input: line, startPos: curPos)
        if id == .eolTok {
            return .eol
        }
        let value = CString(bytes: line[curPos..<endPos])
        curPos = endPos
        return Token(id: id, value: value)
    }

    func lookAhead(mode: Mode) -> Token {
        var pos = curPos
        while true {
            guard pos < line.count else {
                return .unknown
            }
            let (id, endPos) = matchOshToken(lexMode: mode, input: line, startPos: pos)
            if id != .wsSpace {
                let value = CString(bytes: line[curPos..<endPos])
                return Token(id: id, value: value)
            }
            pos = endPos
        }
    }

    func reset(line: CString) {
        self.line = line
        curPos = 0
    }
}

class Lexer {
    typealias Mode = LexMode
    var lineLexer: LineLexer
    var reader: Reader

    init(reader: Reader) {
        self.reader = reader
        lineLexer = LineLexer(line: .empty)
    }

    func read(mode: Mode) -> Token {
        var token = lineLexer.read(mode: mode)
        if token.id == .eolTok {
            let line = reader.readLine()
            if line == .empty {
                return .eof
            }
            lineLexer.reset(line: line)
            token = lineLexer.read(mode: mode)
        }
        return token
    }

    func lookAhead(mode: Mode) -> Token {
        lineLexer.lookAhead(mode: mode)
    }
}
