
import Foundation

protocol Reader {
    func readLine() -> CString
}

class StringReader: Reader {
    var lines: [CString]
    var curLineNum: Array<CString>.Index = 0

    init(input: CString) {
        lines = []
        // FIXME: This code is pretty terrible.
        // Should find a way to split with separator included.
        let splits = input.bytes.split(separator: 0x0a, omittingEmptySubsequences: false)
        for (index, line) in splits.enumerated() {
            if index != splits.count - 1 {
                lines.append(CString(bytes: line + [0x0a]))
            } else {
                lines.append(CString(bytes: line))
            }
        }
    }

    convenience init(string: String) {
        self.init(input: string.utf8CString)
    }

    func readLine() -> CString {
        guard curLineNum < lines.count else {
            return .empty
        }
        curLineNum += 1
        return lines[curLineNum - 1]
    }
}
