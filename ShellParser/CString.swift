
import Foundation

typealias CString = ContiguousArray<CChar>

extension CString {
    static let empty: CString = [0]
}

extension CString {
    var isValid: Bool {
        count >= 1 && self[count - 1] == 0
    }

    var bytes: ArraySlice<CChar> {
        self[0..<count - 1]
    }
}

extension CString {
    init<S>(bytes: S) where S : Sequence, S.Element == CChar {
        self.init(bytes + [0])
    }
}
