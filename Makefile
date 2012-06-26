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
	rm *.cmo
	rm *.cmi
	parser.conflicts
