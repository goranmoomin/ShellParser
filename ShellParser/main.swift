
import Foundation

let reader = StringReader(string: ">out.txt")
let lexer = Lexer(reader: reader)
let wordParser = WordParser(lexer: lexer)
let commandParser = CommandParser(wordParser: wordParser)
print(commandParser.parseSimpleCommand())
