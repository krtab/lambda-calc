#LambdaCalc

[Lambdacal](http://tartiflette.tonbnc.fr/interpret/) is an non-typed lambda-calculus tool with both a cli and an online font-end.

##The project

When searching a λ-calculus tool on the internet I found nothing but some Java applets (which, to my very personal opinion, do suck). As I was learning ocaml at the same time, I decided to write some tool that would fit my needs and expectations.

Thus, Lambda-calc try to reaches those goals :
- Provide an js-only online interface
- This interface should also be more or less providing the same functions as a common shell (work in progress)

But doesn't try to reach those at all :
- Be optimised and light-speeded
- Be easy to maintain
- Be easy to run

##Technically

Lambdacalc's working is not simple. In fact, it relies on an ocaml core and offer an IP interface to comunicate with the JS front-end. This interface listens on 1337 (so geek !), which entailed issues with XmlHttpRequest Cross Domain limitations. To get round of it, I used [nginx](http://wiki.nginx.org/Main) reverse proxy and bind domain:80/lcalcapi to domain:1337, which explains that the queries are on this url. 

Here is a little description of the files :
- **ast.ml** describes the grammar
- **cli.ml** gives the cli interface
- **http.ml** provides the *api*  (or HTTP-frontend, call it what you want)
- **index.html** is basically the webpage
- **lcalc.ml** implements the reduction functions
- **lexer.mll** is the source for ocamllex (that compiles it into ocaml code in lexer.ml)
- **parser.mly** is the source for menhir.

##What is the *old-parlex* branch ?

It's a branch where I leave the rests of a version of the lexer and parser written by my own. It doesn't work at all, but I yet keep it for the remembrance.
