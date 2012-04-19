open Lambdacalc_core;;

let b = ref true;;

let main =
while !b do
	print_string("#!>> ");
	try let s = read_line() in print_string ( 
	to_string ( 
	application (  
	of_string s)));print_string("\n");
	with End_of_file -> b := false;
	done;;
