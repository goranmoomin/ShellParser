
import Foundation

struct Token {
    typealias Id = ShellParser.Id
    var id: Id
    var value: CString
}

extension Token {
    static let undefined = Token(id: .undefinedTok, value: .empty)
    static let unknown = Token(id: .undefinedTok, value: .empty)
    static let eol = Token(id: .eolTok, value: .empty)
    static let eof = Token(id: .eofReal, value: .empty)
}

extension Token: CustomDebugStringConvertible {
    var debugDescription: String {
        let bytes = value.bytes.map(UInt8.init)
        let valueDescription: String
        if let valueString = String(bytes: bytes, encoding: .utf8) {
            valueDescription = valueString.debugDescription
        } else {
            valueDescription = value.debugDescription
        }
        return "Token(id: \(id), value: \(valueDescription))"
    }
}

extension Token {
    typealias Kind = Id.Kind
    var kind: Kind {
        id.kind
    }
}
