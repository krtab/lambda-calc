cmod = ocamlc -c 
cbin = ocamlc

all : cli

parlex :  
	$(cmod) ast.ml
	menhir --infer --explain parser.mly
	ocamllex lexer.mll

core:
	$(cmod) ast.ml parser.mli parser.ml lexer.ml lcalc.ml

cli_mod : core
	$(cmod) cli.ml

cli :  	cli_mod
	$(cbin)  ast.cmo parser.cmo lexer.cmo lcalc.cmo cli.ml -o cli
	chmod +x cli

clean:
	touch a.cmo b.cmi c.o
	rm *.cmo
	rm *.cmi
	rm *.o
	rm parser.conflicts

core_lib: core
	ocamlc -a  ast.cmo parser.cmo lexer.cmo lcalc.cmo cli.ml -o lcalc.cma

http: core_lib
	 ocamlc -c ast.cmo parser.cmo lexer.cmo lcalc.cmo http.ml
	 ocamlc str.cma unix.cma lcalc.cma http.cmo -o http

httpsa:  
	ocamlopt -o httpbin str.cmxa unix.cmxa ast.ml lexer.ml parser.ml lcalc.ml http.ml
