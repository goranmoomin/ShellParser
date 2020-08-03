
enum Id: Int32 {
    case undefinedTok = 1
    case unknownTok = 2
    case eolTok = 3
    case eofReal = 4
    case eofRParen = 5
    case eofBacktick = 6
    case ignoredLineCont = 7
    case ignoredSpace = 8
    case ignoredComment = 9
    case wsSpace = 10
    case litChars = 11
    case litVarLike = 12
    case litOther = 13
    case litEscapedChar = 14
    case litLBrace = 15
    case litRBrace = 16
    case litComma = 17
    case litDRightBracket = 18
    case litTilde = 19
    case litPound = 20
    case litSlash = 21
    case litPercent = 22
    case litDigits = 23
    case litAt = 24
    case litArithVarLike = 25
    case opNewline = 26
    case opAmp = 27
    case opPipe = 28
    case opPipeAmp = 29
    case opDAmp = 30
    case opDPipe = 31
    case opSemi = 32
    case opDSemi = 33
    case opLParen = 34
    case opRParen = 35
    case opDLeftParen = 36
    case opDRightParen = 37
    case redirLess = 38
    case redirGreat = 39
    case redirDLess = 40
    case redirTLess = 41
    case redirDGreat = 42
    case redirGreatAnd = 43
    case redirLessAnd = 44
    case redirDLessDash = 45
    case redirLessGreat = 46
    case redirClobber = 47
    case redirAndGreat = 48
    case redirAndDGreat = 49
    case leftDoubleQuote = 50
    case leftSingleQuote = 51
    case leftBacktick = 52
    case leftCommandSub = 53
    case leftVarSub = 54
    case leftArithSub = 55
    case leftArithSub2 = 56
    case leftDollarDoubleQuote = 57
    case leftDollarSingleQuote = 58
    case leftProcSubIn = 59
    case leftProcSubOut = 60
    case rightDoubleQuote = 61
    case rightSingleQuote = 62
    case rightBacktick = 63
    case rightCommandSub = 64
    case rightVarSub = 65
    case rightArithSub = 66
    case rightDollarDoubleQuote = 67
    case rightDollarSingleQuote = 68
    case rightSubshell = 69
    case rightFuncDef = 70
    case rightCasePat = 71
    case rightArrayLiteral = 72
    case rightExtGlob = 73
    case extGlobAt = 74
    case extGlobStar = 75
    case extGlobPlus = 76
    case extGlobQMark = 77
    case extGlobBang = 78
    case vSubName = 79
    case vSubNumber = 80
    case vSubBang = 81
    case vSubAt = 82
    case vSubPound = 83
    case vSubDollar = 84
    case vSubStar = 85
    case vSubHyphen = 86
    case vSubQMark = 87
    case vTestColonHyphen = 88
    case vTestHyphen = 89
    case vTestColonEquals = 90
    case vTestEquals = 91
    case vTestColonQMark = 92
    case vTestQMark = 93
    case vTestColonPlus = 94
    case vTestPlus = 95
    case vOp1Percent = 96
    case vOp1DPercent = 97
    case vOp1Pound = 98
    case vOp1DPound = 99
    case vOp1Caret = 100
    case vOp1DCaret = 101
    case vOp1Comma = 102
    case vOp1DComma = 103
    case vOp2Slash = 104
    case vOp2Colon = 105
    case vOp2LBracket = 106
    case vOp2RBracket = 107
    case arithSemi = 108
    case arithComma = 109
    case arithPlus = 110
    case arithMinus = 111
    case arithStar = 112
    case arithSlash = 113
    case arithPercent = 114
    case arithDPlus = 115
    case arithDMinus = 116
    case arithDStar = 117
    case arithLParen = 118
    case arithRParen = 119
    case arithLBracket = 120
    case arithRBracket = 121
    case arithRBrace = 122
    case arithQMark = 123
    case arithColon = 124
    case arithLessEqual = 125
    case arithLess = 126
    case arithGreatEqual = 127
    case arithGreat = 128
    case arithDEqual = 129
    case arithNEqual = 130
    case arithDAmp = 131
    case arithDPipe = 132
    case arithBang = 133
    case arithDGreat = 134
    case arithDLess = 135
    case arithAmp = 136
    case arithPipe = 137
    case arithCaret = 138
    case arithTilde = 139
    case arithEqual = 140
    case arithPlusEqual = 141
    case arithMinusEqual = 142
    case arithStarEqual = 143
    case arithSlashEqual = 144
    case arithPercentEqual = 145
    case arithDGreatEqual = 146
    case arithDLessEqual = 147
    case arithAmpEqual = 148
    case arithPipeEqual = 149
    case arithCaretEqual = 150
    case nodePostDPlus = 151
    case nodePostDMinus = 152
    case nodeUnaryPlus = 153
    case nodeUnaryMinus = 154
    case nodeArithVar = 155
    case nodeCommand = 156
    case nodeAssign = 157
    case nodeAndOr = 158
    case nodeBlock = 159
    case nodeSubshell = 160
    case nodeFork = 161
    case nodeFuncDef = 162
    case nodeForEach = 163
    case nodeForExpr = 164
    case nodeNoOp = 165
    case nodeUnaryExpr = 166
    case nodeBinaryExpr = 167
    case nodeTernaryExpr = 168
    case nodeFuncCall = 169
    case nodeConstInt = 170
    case wordCompound = 171
    case kwDLeftBracket = 172
    case kwBang = 173
    case kwFor = 174
    case kwWhile = 175
    case kwUntil = 176
    case kwDo = 177
    case kwDone = 178
    case kwIn = 179
    case kwCase = 180
    case kwEsac = 181
    case kwIf = 182
    case kwFi = 183
    case kwThen = 184
    case kwElse = 185
    case kwElif = 186
    case kwFunction = 187
    case kwTime = 188
    case assignDeclare = 189
    case assignTypeset = 190
    case assignLocal = 191
    case assignReadonly = 192
    case assignNone = 193
    case controlFlowBreak = 194
    case controlFlowContinue = 195
    case controlFlowReturn = 196
    case controlFlowExit = 197
    case charOneChar = 198
    case charStop = 199
    case charHex = 200
    case charOctal3 = 201
    case charOctal4 = 202
    case charUnicode4 = 203
    case charUnicode8 = 204
    case charLiterals = 205
    case charBadBackslash = 206
    case globLBracket = 207
    case globRBracket = 208
    case globStar = 209
    case globQMark = 210
    case globBang = 211
    case globCaret = 212
    case globEscapedChar = 213
    case globBadBackslash = 214
    case globCleanLiterals = 215
    case globOtherLiteral = 216
    case globEof = 217
    case boolUnaryo = 218
    case boolUnaryt = 219
    case boolUnaryv = 220
    case boolUnaryR = 221
    case boolUnarya = 222
    case boolUnaryb = 223
    case boolUnaryc = 224
    case boolUnaryd = 225
    case boolUnarye = 226
    case boolUnaryf = 227
    case boolUnaryg = 228
    case boolUnaryh = 229
    case boolUnaryL = 230
    case boolUnaryp = 231
    case boolUnaryr = 232
    case boolUnarys = 233
    case boolUnaryS = 234
    case boolUnaryu = 235
    case boolUnaryw = 236
    case boolUnaryx = 237
    case boolUnaryO = 238
    case boolUnaryG = 239
    case boolUnaryN = 240
    case boolUnaryz = 241
    case boolUnaryn = 242
    case boolBinaryeq = 243
    case boolBinaryne = 244
    case boolBinarygt = 245
    case boolBinaryge = 246
    case boolBinarylt = 247
    case boolBinaryle = 248
    case boolBinaryef = 249
    case boolBinarynt = 250
    case boolBinaryot = 251
    case boolBinaryGlobEqual = 252
    case boolBinaryGlobDEqual = 253
    case boolBinaryGlobNEqual = 254
    case boolBinaryEqualTilde = 255
    case boolBinaryEqual = 256
    case boolBinaryDEqual = 257
    case boolBinaryNEqual = 258
}

extension Id {
    enum Kind {
        case undefined
        case unknown
        case eol
        case eof
        case ignored
        case ws
        case lit
        case op
        case redir
        case left
        case right
        case extGlob
        case vSub
        case vTest
        case vOp1
        case vOp2
        case arith
        case node
        case word
        case kw
        case assign
        case controlFlow
        case char
        case glob
        case boolUnary
        case boolBinary
    }

    var kind: Kind {
        switch self {
        case .undefinedTok: return .undefined
        case .unknownTok: return .unknown
        case .eolTok: return .eol
        case .eofReal, .eofRParen, .eofBacktick: return .eof
        case .ignoredLineCont, .ignoredSpace, .ignoredComment: return .ignored
        case .wsSpace: return .ws
        case .litChars, .litVarLike, .litOther, .litEscapedChar, .litLBrace, .litRBrace, .litComma,
             .litDRightBracket, .litTilde, .litPound, .litSlash, .litPercent, .litDigits, .litAt,
             .litArithVarLike: return .lit
        case .opNewline, .opAmp, .opPipe, .opPipeAmp, .opDAmp, .opDPipe, .opSemi, .opDSemi,
             .opLParen, .opRParen, .opDLeftParen, .opDRightParen: return .op
        case .redirLess, .redirGreat, .redirDLess, .redirTLess, .redirDGreat, .redirGreatAnd,
             .redirLessAnd, .redirDLessDash, .redirLessGreat, .redirClobber, .redirAndGreat,
             .redirAndDGreat: return .redir
        case .leftDoubleQuote, .leftSingleQuote, .leftBacktick, .leftCommandSub, .leftVarSub,
             .leftArithSub, .leftArithSub2, .leftDollarDoubleQuote, .leftDollarSingleQuote,
             .leftProcSubIn, .leftProcSubOut: return .left
        case .rightDoubleQuote, .rightSingleQuote, .rightBacktick, .rightCommandSub, .rightVarSub,
             .rightArithSub, .rightDollarDoubleQuote, .rightDollarSingleQuote, .rightSubshell,
             .rightFuncDef, .rightCasePat, .rightArrayLiteral, .rightExtGlob: return .right
        case .extGlobAt, .extGlobStar, .extGlobPlus, .extGlobQMark, .extGlobBang: return .extGlob
        case .vSubName, .vSubNumber, .vSubBang, .vSubAt, .vSubPound, .vSubDollar, .vSubStar,
             .vSubHyphen, .vSubQMark: return .vSub
        case .vTestColonHyphen, .vTestHyphen, .vTestColonEquals, .vTestEquals, .vTestColonQMark,
             .vTestQMark, .vTestColonPlus, .vTestPlus: return .vTest
        case .vOp1Percent, .vOp1DPercent, .vOp1Pound, .vOp1DPound, .vOp1Caret, .vOp1DCaret,
             .vOp1Comma, .vOp1DComma: return .vOp1
        case .vOp2Slash, .vOp2Colon, .vOp2LBracket, .vOp2RBracket: return .vOp2
        case .arithSemi, .arithComma, .arithPlus, .arithMinus, .arithStar, .arithSlash,
             .arithPercent, .arithDPlus, .arithDMinus, .arithDStar, .arithLParen, .arithRParen,
             .arithLBracket, .arithRBracket, .arithRBrace, .arithQMark, .arithColon,
             .arithLessEqual, .arithLess, .arithGreatEqual, .arithGreat, .arithDEqual, .arithNEqual,
             .arithDAmp, .arithDPipe, .arithBang, .arithDGreat, .arithDLess, .arithAmp, .arithPipe,
             .arithCaret, .arithTilde, .arithEqual, .arithPlusEqual, .arithMinusEqual,
             .arithStarEqual, .arithSlashEqual, .arithPercentEqual, .arithDGreatEqual,
             .arithDLessEqual, .arithAmpEqual, .arithPipeEqual, .arithCaretEqual: return .arith
        case .nodePostDPlus, .nodePostDMinus, .nodeUnaryPlus, .nodeUnaryMinus, .nodeArithVar,
             .nodeCommand, .nodeAssign, .nodeAndOr, .nodeBlock, .nodeSubshell, .nodeFork,
             .nodeFuncDef, .nodeForEach, .nodeForExpr, .nodeNoOp, .nodeUnaryExpr, .nodeBinaryExpr,
             .nodeTernaryExpr, .nodeFuncCall, .nodeConstInt: return .node
        case .wordCompound: return .word
        case .kwDLeftBracket, .kwBang, .kwFor, .kwWhile, .kwUntil, .kwDo, .kwDone, .kwIn, .kwCase,
             .kwEsac, .kwIf, .kwFi, .kwThen, .kwElse, .kwElif, .kwFunction, .kwTime: return .kw
        case .assignDeclare, .assignTypeset, .assignLocal, .assignReadonly, .assignNone:
            return .assign
        case .controlFlowBreak, .controlFlowContinue, .controlFlowReturn, .controlFlowExit:
            return .controlFlow
        case .charOneChar, .charStop, .charHex, .charOctal3, .charOctal4, .charUnicode4,
             .charUnicode8, .charLiterals, .charBadBackslash: return .char
        case .globLBracket, .globRBracket, .globStar, .globQMark, .globBang, .globCaret,
             .globEscapedChar, .globBadBackslash, .globCleanLiterals, .globOtherLiteral,
             .globEof: return .glob
        case .boolUnaryo, .boolUnaryt, .boolUnaryv, .boolUnaryR, .boolUnarya, .boolUnaryb,
             .boolUnaryc, .boolUnaryd, .boolUnarye, .boolUnaryf, .boolUnaryg, .boolUnaryh,
             .boolUnaryL, .boolUnaryp, .boolUnaryr, .boolUnarys, .boolUnaryS, .boolUnaryu,
             .boolUnaryw, .boolUnaryx, .boolUnaryO, .boolUnaryG, .boolUnaryN, .boolUnaryz,
             .boolUnaryn: return .boolUnary
        case .boolBinaryeq, .boolBinaryne, .boolBinarygt, .boolBinaryge, .boolBinarylt,
             .boolBinaryle, .boolBinaryef, .boolBinarynt, .boolBinaryot, .boolBinaryGlobEqual,
             .boolBinaryGlobDEqual, .boolBinaryGlobNEqual, .boolBinaryEqualTilde, .boolBinaryEqual,
             .boolBinaryDEqual, .boolBinaryNEqual: return .boolBinary
        }
    }
}
