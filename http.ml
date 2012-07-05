open Unix;;
open Str;;
open Lcalc;;

let service i o =
	try while true do
	let s = input_line i in
	if string_match (regexp "GET .*") s 0 
		then (let r1 = replace_first (regexp ".*?input=") "" s
		in let r2 = replace_first (regexp " HTTP/.*") "" r1
		in let r3 = try eval r2 with _ -> "Error"
		in output_string o (r3)); flush o; exit 0
	done
	with _ ->();;

let server service = establish_server service (ADDR_INET (inet_addr_of_string "0.0.0.0", 1337));;

Unix.handle_unix_error server service;; 
