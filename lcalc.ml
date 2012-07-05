open Ast

let lim = 10;;

let rec subst e a b =  match e with
	| Var c as v -> if c=a then b else v
	| App ( t1, t2) -> App ( subst t1 a b,  subst t2 a b)
	| Abstr (v , t) -> Abstr (v, subst t a b);;

(*
Here app2 is needed to prevent from an infinite 
loop, just wonder how you would have done it 
without, and you won't find (or if you do, please
email me).
*)

let rec app2 t n= match t with 
	|App (Abstr (v,e), u) -> if (n < lim) then application (subst e v u) (n+1) else t
	| _ -> t

and application t n = match t with
	| App ( Abstr (v,e), u ) -> if (n < lim) then application (subst e v u) (n+1) else t
	| App ((Var _) as v, t) -> App( v, application t n)
	| App (t1 , t2) -> app2 (App (application t1 n, application t2 n)) n 
	| Abstr (c , t) -> Abstr (c , application t n) 
	| (Var _ )as v ->  v;;

let eval s =  to_string (application (Parser.amorce Lexer.lex (Lexing.from_string s)) 0 );;
