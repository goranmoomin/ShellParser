
enum LexMode: Int32 {
//  case none = 1 // This should be nil instead
  case comment = 2
  case outer = 3
  case dbracket = 4
  case sq = 5
  case dq = 6
  case dollarSq = 7
  case arith = 8
  case extglob = 9
  case vs1 = 10
  case vs2 = 11
  case vsArgUnq = 12
  case vsArgDq = 13
  case bashRegex = 14
  case bashRegexChars = 15
}
