cmod = ocamlc -c -pp "camlp4o"
cbin = ocamlc

all : cli

core : 
	$(cmod) Lambdacalc_core.ml

cli_mod : core
	$(cmod) cli.ml

cli :   cli_mod
	$(cbin) Lambdacalc_core.cmo cli.cmo -o cli
