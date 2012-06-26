{open Parser}

let var = ['a'-'k' 'm'-'z' ]
let lambda = ['l' '\\']

rule lex = parse
	| var as c {Var c}
	| lambda (var as v) '.' {Abstr v}
	| '(' {LPar}
	| ')' {RPar} 
	| eof {EOF}
