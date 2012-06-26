exception Error

type token = 
  | Var of (char)
  | RPar
  | LPar
  | EOF
  | Abstr of (char)


val amorce: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.lexpr)