(*
Here l stands for \lambda.

The average parsing goes the following way : parse is called on a char stream 
and converses it into lexems, the third pattern matching is the less 
simple one : it deals with everything that is not an asbtraction (ie : a variable 
or an application).

So as to respect the lambda-calculus priority (uvw <=> (uv)w) we 
have to parse it «from the right» which is not the most simple thing to do, 
yet, as we super ocaml programmers (aka super hacka) we created splitter 
that takes a Stream and return a tuple of 1) every element of the stream 
except the last one 2) the last element of the stream.
Ex : splitter ( [< '1 ; '2 ; '3 >] = ( [< '1 ; '2 >] , 3) 
Last difficulty : we have to parse parenthesis : that's what par_handler is 
here for : it just splits the stream into to part, 1) left of the opening 
parenthesis 2) right of it. Not, some parenthesis may cause bugs, 
especially empty ones (like "lx.x()" ).

*)


type terme = Var of char | App of terme*terme | Abstr of char*terme

let rec splitter  f  = match f with parser 
	| [< 'e >] -> (try let e2 = splitter f in
		( [< 'e ; fst (e2) >] , snd (e2))
		with Stream.Failure -> ( [<>],e ));;

let rec par_handler acc s = match s with parser
	| [< ''(' >] -> (acc,s)
	| [< 'e >] -> par_handler [< acc ; 'e >] s ;;


let rec parse f =
	match f with parser
	| [< '' ' >] -> parse f
	| [< ''l'; 'v ; ''.' ; e2 = parse >]  -> Abstr (v, e2)
	| [< s = splitter >] -> (match (snd s) with
			| ')' ->  (let p = par_handler [<>] (fst s) in 
				try let e1 = parse (fst p) in App (e1, parse (snd p)) with Stream.Failure -> parse (snd p))
			| _  as e2 -> try App ( parse (fst s),Var e2)
		with Stream.Failure -> (Var (snd s)));;

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

let rec app2 t = match t with 
	|App (Abstr (v,e), u) -> application (subst e v u) 
	| _ -> t

and application t = match t with
	| App ( Abstr (v,e), u ) -> application (subst e v u)
	| App ((Var _) as v, t) -> App( v, application t)
	| App (t1 , t2) -> app2 (App (application t1, application t2))
	| Abstr (c , t) -> Abstr (c , application t)
	| (Var _ )as v ->  v;;


let of_string s = parse (Stream.of_string s);;

let rec to_string t = match t with 
	| Var c -> String.make 1 c
	| App  (t,tb) -> (to_string t)^(to_string tb)
	| Abstr (c,t) -> "l"^(String.make 1 c)^"."^(to_string t);;
