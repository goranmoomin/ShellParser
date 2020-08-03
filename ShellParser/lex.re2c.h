
#ifndef lex_re2c_h
#define lex_re2c_h

#include "id.h"
#include "types.h"

/* Common stuff */

/*!re2c
  re2c:define:YYCTYPE = "char";
  re2c:define:YYCURSOR = p;
  re2c:yyfill:enable = 0;  // generated code doesn't ask for more input
*/

static inline void MatchOshToken(int lex_mode, const char* line, int line_len,
                                 int start_pos, int* id, int* end_pos) {
  assert(start_pos <= line_len);  /* caller should have checked */

  const char* p = line + start_pos;  /* modified by re2c */
  //printf("p: %p q: %p\n", p, q);

  const char* YYMARKER;  /* why do we need this? */
  switch (lex_mode)  {

  case lex_mode__EXTGLOB:
    for (;;) {
      /*!re2c
      "\\" [^\n\x00]                 { *id = id__Lit_EscapedChar; break; }
      "\\\n"                         { *id = id__Ignored_LineCont; break; }
      "`"                            { *id = id__Left_Backtick; break; }
      "$("                           { *id = id__Left_CommandSub; break; }
      "${"                           { *id = id__Left_VarSub; break; }
      "$(("                          { *id = id__Left_ArithSub; break; }
      "$["                           { *id = id__Left_ArithSub2; break; }
      "$" [a-zA-Z_][a-zA-Z0-9_]*     { *id = id__VSub_Name; break; }
      "$" [0-9]                      { *id = id__VSub_Number; break; }
      "$!"                           { *id = id__VSub_Bang; break; }
      "$@"                           { *id = id__VSub_At; break; }
      "$#"                           { *id = id__VSub_Pound; break; }
      "$$"                           { *id = id__VSub_Dollar; break; }
      "$*"                           { *id = id__VSub_Star; break; }
      "$-"                           { *id = id__VSub_Hyphen; break; }
      "$?"                           { *id = id__VSub_QMark; break; }
      "@("                           { *id = id__ExtGlob_At; break; }
      "*("                           { *id = id__ExtGlob_Star; break; }
      "+("                           { *id = id__ExtGlob_Plus; break; }
      "?("                           { *id = id__ExtGlob_QMark; break; }
      "!("                           { *id = id__ExtGlob_Bang; break; }
      [^\\$`"'|)@*+!?\x00]+          { *id = id__Lit_Chars; break; }
      "|"                            { *id = id__Op_Pipe; break; }
      ")"                            { *id = id__Op_RParen; break; }
      [^\x00]                        { *id = id__Lit_Other; break; }
      "\x00"                         { *id = id__Eol_Tok; *end_pos = start_pos; return; }
      */
    }
    break;

  case lex_mode__VS_ARG_UNQ:
    for (;;) {
      /*!re2c
      "\\" [^\n\x00]                 { *id = id__Lit_EscapedChar; break; }
      "\\\n"                         { *id = id__Ignored_LineCont; break; }
      "/"                            { *id = id__Lit_Slash; break; }
      "#"                            { *id = id__Lit_Pound; break; }
      "%"                            { *id = id__Lit_Percent; break; }
      "}"                            { *id = id__Right_VarSub; break; }
      "`"                            { *id = id__Left_Backtick; break; }
      "$("                           { *id = id__Left_CommandSub; break; }
      "${"                           { *id = id__Left_VarSub; break; }
      "$(("                          { *id = id__Left_ArithSub; break; }
      "$["                           { *id = id__Left_ArithSub2; break; }
      "\""                           { *id = id__Left_DoubleQuote; break; }
      "'"                            { *id = id__Left_SingleQuote; break; }
      "$\""                          { *id = id__Left_DollarDoubleQuote; break; }
      "$'"                           { *id = id__Left_DollarSingleQuote; break; }
      "<("                           { *id = id__Left_ProcSubIn; break; }
      ">("                           { *id = id__Left_ProcSubOut; break; }
      "$" [a-zA-Z_][a-zA-Z0-9_]*     { *id = id__VSub_Name; break; }
      "$" [0-9]                      { *id = id__VSub_Number; break; }
      "$!"                           { *id = id__VSub_Bang; break; }
      "$@"                           { *id = id__VSub_At; break; }
      "$#"                           { *id = id__VSub_Pound; break; }
      "$$"                           { *id = id__VSub_Dollar; break; }
      "$*"                           { *id = id__VSub_Star; break; }
      "$-"                           { *id = id__VSub_Hyphen; break; }
      "$?"                           { *id = id__VSub_QMark; break; }
      [^$`/}"'\x00\\#%<>]+           { *id = id__Lit_Chars; break; }
      [^\x00]                        { *id = id__Lit_Other; break; }
      "\x00"                         { *id = id__Eol_Tok; *end_pos = start_pos; return; }
      */
    }
    break;

  case lex_mode__DQ:
    for (;;) {
      /*!re2c
      "\\" [$`"\\]                   { *id = id__Lit_EscapedChar; break; }
      "\\\n"                         { *id = id__Ignored_LineCont; break; }
      "`"                            { *id = id__Left_Backtick; break; }
      "$("                           { *id = id__Left_CommandSub; break; }
      "${"                           { *id = id__Left_VarSub; break; }
      "$(("                          { *id = id__Left_ArithSub; break; }
      "$["                           { *id = id__Left_ArithSub2; break; }
      "$" [a-zA-Z_][a-zA-Z0-9_]*     { *id = id__VSub_Name; break; }
      "$" [0-9]                      { *id = id__VSub_Number; break; }
      "$!"                           { *id = id__VSub_Bang; break; }
      "$@"                           { *id = id__VSub_At; break; }
      "$#"                           { *id = id__VSub_Pound; break; }
      "$$"                           { *id = id__VSub_Dollar; break; }
      "$*"                           { *id = id__VSub_Star; break; }
      "$-"                           { *id = id__VSub_Hyphen; break; }
      "$?"                           { *id = id__VSub_QMark; break; }
      [^$`"\x00\\]+                  { *id = id__Lit_Chars; break; }
      "\""                           { *id = id__Right_DoubleQuote; break; }
      [^\x00]                        { *id = id__Lit_Other; break; }
      "\x00"                         { *id = id__Eol_Tok; *end_pos = start_pos; return; }
      */
    }
    break;

  case lex_mode__SQ:
    for (;;) {
      /*!re2c
      [^'\x00]+                      { *id = id__Lit_Chars; break; }
      "'"                            { *id = id__Right_SingleQuote; break; }
      "\x00"                         { *id = id__Eol_Tok; *end_pos = start_pos; return; }
      */
    }
    break;

  case lex_mode__BASH_REGEX:
    for (;;) {
      /*!re2c
      "("                            { *id = id__Lit_Chars; break; }
      ")"                            { *id = id__Lit_Chars; break; }
      "|"                            { *id = id__Lit_Chars; break; }
      "\\" [^\n\x00]                 { *id = id__Lit_EscapedChar; break; }
      "\\\n"                         { *id = id__Ignored_LineCont; break; }
      "`"                            { *id = id__Left_Backtick; break; }
      "$("                           { *id = id__Left_CommandSub; break; }
      "${"                           { *id = id__Left_VarSub; break; }
      "$(("                          { *id = id__Left_ArithSub; break; }
      "$["                           { *id = id__Left_ArithSub2; break; }
      "\""                           { *id = id__Left_DoubleQuote; break; }
      "'"                            { *id = id__Left_SingleQuote; break; }
      "$\""                          { *id = id__Left_DollarDoubleQuote; break; }
      "$'"                           { *id = id__Left_DollarSingleQuote; break; }
      "<("                           { *id = id__Left_ProcSubIn; break; }
      ">("                           { *id = id__Left_ProcSubOut; break; }
      "$" [a-zA-Z_][a-zA-Z0-9_]*     { *id = id__VSub_Name; break; }
      "$" [0-9]                      { *id = id__VSub_Number; break; }
      "$!"                           { *id = id__VSub_Bang; break; }
      "$@"                           { *id = id__VSub_At; break; }
      "$#"                           { *id = id__VSub_Pound; break; }
      "$$"                           { *id = id__VSub_Dollar; break; }
      "$*"                           { *id = id__VSub_Star; break; }
      "$-"                           { *id = id__VSub_Hyphen; break; }
      "$?"                           { *id = id__VSub_QMark; break; }
      [a-zA-Z0-9_/.\-]+              { *id = id__Lit_Chars; break; }
      [a-zA-Z_][a-zA-Z0-9_]* "+" ? "="  { *id = id__Lit_VarLike; break; }
      "#"                            { *id = id__Lit_Pound; break; }
      "{"                            { *id = id__Lit_LBrace; break; }
      "}"                            { *id = id__Lit_RBrace; break; }
      ","                            { *id = id__Lit_Comma; break; }
      "~"                            { *id = id__Lit_Tilde; break; }
      [ \t\r]+                       { *id = id__WS_Space; break; }
      "\n"                           { *id = id__Op_Newline; break; }
      "&"                            { *id = id__Op_Amp; break; }
      "|&"                           { *id = id__Op_PipeAmp; break; }
      "&&"                           { *id = id__Op_DAmp; break; }
      "||"                           { *id = id__Op_DPipe; break; }
      ";"                            { *id = id__Op_Semi; break; }
      ";;"                           { *id = id__Op_DSemi; break; }
      [0-9]* "<"                     { *id = id__Redir_Less; break; }
      [0-9]* ">"                     { *id = id__Redir_Great; break; }
      [0-9]* "<" "<"                 { *id = id__Redir_DLess; break; }
      [0-9]* "<" "<" "<"             { *id = id__Redir_TLess; break; }
      [0-9]* ">" ">"                 { *id = id__Redir_DGreat; break; }
      [0-9]* "<" "<" "-"             { *id = id__Redir_DLessDash; break; }
      [0-9]* ">" "&"                 { *id = id__Redir_GreatAnd; break; }
      [0-9]* "<" "&"                 { *id = id__Redir_LessAnd; break; }
      [0-9]* "<" ">"                 { *id = id__Redir_LessGreat; break; }
      [0-9]* ">" "|"                 { *id = id__Redir_Clobber; break; }
      [0-9]* "&" ">"                 { *id = id__Redir_AndGreat; break; }
      [0-9]* "&" ">" ">"             { *id = id__Redir_AndDGreat; break; }
      [^\x00]                        { *id = id__Lit_Other; break; }
      "\x00"                         { *id = id__Eol_Tok; *end_pos = start_pos; return; }
      */
    }
    break;

  case lex_mode__VS_ARG_DQ:
    for (;;) {
      /*!re2c
      "\\" [^\n\x00]                 { *id = id__Lit_EscapedChar; break; }
      "\\\n"                         { *id = id__Ignored_LineCont; break; }
      "/"                            { *id = id__Lit_Slash; break; }
      "#"                            { *id = id__Lit_Pound; break; }
      "%"                            { *id = id__Lit_Percent; break; }
      "}"                            { *id = id__Right_VarSub; break; }
      "`"                            { *id = id__Left_Backtick; break; }
      "$("                           { *id = id__Left_CommandSub; break; }
      "${"                           { *id = id__Left_VarSub; break; }
      "$(("                          { *id = id__Left_ArithSub; break; }
      "$["                           { *id = id__Left_ArithSub2; break; }
      "$" [a-zA-Z_][a-zA-Z0-9_]*     { *id = id__VSub_Name; break; }
      "$" [0-9]                      { *id = id__VSub_Number; break; }
      "$!"                           { *id = id__VSub_Bang; break; }
      "$@"                           { *id = id__VSub_At; break; }
      "$#"                           { *id = id__VSub_Pound; break; }
      "$$"                           { *id = id__VSub_Dollar; break; }
      "$*"                           { *id = id__VSub_Star; break; }
      "$-"                           { *id = id__VSub_Hyphen; break; }
      "$?"                           { *id = id__VSub_QMark; break; }
      [^$`/}"\x00\\#%]+              { *id = id__Lit_Chars; break; }
      "\""                           { *id = id__Left_DoubleQuote; break; }
      [^\x00]                        { *id = id__Lit_Other; break; }
      "\x00"                         { *id = id__Eol_Tok; *end_pos = start_pos; return; }
      */
    }
    break;

  case lex_mode__COMMENT:
    for (;;) {
      /*!re2c
      [^\n\x00]*                     { *id = id__Ignored_Comment; break; }
      "\x00"                         { *id = id__Eol_Tok; *end_pos = start_pos; return; }
      */
    }
    break;

  case lex_mode__VS_1:
    for (;;) {
      /*!re2c
      [a-zA-Z_][a-zA-Z0-9_]*         { *id = id__VSub_Name; break; }
      [0-9]+                         { *id = id__VSub_Number; break; }
      "!"                            { *id = id__VSub_Bang; break; }
      "@"                            { *id = id__VSub_At; break; }
      "#"                            { *id = id__VSub_Pound; break; }
      "$"                            { *id = id__VSub_Dollar; break; }
      "*"                            { *id = id__VSub_Star; break; }
      "-"                            { *id = id__VSub_Hyphen; break; }
      "?"                            { *id = id__VSub_QMark; break; }
      "}"                            { *id = id__Right_VarSub; break; }
      "\\\n"                         { *id = id__Ignored_LineCont; break; }
      "\n"                           { *id = id__Unknown_Tok; break; }
      [^\x00]                        { *id = id__Unknown_Tok; break; }
      "\x00"                         { *id = id__Eol_Tok; *end_pos = start_pos; return; }
      */
    }
    break;

  case lex_mode__DBRACKET:
    for (;;) {
      /*!re2c
      "]]"                           { *id = id__Lit_DRightBracket; break; }
      "!"                            { *id = id__KW_Bang; break; }
      "-o"                           { *id = id__BoolUnary_o; break; }
      "-t"                           { *id = id__BoolUnary_t; break; }
      "-v"                           { *id = id__BoolUnary_v; break; }
      "-R"                           { *id = id__BoolUnary_R; break; }
      "-a"                           { *id = id__BoolUnary_a; break; }
      "-b"                           { *id = id__BoolUnary_b; break; }
      "-c"                           { *id = id__BoolUnary_c; break; }
      "-d"                           { *id = id__BoolUnary_d; break; }
      "-e"                           { *id = id__BoolUnary_e; break; }
      "-f"                           { *id = id__BoolUnary_f; break; }
      "-g"                           { *id = id__BoolUnary_g; break; }
      "-h"                           { *id = id__BoolUnary_h; break; }
      "-L"                           { *id = id__BoolUnary_L; break; }
      "-p"                           { *id = id__BoolUnary_p; break; }
      "-r"                           { *id = id__BoolUnary_r; break; }
      "-s"                           { *id = id__BoolUnary_s; break; }
      "-S"                           { *id = id__BoolUnary_S; break; }
      "-u"                           { *id = id__BoolUnary_u; break; }
      "-w"                           { *id = id__BoolUnary_w; break; }
      "-x"                           { *id = id__BoolUnary_x; break; }
      "-O"                           { *id = id__BoolUnary_O; break; }
      "-G"                           { *id = id__BoolUnary_G; break; }
      "-N"                           { *id = id__BoolUnary_N; break; }
      "-z"                           { *id = id__BoolUnary_z; break; }
      "-n"                           { *id = id__BoolUnary_n; break; }
      "-eq"                          { *id = id__BoolBinary_eq; break; }
      "-ne"                          { *id = id__BoolBinary_ne; break; }
      "-gt"                          { *id = id__BoolBinary_gt; break; }
      "-ge"                          { *id = id__BoolBinary_ge; break; }
      "-lt"                          { *id = id__BoolBinary_lt; break; }
      "-le"                          { *id = id__BoolBinary_le; break; }
      "-ef"                          { *id = id__BoolBinary_ef; break; }
      "-nt"                          { *id = id__BoolBinary_nt; break; }
      "-ot"                          { *id = id__BoolBinary_ot; break; }
      "="                            { *id = id__BoolBinary_GlobEqual; break; }
      "=="                           { *id = id__BoolBinary_GlobDEqual; break; }
      "!="                           { *id = id__BoolBinary_GlobNEqual; break; }
      "=~"                           { *id = id__BoolBinary_EqualTilde; break; }
      "\\" [^\n\x00]                 { *id = id__Lit_EscapedChar; break; }
      "\\\n"                         { *id = id__Ignored_LineCont; break; }
      "`"                            { *id = id__Left_Backtick; break; }
      "$("                           { *id = id__Left_CommandSub; break; }
      "${"                           { *id = id__Left_VarSub; break; }
      "$(("                          { *id = id__Left_ArithSub; break; }
      "$["                           { *id = id__Left_ArithSub2; break; }
      "\""                           { *id = id__Left_DoubleQuote; break; }
      "'"                            { *id = id__Left_SingleQuote; break; }
      "$\""                          { *id = id__Left_DollarDoubleQuote; break; }
      "$'"                           { *id = id__Left_DollarSingleQuote; break; }
      "<("                           { *id = id__Left_ProcSubIn; break; }
      ">("                           { *id = id__Left_ProcSubOut; break; }
      "$" [a-zA-Z_][a-zA-Z0-9_]*     { *id = id__VSub_Name; break; }
      "$" [0-9]                      { *id = id__VSub_Number; break; }
      "$!"                           { *id = id__VSub_Bang; break; }
      "$@"                           { *id = id__VSub_At; break; }
      "$#"                           { *id = id__VSub_Pound; break; }
      "$$"                           { *id = id__VSub_Dollar; break; }
      "$*"                           { *id = id__VSub_Star; break; }
      "$-"                           { *id = id__VSub_Hyphen; break; }
      "$?"                           { *id = id__VSub_QMark; break; }
      [a-zA-Z0-9_/.\-]+              { *id = id__Lit_Chars; break; }
      [a-zA-Z_][a-zA-Z0-9_]* "+" ? "="  { *id = id__Lit_VarLike; break; }
      "#"                            { *id = id__Lit_Pound; break; }
      "{"                            { *id = id__Lit_LBrace; break; }
      "}"                            { *id = id__Lit_RBrace; break; }
      ","                            { *id = id__Lit_Comma; break; }
      "~"                            { *id = id__Lit_Tilde; break; }
      [ \t\r]+                       { *id = id__WS_Space; break; }
      "\n"                           { *id = id__Op_Newline; break; }
      "&"                            { *id = id__Op_Amp; break; }
      "|"                            { *id = id__Op_Pipe; break; }
      "|&"                           { *id = id__Op_PipeAmp; break; }
      "&&"                           { *id = id__Op_DAmp; break; }
      "||"                           { *id = id__Op_DPipe; break; }
      ";"                            { *id = id__Op_Semi; break; }
      ";;"                           { *id = id__Op_DSemi; break; }
      "("                            { *id = id__Op_LParen; break; }
      ")"                            { *id = id__Op_RParen; break; }
      [0-9]* "<"                     { *id = id__Redir_Less; break; }
      [0-9]* ">"                     { *id = id__Redir_Great; break; }
      [0-9]* "<" "<"                 { *id = id__Redir_DLess; break; }
      [0-9]* "<" "<" "<"             { *id = id__Redir_TLess; break; }
      [0-9]* ">" ">"                 { *id = id__Redir_DGreat; break; }
      [0-9]* "<" "<" "-"             { *id = id__Redir_DLessDash; break; }
      [0-9]* ">" "&"                 { *id = id__Redir_GreatAnd; break; }
      [0-9]* "<" "&"                 { *id = id__Redir_LessAnd; break; }
      [0-9]* "<" ">"                 { *id = id__Redir_LessGreat; break; }
      [0-9]* ">" "|"                 { *id = id__Redir_Clobber; break; }
      [0-9]* "&" ">"                 { *id = id__Redir_AndGreat; break; }
      [0-9]* "&" ">" ">"             { *id = id__Redir_AndDGreat; break; }
      [^\x00]                        { *id = id__Lit_Other; break; }
      "@("                           { *id = id__ExtGlob_At; break; }
      "*("                           { *id = id__ExtGlob_Star; break; }
      "+("                           { *id = id__ExtGlob_Plus; break; }
      "?("                           { *id = id__ExtGlob_QMark; break; }
      "!("                           { *id = id__ExtGlob_Bang; break; }
      "\x00"                         { *id = id__Eol_Tok; *end_pos = start_pos; return; }
      */
    }
    break;

  case lex_mode__VS_2:
    for (;;) {
      /*!re2c
      ":-"                           { *id = id__VTest_ColonHyphen; break; }
      "-"                            { *id = id__VTest_Hyphen; break; }
      ":="                           { *id = id__VTest_ColonEquals; break; }
      "="                            { *id = id__VTest_Equals; break; }
      ":?"                           { *id = id__VTest_ColonQMark; break; }
      "?"                            { *id = id__VTest_QMark; break; }
      ":+"                           { *id = id__VTest_ColonPlus; break; }
      "+"                            { *id = id__VTest_Plus; break; }
      "%"                            { *id = id__VOp1_Percent; break; }
      "%%"                           { *id = id__VOp1_DPercent; break; }
      "#"                            { *id = id__VOp1_Pound; break; }
      "##"                           { *id = id__VOp1_DPound; break; }
      "^"                            { *id = id__VOp1_Caret; break; }
      "^^"                           { *id = id__VOp1_DCaret; break; }
      ","                            { *id = id__VOp1_Comma; break; }
      ",,"                           { *id = id__VOp1_DComma; break; }
      "/"                            { *id = id__VOp2_Slash; break; }
      ":"                            { *id = id__VOp2_Colon; break; }
      "["                            { *id = id__VOp2_LBracket; break; }
      "]"                            { *id = id__VOp2_RBracket; break; }
      "}"                            { *id = id__Right_VarSub; break; }
      "\\\n"                         { *id = id__Ignored_LineCont; break; }
      "\n"                           { *id = id__Unknown_Tok; break; }
      [^\x00]                        { *id = id__Unknown_Tok; break; }
      "\x00"                         { *id = id__Eol_Tok; *end_pos = start_pos; return; }
      */
    }
    break;

  case lex_mode__ARITH:
    for (;;) {
      /*!re2c
      "`"                            { *id = id__Left_Backtick; break; }
      "$("                           { *id = id__Left_CommandSub; break; }
      "${"                           { *id = id__Left_VarSub; break; }
      "$(("                          { *id = id__Left_ArithSub; break; }
      "$["                           { *id = id__Left_ArithSub2; break; }
      "$" [a-zA-Z_][a-zA-Z0-9_]*     { *id = id__VSub_Name; break; }
      "$" [0-9]                      { *id = id__VSub_Number; break; }
      "$!"                           { *id = id__VSub_Bang; break; }
      "$@"                           { *id = id__VSub_At; break; }
      "$#"                           { *id = id__VSub_Pound; break; }
      "$$"                           { *id = id__VSub_Dollar; break; }
      "$*"                           { *id = id__VSub_Star; break; }
      "$-"                           { *id = id__VSub_Hyphen; break; }
      "$?"                           { *id = id__VSub_QMark; break; }
      "\""                           { *id = id__Left_DoubleQuote; break; }
      "'"                            { *id = id__Left_SingleQuote; break; }
      "$\""                          { *id = id__Left_DollarDoubleQuote; break; }
      "$'"                           { *id = id__Left_DollarSingleQuote; break; }
      "<("                           { *id = id__Left_ProcSubIn; break; }
      ">("                           { *id = id__Left_ProcSubOut; break; }
      [ \t\r\n]+                     { *id = id__Ignored_Space; break; }
      [a-zA-Z_][a-zA-Z0-9_]*         { *id = id__Lit_ArithVarLike; break; }
      [0-9]+                         { *id = id__Lit_Digits; break; }
      "@"                            { *id = id__Lit_At; break; }
      "#"                            { *id = id__Lit_Pound; break; }
      ";"                            { *id = id__Arith_Semi; break; }
      ","                            { *id = id__Arith_Comma; break; }
      "+"                            { *id = id__Arith_Plus; break; }
      "-"                            { *id = id__Arith_Minus; break; }
      "*"                            { *id = id__Arith_Star; break; }
      "/"                            { *id = id__Arith_Slash; break; }
      "%"                            { *id = id__Arith_Percent; break; }
      "++"                           { *id = id__Arith_DPlus; break; }
      "--"                           { *id = id__Arith_DMinus; break; }
      "**"                           { *id = id__Arith_DStar; break; }
      "("                            { *id = id__Arith_LParen; break; }
      ")"                            { *id = id__Arith_RParen; break; }
      "["                            { *id = id__Arith_LBracket; break; }
      "]"                            { *id = id__Arith_RBracket; break; }
      "}"                            { *id = id__Arith_RBrace; break; }
      "?"                            { *id = id__Arith_QMark; break; }
      ":"                            { *id = id__Arith_Colon; break; }
      "<="                           { *id = id__Arith_LessEqual; break; }
      "<"                            { *id = id__Arith_Less; break; }
      ">="                           { *id = id__Arith_GreatEqual; break; }
      ">"                            { *id = id__Arith_Great; break; }
      "=="                           { *id = id__Arith_DEqual; break; }
      "!="                           { *id = id__Arith_NEqual; break; }
      "&&"                           { *id = id__Arith_DAmp; break; }
      "||"                           { *id = id__Arith_DPipe; break; }
      "!"                            { *id = id__Arith_Bang; break; }
      ">>"                           { *id = id__Arith_DGreat; break; }
      "<<"                           { *id = id__Arith_DLess; break; }
      "&"                            { *id = id__Arith_Amp; break; }
      "|"                            { *id = id__Arith_Pipe; break; }
      "^"                            { *id = id__Arith_Caret; break; }
      "~"                            { *id = id__Arith_Tilde; break; }
      "="                            { *id = id__Arith_Equal; break; }
      "+="                           { *id = id__Arith_PlusEqual; break; }
      "-="                           { *id = id__Arith_MinusEqual; break; }
      "*="                           { *id = id__Arith_StarEqual; break; }
      "/="                           { *id = id__Arith_SlashEqual; break; }
      "%="                           { *id = id__Arith_PercentEqual; break; }
      ">>="                          { *id = id__Arith_DGreatEqual; break; }
      "<<="                          { *id = id__Arith_DLessEqual; break; }
      "&="                           { *id = id__Arith_AmpEqual; break; }
      "|="                           { *id = id__Arith_PipeEqual; break; }
      "^="                           { *id = id__Arith_CaretEqual; break; }
      "\\\n"                         { *id = id__Ignored_LineCont; break; }
      [^\x00]                        { *id = id__Unknown_Tok; break; }
      "\x00"                         { *id = id__Eol_Tok; *end_pos = start_pos; return; }
      */
    }
    break;

  case lex_mode__DOLLAR_SQ:
    for (;;) {
      /*!re2c
      "\\" "x" [0-9a-fA-F]{1,2}      { *id = id__Char_Hex; break; }
      "\\" "u" [0-9a-fA-F]{1,4}      { *id = id__Char_Unicode4; break; }
      "\\" "U" [0-9a-fA-F]{1,8}      { *id = id__Char_Unicode8; break; }
      "\\" [0abeEfrtnv\\]            { *id = id__Char_OneChar; break; }
      "\\\n"                         { *id = id__Char_Literals; break; }
      "\\"                           { *id = id__Char_BadBackslash; break; }
      "\\" [0-7]{1,3}                { *id = id__Char_Octal3; break; }
      "\\'"                          { *id = id__Char_OneChar; break; }
      "\\\""                         { *id = id__Char_OneChar; break; }
      [^\\'\x00]+                    { *id = id__Char_Literals; break; }
      "'"                            { *id = id__Right_SingleQuote; break; }
      "\\\x00"                       { *id = id__Unknown_Tok; break; }
      "\x00"                         { *id = id__Eol_Tok; *end_pos = start_pos; return; }
      */
    }
    break;

  case lex_mode__OUTER:
    for (;;) {
      /*!re2c
      "(("                           { *id = id__Op_DLeftParen; break; }
      "[["                           { *id = id__KW_DLeftBracket; break; }
      "!"                            { *id = id__KW_Bang; break; }
      "for"                          { *id = id__KW_For; break; }
      "while"                        { *id = id__KW_While; break; }
      "until"                        { *id = id__KW_Until; break; }
      "do"                           { *id = id__KW_Do; break; }
      "done"                         { *id = id__KW_Done; break; }
      "in"                           { *id = id__KW_In; break; }
      "case"                         { *id = id__KW_Case; break; }
      "esac"                         { *id = id__KW_Esac; break; }
      "if"                           { *id = id__KW_If; break; }
      "fi"                           { *id = id__KW_Fi; break; }
      "then"                         { *id = id__KW_Then; break; }
      "else"                         { *id = id__KW_Else; break; }
      "elif"                         { *id = id__KW_Elif; break; }
      "function"                     { *id = id__KW_Function; break; }
      "time"                         { *id = id__KW_Time; break; }
      "declare"                      { *id = id__Assign_Declare; break; }
      "typeset"                      { *id = id__Assign_Typeset; break; }
      "local"                        { *id = id__Assign_Local; break; }
      "readonly"                     { *id = id__Assign_Readonly; break; }
      "break"                        { *id = id__ControlFlow_Break; break; }
      "continue"                     { *id = id__ControlFlow_Continue; break; }
      "return"                       { *id = id__ControlFlow_Return; break; }
      "exit"                         { *id = id__ControlFlow_Exit; break; }
      "\\" [^\n\x00]                 { *id = id__Lit_EscapedChar; break; }
      "\\\n"                         { *id = id__Ignored_LineCont; break; }
      "`"                            { *id = id__Left_Backtick; break; }
      "$("                           { *id = id__Left_CommandSub; break; }
      "${"                           { *id = id__Left_VarSub; break; }
      "$(("                          { *id = id__Left_ArithSub; break; }
      "$["                           { *id = id__Left_ArithSub2; break; }
      "\""                           { *id = id__Left_DoubleQuote; break; }
      "'"                            { *id = id__Left_SingleQuote; break; }
      "$\""                          { *id = id__Left_DollarDoubleQuote; break; }
      "$'"                           { *id = id__Left_DollarSingleQuote; break; }
      "<("                           { *id = id__Left_ProcSubIn; break; }
      ">("                           { *id = id__Left_ProcSubOut; break; }
      "$" [a-zA-Z_][a-zA-Z0-9_]*     { *id = id__VSub_Name; break; }
      "$" [0-9]                      { *id = id__VSub_Number; break; }
      "$!"                           { *id = id__VSub_Bang; break; }
      "$@"                           { *id = id__VSub_At; break; }
      "$#"                           { *id = id__VSub_Pound; break; }
      "$$"                           { *id = id__VSub_Dollar; break; }
      "$*"                           { *id = id__VSub_Star; break; }
      "$-"                           { *id = id__VSub_Hyphen; break; }
      "$?"                           { *id = id__VSub_QMark; break; }
      [a-zA-Z0-9_/.\-]+              { *id = id__Lit_Chars; break; }
      [a-zA-Z_][a-zA-Z0-9_]* "+" ? "="  { *id = id__Lit_VarLike; break; }
      "#"                            { *id = id__Lit_Pound; break; }
      "{"                            { *id = id__Lit_LBrace; break; }
      "}"                            { *id = id__Lit_RBrace; break; }
      ","                            { *id = id__Lit_Comma; break; }
      "~"                            { *id = id__Lit_Tilde; break; }
      [ \t\r]+                       { *id = id__WS_Space; break; }
      "\n"                           { *id = id__Op_Newline; break; }
      "&"                            { *id = id__Op_Amp; break; }
      "|"                            { *id = id__Op_Pipe; break; }
      "|&"                           { *id = id__Op_PipeAmp; break; }
      "&&"                           { *id = id__Op_DAmp; break; }
      "||"                           { *id = id__Op_DPipe; break; }
      ";"                            { *id = id__Op_Semi; break; }
      ";;"                           { *id = id__Op_DSemi; break; }
      "("                            { *id = id__Op_LParen; break; }
      ")"                            { *id = id__Op_RParen; break; }
      [0-9]* "<"                     { *id = id__Redir_Less; break; }
      [0-9]* ">"                     { *id = id__Redir_Great; break; }
      [0-9]* "<" "<"                 { *id = id__Redir_DLess; break; }
      [0-9]* "<" "<" "<"             { *id = id__Redir_TLess; break; }
      [0-9]* ">" ">"                 { *id = id__Redir_DGreat; break; }
      [0-9]* "<" "<" "-"             { *id = id__Redir_DLessDash; break; }
      [0-9]* ">" "&"                 { *id = id__Redir_GreatAnd; break; }
      [0-9]* "<" "&"                 { *id = id__Redir_LessAnd; break; }
      [0-9]* "<" ">"                 { *id = id__Redir_LessGreat; break; }
      [0-9]* ">" "|"                 { *id = id__Redir_Clobber; break; }
      [0-9]* "&" ">"                 { *id = id__Redir_AndGreat; break; }
      [0-9]* "&" ">" ">"             { *id = id__Redir_AndDGreat; break; }
      [^\x00]                        { *id = id__Lit_Other; break; }
      "@("                           { *id = id__ExtGlob_At; break; }
      "*("                           { *id = id__ExtGlob_Star; break; }
      "+("                           { *id = id__ExtGlob_Plus; break; }
      "?("                           { *id = id__ExtGlob_QMark; break; }
      "!("                           { *id = id__ExtGlob_Bang; break; }
      "\x00"                         { *id = id__Eol_Tok; *end_pos = start_pos; return; }
      */
    }
    break;

  default:
    assert(0);

  }
  *end_pos = p - line;  /* relative */
}

static inline void MatchEchoToken(const char* line, int line_len,
                                  int start_pos, int* id, int* end_pos) {
  assert(start_pos <= line_len);  /* caller should have checked */

  const char* p = line + start_pos;  /* modified by re2c */

  const char* YYMARKER;  /* why do we need this? */

  for (;;) {
    /*!re2c

      "\\" "x" [0-9a-fA-F]{1,2}      { *id = id__Char_Hex; break; }
      "\\" "u" [0-9a-fA-F]{1,4}      { *id = id__Char_Unicode4; break; }
      "\\" "U" [0-9a-fA-F]{1,8}      { *id = id__Char_Unicode8; break; }
      "\\" [0abeEfrtnv\\]            { *id = id__Char_OneChar; break; }
      "\\\n"                         { *id = id__Char_Literals; break; }
      "\\"                           { *id = id__Char_BadBackslash; break; }
      "\\" "0" [0-7]{1,3}            { *id = id__Char_Octal4; break; }
      "\\c"                          { *id = id__Char_Stop; break; }
      [^\\\x00]+                     { *id = id__Char_Literals; break; }
      "\x00"                         { *id = id__Eol_Tok; *end_pos = start_pos; return; }

    */
  }
  *end_pos = p - line;  /* relative */
}


static inline void MatchGlobToken(const char* line, int line_len,
                                  int start_pos, int* id, int* end_pos) {
  assert(start_pos <= line_len);  /* caller should have checked */

  const char* p = line + start_pos;  /* modified by re2c */

  const char* YYMARKER;  /* why do we need this? */

  for (;;) {
    /*!re2c

      "*"                            { *id = id__Glob_Star; break; }
      "?"                            { *id = id__Glob_QMark; break; }
      "!"                            { *id = id__Glob_Bang; break; }
      "^"                            { *id = id__Glob_Caret; break; }
      "["                            { *id = id__Glob_LBracket; break; }
      "]"                            { *id = id__Glob_RBracket; break; }
      "\\" [^\x00]                   { *id = id__Glob_EscapedChar; break; }
      "\\"                           { *id = id__Glob_BadBackslash; break; }
      [a-zA-Z0-9_]+                  { *id = id__Glob_CleanLiterals; break; }
      [^\x00]                        { *id = id__Glob_OtherLiteral; break; }
      "\x00"                         { *id = id__Eol_Tok; *end_pos = start_pos; return; }

    */
  }
  *end_pos = p - line;  /* relative */
}

static inline int IsValidVarName(const char* s, int len) {
  const char* p = s;  /* modified by re2c */
  const char* end = s + len;

  /*!re2c
  re2c:define:YYCURSOR = p;
  [a-zA-Z_][a-zA-Z0-9_]*         { return p == end; }  // Match must be anchored right, like $
  *     { return 0; }
  */
}

static inline int IsPlainWord(const char* s, int len) {
  const char* p = s;  /* modified by re2c */
  const char* end = s + len;

  /*!re2c
  re2c:define:YYCURSOR = p;
  [a-zA-Z0-9\-_./]+              { return p == end; }  // Match must be anchored right, like $
  *     { return 0; }
  */
}

#endif /* lex_re2c_h */
