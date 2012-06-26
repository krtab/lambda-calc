%{exception ParErr %}

%token RPar LPar EOF
%token <char> Var
%token <char> Abstr

%left App
%nonassoc Abstr
%nonassoc Var

%start <Ast.lexpr> amorce

%%
amorce:
| l=lexpr EOF {l}

lexpr:

| x= Var {Ast.Var x}
| x = Abstr y = lexpr {Ast.Abstr (x,y)}

| LPar x = lexpr RPar { x } 

| x=lexpr y=lexpr {Ast.App (x,y)} %prec App

