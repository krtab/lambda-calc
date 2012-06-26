type lexpr = Abstr of char * lexpr | App of lexpr*lexpr | Var of char

let rec to_string t = match t with 
        | Var c -> String.make 1 c 
        | App  (t,tb) -> (to_string t)^(to_string tb) 
        | Abstr (c,t) -> "l"^(String.make 1 c)^"."^(to_string t);;
