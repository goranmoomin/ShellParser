
import Foundation

struct BracedStep {
    var val: Int
    var negated: Int
}

indirect enum BracketOp {
    struct WholeArray {
        var op: Id
    }
    case wholeArray(WholeArray)
    static func wholeArray(op: Id) -> Self {
        .wholeArray(WholeArray(op: op))
    }
    static func wholeArray(_ wholeArray: WholeArray?) -> Self? {
        guard let wholeArray = wholeArray else { return nil }
        return .wholeArray(wholeArray)
    }
    struct ArrayIndex {
        var expr: ArithExpr
    }
    case arrayIndex(ArrayIndex)
    static func arrayIndex(expr: ArithExpr) -> Self {
        .arrayIndex(ArrayIndex(expr: expr))
    }
    static func arrayIndex(_ arrayIndex: ArrayIndex?) -> Self? {
        guard let arrayIndex = arrayIndex else { return nil }
        return .arrayIndex(arrayIndex)
    }
}

indirect enum SuffixOp {
    struct StringUnary {
        var op: Id
        var argWord: Word
    }
    case stringUnary(StringUnary)
    static func stringUnary(op: Id, argWord: Word) -> Self {
        .stringUnary(StringUnary(op: op, argWord: argWord))
    }
    static func stringUnary(_ stringUnary: StringUnary?) -> Self? {
        guard let stringUnary = stringUnary else { return nil }
        return .stringUnary(stringUnary)
    }
    struct PatSub {
        var pat: Word
        var replace: Word?
        var doAll: Bool
        var doPrefix: Bool
        var doSuffix: Bool
    }
    case patSub(PatSub)
    static func patSub(pat: Word, replace: Word? = nil, doAll: Bool, doPrefix: Bool, doSuffix: Bool) -> Self {
        .patSub(PatSub(pat: pat, replace: replace, doAll: doAll, doPrefix: doPrefix, doSuffix: doSuffix))
    }
    static func patSub(_ patSub: PatSub?) -> Self? {
        guard let patSub = patSub else { return nil }
        return .patSub(patSub)
    }
    struct Slice {
        var begin: ArithExpr?
        var length: ArithExpr?
    }
    case slice(Slice)
    static func slice(begin: ArithExpr? = nil, length: ArithExpr? = nil) -> Self {
        .slice(Slice(begin: begin, length: length))
    }
    static func slice(_ slice: Slice?) -> Self? {
        guard let slice = slice else { return nil }
        return .slice(slice)
    }
}

indirect enum ArrayItem {
    struct ArrayWord {
        var w: Word
    }
    case arrayWord(ArrayWord)
    static func arrayWord(w: Word) -> Self {
        .arrayWord(ArrayWord(w: w))
    }
    static func arrayWord(_ arrayWord: ArrayWord?) -> Self? {
        guard let arrayWord = arrayWord else { return nil }
        return .arrayWord(arrayWord)
    }
    struct ArrayPair {
        var key: Word
        var value: Word
    }
    case arrayPair(ArrayPair)
    static func arrayPair(key: Word, value: Word) -> Self {
        .arrayPair(ArrayPair(key: key, value: value))
    }
    static func arrayPair(_ arrayPair: ArrayPair?) -> Self? {
        guard let arrayPair = arrayPair else { return nil }
        return .arrayPair(arrayPair)
    }
}

indirect enum WordPart {
    struct ArrayLiteralPart {
        var words: [Word]
    }
    case arrayLiteralPart(ArrayLiteralPart)
    static func arrayLiteralPart(words: [Word]) -> Self {
        .arrayLiteralPart(ArrayLiteralPart(words: words))
    }
    static func arrayLiteralPart(_ arrayLiteralPart: ArrayLiteralPart?) -> Self? {
        guard let arrayLiteralPart = arrayLiteralPart else { return nil }
        return .arrayLiteralPart(arrayLiteralPart)
    }
    struct LiteralPart {
        var token: Token
    }
    case literalPart(LiteralPart)
    static func literalPart(token: Token) -> Self {
        .literalPart(LiteralPart(token: token))
    }
    static func literalPart(_ literalPart: LiteralPart?) -> Self? {
        guard let literalPart = literalPart else { return nil }
        return .literalPart(literalPart)
    }
    struct EscapedLiteralPart {
        var token: Token
    }
    case escapedLiteralPart(EscapedLiteralPart)
    static func escapedLiteralPart(token: Token) -> Self {
        .escapedLiteralPart(EscapedLiteralPart(token: token))
    }
    static func escapedLiteralPart(_ escapedLiteralPart: EscapedLiteralPart?) -> Self? {
        guard let escapedLiteralPart = escapedLiteralPart else { return nil }
        return .escapedLiteralPart(escapedLiteralPart)
    }
    case emptyPart
    struct SingleQuotedPart {
        var left: Token
        var tokens: [Token]
    }
    case singleQuotedPart(SingleQuotedPart)
    static func singleQuotedPart(left: Token, tokens: [Token]) -> Self {
        .singleQuotedPart(SingleQuotedPart(left: left, tokens: tokens))
    }
    static func singleQuotedPart(_ singleQuotedPart: SingleQuotedPart?) -> Self? {
        guard let singleQuotedPart = singleQuotedPart else { return nil }
        return .singleQuotedPart(singleQuotedPart)
    }
    struct DoubleQuotedPart {
        var parts: [WordPart]
    }
    case doubleQuotedPart(DoubleQuotedPart)
    static func doubleQuotedPart(parts: [WordPart]) -> Self {
        .doubleQuotedPart(DoubleQuotedPart(parts: parts))
    }
    static func doubleQuotedPart(_ doubleQuotedPart: DoubleQuotedPart?) -> Self? {
        guard let doubleQuotedPart = doubleQuotedPart else { return nil }
        return .doubleQuotedPart(doubleQuotedPart)
    }
    struct SimpleVarSub {
        var token: Token
    }
    case simpleVarSub(SimpleVarSub)
    static func simpleVarSub(token: Token) -> Self {
        .simpleVarSub(SimpleVarSub(token: token))
    }
    static func simpleVarSub(_ simpleVarSub: SimpleVarSub?) -> Self? {
        guard let simpleVarSub = simpleVarSub else { return nil }
        return .simpleVarSub(simpleVarSub)
    }
    struct BracedVarSub {
        var token: Token
        var prefixOp: Id?
        var bracketOp: BracketOp?
        var suffixOp: SuffixOp?
    }
    case bracedVarSub(BracedVarSub)
    static func bracedVarSub(token: Token, prefixOp: Id? = nil, bracketOp: BracketOp? = nil, suffixOp: SuffixOp? = nil) -> Self {
        .bracedVarSub(BracedVarSub(token: token, prefixOp: prefixOp, bracketOp: bracketOp, suffixOp: suffixOp))
    }
    static func bracedVarSub(_ bracedVarSub: BracedVarSub?) -> Self? {
        guard let bracedVarSub = bracedVarSub else { return nil }
        return .bracedVarSub(bracedVarSub)
    }
    struct TildeSubPart {
        var prefix: String
    }
    case tildeSubPart(TildeSubPart)
    static func tildeSubPart(prefix: String) -> Self {
        .tildeSubPart(TildeSubPart(prefix: prefix))
    }
    static func tildeSubPart(_ tildeSubPart: TildeSubPart?) -> Self? {
        guard let tildeSubPart = tildeSubPart else { return nil }
        return .tildeSubPart(tildeSubPart)
    }
    struct CommandSubPart {
        var commandList: Command
        var leftToken: Token
    }
    case commandSubPart(CommandSubPart)
    static func commandSubPart(commandList: Command, leftToken: Token) -> Self {
        .commandSubPart(CommandSubPart(commandList: commandList, leftToken: leftToken))
    }
    static func commandSubPart(_ commandSubPart: CommandSubPart?) -> Self? {
        guard let commandSubPart = commandSubPart else { return nil }
        return .commandSubPart(commandSubPart)
    }
    struct ArithSubPart {
        var anode: ArithExpr
    }
    case arithSubPart(ArithSubPart)
    static func arithSubPart(anode: ArithExpr) -> Self {
        .arithSubPart(ArithSubPart(anode: anode))
    }
    static func arithSubPart(_ arithSubPart: ArithSubPart?) -> Self? {
        guard let arithSubPart = arithSubPart else { return nil }
        return .arithSubPart(arithSubPart)
    }
    struct BracedAltPart {
        var words: [Word]
    }
    case bracedAltPart(BracedAltPart)
    static func bracedAltPart(words: [Word]) -> Self {
        .bracedAltPart(BracedAltPart(words: words))
    }
    static func bracedAltPart(_ bracedAltPart: BracedAltPart?) -> Self? {
        guard let bracedAltPart = bracedAltPart else { return nil }
        return .bracedAltPart(bracedAltPart)
    }
    struct BracedIntRangePart {
        var start: Int
        var end: Int
        var step: BracedStep?
    }
    case bracedIntRangePart(BracedIntRangePart)
    static func bracedIntRangePart(start: Int, end: Int, step: BracedStep? = nil) -> Self {
        .bracedIntRangePart(BracedIntRangePart(start: start, end: end, step: step))
    }
    static func bracedIntRangePart(_ bracedIntRangePart: BracedIntRangePart?) -> Self? {
        guard let bracedIntRangePart = bracedIntRangePart else { return nil }
        return .bracedIntRangePart(bracedIntRangePart)
    }
    struct BracedCharRangePart {
        var start: String
        var end: String
        var step: BracedStep?
    }
    case bracedCharRangePart(BracedCharRangePart)
    static func bracedCharRangePart(start: String, end: String, step: BracedStep? = nil) -> Self {
        .bracedCharRangePart(BracedCharRangePart(start: start, end: end, step: step))
    }
    static func bracedCharRangePart(_ bracedCharRangePart: BracedCharRangePart?) -> Self? {
        guard let bracedCharRangePart = bracedCharRangePart else { return nil }
        return .bracedCharRangePart(bracedCharRangePart)
    }
    struct ExtGlobPart {
        var op: Token
        var arms: [Word]
    }
    case extGlobPart(ExtGlobPart)
    static func extGlobPart(op: Token, arms: [Word]) -> Self {
        .extGlobPart(ExtGlobPart(op: op, arms: arms))
    }
    static func extGlobPart(_ extGlobPart: ExtGlobPart?) -> Self? {
        guard let extGlobPart = extGlobPart else { return nil }
        return .extGlobPart(extGlobPart)
    }
}

indirect enum Word {
    struct TokenWord {
        var token: Token
    }
    case tokenWord(TokenWord)
    static func tokenWord(token: Token) -> Self {
        .tokenWord(TokenWord(token: token))
    }
    static func tokenWord(_ tokenWord: TokenWord?) -> Self? {
        guard let tokenWord = tokenWord else { return nil }
        return .tokenWord(tokenWord)
    }
    struct CompoundWord {
        var parts: [WordPart]
    }
    case compoundWord(CompoundWord)
    static func compoundWord(parts: [WordPart]) -> Self {
        .compoundWord(CompoundWord(parts: parts))
    }
    static func compoundWord(_ compoundWord: CompoundWord?) -> Self? {
        guard let compoundWord = compoundWord else { return nil }
        return .compoundWord(compoundWord)
    }
    struct BracedWordTree {
        var parts: [WordPart]
    }
    case bracedWordTree(BracedWordTree)
    static func bracedWordTree(parts: [WordPart]) -> Self {
        .bracedWordTree(BracedWordTree(parts: parts))
    }
    static func bracedWordTree(_ bracedWordTree: BracedWordTree?) -> Self? {
        guard let bracedWordTree = bracedWordTree else { return nil }
        return .bracedWordTree(bracedWordTree)
    }
    struct StringWord {
        var id: Id
        var s: String
    }
    case stringWord(StringWord)
    static func stringWord(id: Id, s: String) -> Self {
        .stringWord(StringWord(id: id, s: s))
    }
    static func stringWord(_ stringWord: StringWord?) -> Self? {
        guard let stringWord = stringWord else { return nil }
        return .stringWord(stringWord)
    }
}

indirect enum LhsExpr {
    struct LhsName {
        var name: String
    }
    case lhsName(LhsName)
    static func lhsName(name: String) -> Self {
        .lhsName(LhsName(name: name))
    }
    static func lhsName(_ lhsName: LhsName?) -> Self? {
        guard let lhsName = lhsName else { return nil }
        return .lhsName(lhsName)
    }
    struct LhsIndexedName {
        var name: String
        var index: ArithExpr
    }
    case lhsIndexedName(LhsIndexedName)
    static func lhsIndexedName(name: String, index: ArithExpr) -> Self {
        .lhsIndexedName(LhsIndexedName(name: name, index: index))
    }
    static func lhsIndexedName(_ lhsIndexedName: LhsIndexedName?) -> Self? {
        guard let lhsIndexedName = lhsIndexedName else { return nil }
        return .lhsIndexedName(lhsIndexedName)
    }
}

indirect enum ArithExpr {
    struct ArithVarRef {
        var name: String
    }
    case arithVarRef(ArithVarRef)
    static func arithVarRef(name: String) -> Self {
        .arithVarRef(ArithVarRef(name: name))
    }
    static func arithVarRef(_ arithVarRef: ArithVarRef?) -> Self? {
        guard let arithVarRef = arithVarRef else { return nil }
        return .arithVarRef(arithVarRef)
    }
    struct ArithWord {
        var w: Word
    }
    case arithWord(ArithWord)
    static func arithWord(w: Word) -> Self {
        .arithWord(ArithWord(w: w))
    }
    static func arithWord(_ arithWord: ArithWord?) -> Self? {
        guard let arithWord = arithWord else { return nil }
        return .arithWord(arithWord)
    }
    struct UnaryAssign {
        var op: Id
        var child: LhsExpr
    }
    case unaryAssign(UnaryAssign)
    static func unaryAssign(op: Id, child: LhsExpr) -> Self {
        .unaryAssign(UnaryAssign(op: op, child: child))
    }
    static func unaryAssign(_ unaryAssign: UnaryAssign?) -> Self? {
        guard let unaryAssign = unaryAssign else { return nil }
        return .unaryAssign(unaryAssign)
    }
    struct BinaryAssign {
        var op: Id
        var left: LhsExpr
        var right: ArithExpr
    }
    case binaryAssign(BinaryAssign)
    static func binaryAssign(op: Id, left: LhsExpr, right: ArithExpr) -> Self {
        .binaryAssign(BinaryAssign(op: op, left: left, right: right))
    }
    static func binaryAssign(_ binaryAssign: BinaryAssign?) -> Self? {
        guard let binaryAssign = binaryAssign else { return nil }
        return .binaryAssign(binaryAssign)
    }
    struct ArithUnary {
        var op: Id
        var child: ArithExpr
    }
    case arithUnary(ArithUnary)
    static func arithUnary(op: Id, child: ArithExpr) -> Self {
        .arithUnary(ArithUnary(op: op, child: child))
    }
    static func arithUnary(_ arithUnary: ArithUnary?) -> Self? {
        guard let arithUnary = arithUnary else { return nil }
        return .arithUnary(arithUnary)
    }
    struct ArithBinary {
        var op: Id
        var left: ArithExpr
        var right: ArithExpr
    }
    case arithBinary(ArithBinary)
    static func arithBinary(op: Id, left: ArithExpr, right: ArithExpr) -> Self {
        .arithBinary(ArithBinary(op: op, left: left, right: right))
    }
    static func arithBinary(_ arithBinary: ArithBinary?) -> Self? {
        guard let arithBinary = arithBinary else { return nil }
        return .arithBinary(arithBinary)
    }
    struct TernaryOp {
        var cond: ArithExpr
        var trueExpr: ArithExpr
        var falseExpr: ArithExpr
    }
    case ternaryOp(TernaryOp)
    static func ternaryOp(cond: ArithExpr, trueExpr: ArithExpr, falseExpr: ArithExpr) -> Self {
        .ternaryOp(TernaryOp(cond: cond, trueExpr: trueExpr, falseExpr: falseExpr))
    }
    static func ternaryOp(_ ternaryOp: TernaryOp?) -> Self? {
        guard let ternaryOp = ternaryOp else { return nil }
        return .ternaryOp(ternaryOp)
    }
    struct FuncCall {
        var `func`: ArithExpr
        var args: [ArithExpr]
    }
    case funcCall(FuncCall)
    static func funcCall(`func`: ArithExpr, args: [ArithExpr]) -> Self {
        .funcCall(FuncCall(func: `func`, args: args))
    }
    static func funcCall(_ funcCall: FuncCall?) -> Self? {
        guard let funcCall = funcCall else { return nil }
        return .funcCall(funcCall)
    }
}

indirect enum BoolExpr {
    struct WordTest {
        var w: Word
    }
    case wordTest(WordTest)
    static func wordTest(w: Word) -> Self {
        .wordTest(WordTest(w: w))
    }
    static func wordTest(_ wordTest: WordTest?) -> Self? {
        guard let wordTest = wordTest else { return nil }
        return .wordTest(wordTest)
    }
    struct BoolBinary {
        var op: Id
        var left: Word
        var right: Word
    }
    case boolBinary(BoolBinary)
    static func boolBinary(op: Id, left: Word, right: Word) -> Self {
        .boolBinary(BoolBinary(op: op, left: left, right: right))
    }
    static func boolBinary(_ boolBinary: BoolBinary?) -> Self? {
        guard let boolBinary = boolBinary else { return nil }
        return .boolBinary(boolBinary)
    }
    struct BoolUnary {
        var op: Id
        var child: Word
    }
    case boolUnary(BoolUnary)
    static func boolUnary(op: Id, child: Word) -> Self {
        .boolUnary(BoolUnary(op: op, child: child))
    }
    static func boolUnary(_ boolUnary: BoolUnary?) -> Self? {
        guard let boolUnary = boolUnary else { return nil }
        return .boolUnary(boolUnary)
    }
    struct LogicalNot {
        var child: BoolExpr
    }
    case logicalNot(LogicalNot)
    static func logicalNot(child: BoolExpr) -> Self {
        .logicalNot(LogicalNot(child: child))
    }
    static func logicalNot(_ logicalNot: LogicalNot?) -> Self? {
        guard let logicalNot = logicalNot else { return nil }
        return .logicalNot(logicalNot)
    }
    struct LogicalAnd {
        var left: BoolExpr
        var right: BoolExpr
    }
    case logicalAnd(LogicalAnd)
    static func logicalAnd(left: BoolExpr, right: BoolExpr) -> Self {
        .logicalAnd(LogicalAnd(left: left, right: right))
    }
    static func logicalAnd(_ logicalAnd: LogicalAnd?) -> Self? {
        guard let logicalAnd = logicalAnd else { return nil }
        return .logicalAnd(logicalAnd)
    }
    struct LogicalOr {
        var left: BoolExpr
        var right: BoolExpr
    }
    case logicalOr(LogicalOr)
    static func logicalOr(left: BoolExpr, right: BoolExpr) -> Self {
        .logicalOr(LogicalOr(left: left, right: right))
    }
    static func logicalOr(_ logicalOr: LogicalOr?) -> Self? {
        guard let logicalOr = logicalOr else { return nil }
        return .logicalOr(logicalOr)
    }
}

indirect enum Redir {
    struct Redir {
        var op: Id
        var fd: Int
        var argWord: Word
    }
    case redir(Redir)
    static func redir(op: Id, fd: Int, argWord: Word) -> Self {
        .redir(Redir(op: op, fd: fd, argWord: argWord))
    }
    static func redir(_ redir: Redir?) -> Self? {
        guard let redir = redir else { return nil }
        return .redir(redir)
    }
    struct HereDoc {
        var op: Id
        var fd: Int
        var body: Word?
        var doExpansion: Int
        var hereEnd: String
        var wasFilled: Bool
    }
    case hereDoc(HereDoc)
    static func hereDoc(op: Id, fd: Int, body: Word? = nil, doExpansion: Int, hereEnd: String, wasFilled: Bool) -> Self {
        .hereDoc(HereDoc(op: op, fd: fd, body: body, doExpansion: doExpansion, hereEnd: hereEnd, wasFilled: wasFilled))
    }
    static func hereDoc(_ hereDoc: HereDoc?) -> Self? {
        guard let hereDoc = hereDoc else { return nil }
        return .hereDoc(hereDoc)
    }
}

enum AssignOp {
    case equal
    case plusEqual
}

struct AssignPair {
    var lhs: LhsExpr
    var op: AssignOp
    var rhs: Word?
}

struct EnvPair {
    var name: String
    var val: Word
}

struct CaseArm {
    var patList: [Word]
    var action: [Command]
}

struct IfArm {
    var cond: [Command]
    var action: [Command]
}

indirect enum Iterable {
    case iterArgv
    struct IterArray {
        var words: [Word]
    }
    case iterArray(IterArray)
    static func iterArray(words: [Word]) -> Self {
        .iterArray(IterArray(words: words))
    }
    static func iterArray(_ iterArray: IterArray?) -> Self? {
        guard let iterArray = iterArray else { return nil }
        return .iterArray(iterArray)
    }
}

indirect enum Command {
    case noOp
    struct SimpleCommand {
        var words: [Word]
        var redirects: [Redir]
        var moreEnv: [EnvPair]
    }
    case simpleCommand(SimpleCommand)
    static func simpleCommand(words: [Word], redirects: [Redir], moreEnv: [EnvPair]) -> Self {
        .simpleCommand(SimpleCommand(words: words, redirects: redirects, moreEnv: moreEnv))
    }
    static func simpleCommand(_ simpleCommand: SimpleCommand?) -> Self? {
        guard let simpleCommand = simpleCommand else { return nil }
        return .simpleCommand(simpleCommand)
    }
    struct Sentence {
        var child: Command
        var terminator: Token
    }
    case sentence(Sentence)
    static func sentence(child: Command, terminator: Token) -> Self {
        .sentence(Sentence(child: child, terminator: terminator))
    }
    static func sentence(_ sentence: Sentence?) -> Self? {
        guard let sentence = sentence else { return nil }
        return .sentence(sentence)
    }
    struct Assignment {
        var keyword: Id
        var flags: [String]
        var pairs: [AssignPair]
    }
    case assignment(Assignment)
    static func assignment(keyword: Id, flags: [String], pairs: [AssignPair]) -> Self {
        .assignment(Assignment(keyword: keyword, flags: flags, pairs: pairs))
    }
    static func assignment(_ assignment: Assignment?) -> Self? {
        guard let assignment = assignment else { return nil }
        return .assignment(assignment)
    }
    struct ControlFlow {
        var token: Token
        var argWord: Word?
    }
    case controlFlow(ControlFlow)
    static func controlFlow(token: Token, argWord: Word? = nil) -> Self {
        .controlFlow(ControlFlow(token: token, argWord: argWord))
    }
    static func controlFlow(_ controlFlow: ControlFlow?) -> Self? {
        guard let controlFlow = controlFlow else { return nil }
        return .controlFlow(controlFlow)
    }
    struct Pipeline {
        var children: [Command]
        var negated: Bool
        var stderrIndices: [Int]
    }
    case pipeline(Pipeline)
    static func pipeline(children: [Command], negated: Bool, stderrIndices: [Int]) -> Self {
        .pipeline(Pipeline(children: children, negated: negated, stderrIndices: stderrIndices))
    }
    static func pipeline(_ pipeline: Pipeline?) -> Self? {
        guard let pipeline = pipeline else { return nil }
        return .pipeline(pipeline)
    }
    struct AndOr {
        var ops: [Id]
        var children: [Command]
    }
    case andOr(AndOr)
    static func andOr(ops: [Id], children: [Command]) -> Self {
        .andOr(AndOr(ops: ops, children: children))
    }
    static func andOr(_ andOr: AndOr?) -> Self? {
        guard let andOr = andOr else { return nil }
        return .andOr(andOr)
    }
    struct DoGroup {
        var children: [Command]
        var redirects: [Redir]
    }
    case doGroup(DoGroup)
    static func doGroup(children: [Command], redirects: [Redir]) -> Self {
        .doGroup(DoGroup(children: children, redirects: redirects))
    }
    static func doGroup(_ doGroup: DoGroup?) -> Self? {
        guard let doGroup = doGroup else { return nil }
        return .doGroup(doGroup)
    }
    struct BraceGroup {
        var children: [Command]
        var redirects: [Redir]
    }
    case braceGroup(BraceGroup)
    static func braceGroup(children: [Command], redirects: [Redir]) -> Self {
        .braceGroup(BraceGroup(children: children, redirects: redirects))
    }
    static func braceGroup(_ braceGroup: BraceGroup?) -> Self? {
        guard let braceGroup = braceGroup else { return nil }
        return .braceGroup(braceGroup)
    }
    struct Subshell {
        var child: Command
        var redirects: [Redir]
    }
    case subshell(Subshell)
    static func subshell(child: Command, redirects: [Redir]) -> Self {
        .subshell(Subshell(child: child, redirects: redirects))
    }
    static func subshell(_ subshell: Subshell?) -> Self? {
        guard let subshell = subshell else { return nil }
        return .subshell(subshell)
    }
    struct DParen {
        var child: ArithExpr
        var redirects: [Redir]
    }
    case dParen(DParen)
    static func dParen(child: ArithExpr, redirects: [Redir]) -> Self {
        .dParen(DParen(child: child, redirects: redirects))
    }
    static func dParen(_ dParen: DParen?) -> Self? {
        guard let dParen = dParen else { return nil }
        return .dParen(dParen)
    }
    struct DBracket {
        var expr: BoolExpr
        var redirects: [Redir]
    }
    case dBracket(DBracket)
    static func dBracket(expr: BoolExpr, redirects: [Redir]) -> Self {
        .dBracket(DBracket(expr: expr, redirects: redirects))
    }
    static func dBracket(_ dBracket: DBracket?) -> Self? {
        guard let dBracket = dBracket else { return nil }
        return .dBracket(dBracket)
    }
    struct ForEach {
        var iterName: String
        var iterWords: [Word]
        var doArgIter: Bool
        var body: Command
        var redirects: [Redir]
    }
    case forEach(ForEach)
    static func forEach(iterName: String, iterWords: [Word], doArgIter: Bool, body: Command, redirects: [Redir]) -> Self {
        .forEach(ForEach(iterName: iterName, iterWords: iterWords, doArgIter: doArgIter, body: body, redirects: redirects))
    }
    static func forEach(_ forEach: ForEach?) -> Self? {
        guard let forEach = forEach else { return nil }
        return .forEach(forEach)
    }
    struct ForExpr {
        var `init`: ArithExpr?
        var cond: ArithExpr?
        var update: ArithExpr?
        var body: Command?
        var redirects: [Redir]
    }
    case forExpr(ForExpr)
    static func forExpr(`init`: ArithExpr? = nil, cond: ArithExpr? = nil, update: ArithExpr? = nil, body: Command? = nil, redirects: [Redir]) -> Self {
        .forExpr(ForExpr(init: `init`, cond: cond, update: update, body: body, redirects: redirects))
    }
    static func forExpr(_ forExpr: ForExpr?) -> Self? {
        guard let forExpr = forExpr else { return nil }
        return .forExpr(forExpr)
    }
    struct While {
        var cond: [Command]
        var body: Command
        var redirects: [Redir]
    }
    case `while`(While)
    static func `while`(cond: [Command], body: Command, redirects: [Redir]) -> Self {
        .while(While(cond: cond, body: body, redirects: redirects))
    }
    static func `while`(_ while: While?) -> Self? {
        guard let `while` = `while` else { return nil }
        return .while(`while`)
    }
    struct Until {
        var cond: [Command]
        var body: Command
        var redirects: [Redir]
    }
    case until(Until)
    static func until(cond: [Command], body: Command, redirects: [Redir]) -> Self {
        .until(Until(cond: cond, body: body, redirects: redirects))
    }
    static func until(_ until: Until?) -> Self? {
        guard let until = until else { return nil }
        return .until(until)
    }
    struct If {
        var arms: [IfArm]
        var elseAction: [Command]
        var redirects: [Redir]
    }
    case `if`(If)
    static func `if`(arms: [IfArm], elseAction: [Command], redirects: [Redir]) -> Self {
        .if(If(arms: arms, elseAction: elseAction, redirects: redirects))
    }
    static func `if`(_ if: If?) -> Self? {
        guard let `if` = `if` else { return nil }
        return .if(`if`)
    }
    struct Case {
        var toMatch: Word
        var arms: [CaseArm]
        var redirects: [Redir]
    }
    case `case`(Case)
    static func `case`(toMatch: Word, arms: [CaseArm], redirects: [Redir]) -> Self {
        .case(Case(toMatch: toMatch, arms: arms, redirects: redirects))
    }
    static func `case`(_ case: Case?) -> Self? {
        guard let `case` = `case` else { return nil }
        return .case(`case`)
    }
    struct FuncDef {
        var name: String
        var body: Command
        var redirects: [Redir]
    }
    case funcDef(FuncDef)
    static func funcDef(name: String, body: Command, redirects: [Redir]) -> Self {
        .funcDef(FuncDef(name: name, body: body, redirects: redirects))
    }
    static func funcDef(_ funcDef: FuncDef?) -> Self? {
        guard let funcDef = funcDef else { return nil }
        return .funcDef(funcDef)
    }
    struct TimeBlock {
        var pipeline: Command
    }
    case timeBlock(TimeBlock)
    static func timeBlock(pipeline: Command) -> Self {
        .timeBlock(TimeBlock(pipeline: pipeline))
    }
    static func timeBlock(_ timeBlock: TimeBlock?) -> Self? {
        guard let timeBlock = timeBlock else { return nil }
        return .timeBlock(timeBlock)
    }
    struct CommandList {
        var children: [Command]
    }
    case commandList(CommandList)
    static func commandList(children: [Command]) -> Self {
        .commandList(CommandList(children: children))
    }
    static func commandList(_ commandList: CommandList?) -> Self? {
        guard let commandList = commandList else { return nil }
        return .commandList(commandList)
    }
}

indirect enum GlobPart {
    struct GlobLit {
        var id: Id
        var s: String
    }
    case globLit(GlobLit)
    static func globLit(id: Id, s: String) -> Self {
        .globLit(GlobLit(id: id, s: s))
    }
    static func globLit(_ globLit: GlobLit?) -> Self? {
        guard let globLit = globLit else { return nil }
        return .globLit(globLit)
    }
    struct GlobOp {
        var op: Id
    }
    case globOp(GlobOp)
    static func globOp(op: Id) -> Self {
        .globOp(GlobOp(op: op))
    }
    static func globOp(_ globOp: GlobOp?) -> Self? {
        guard let globOp = globOp else { return nil }
        return .globOp(globOp)
    }
    struct CharClass {
        var negated: Bool
        var strs: [String]
    }
    case charClass(CharClass)
    static func charClass(negated: Bool, strs: [String]) -> Self {
        .charClass(CharClass(negated: negated, strs: strs))
    }
    static func charClass(_ charClass: CharClass?) -> Self? {
        guard let charClass = charClass else { return nil }
        return .charClass(charClass)
    }
}
