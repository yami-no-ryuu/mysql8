open Pancakes
open MySql

type t = {
  id : string;
  name : string;
  age : int;
  alive : bool option;
  first_initial: char;
}

let config = {
  host="localhost";
  user="root";
  password="";
  database="test";
  port=3006;
}

let string_of_bool_option = function
  | None    -> "None"
  | Some b  -> "Some " ^ string_of_bool b

let pp row =
  print_endline @@ String.concat ", " [
    row.id; row.name; string_of_int row.age; string_of_bool_option row.alive;
    Char.escaped row.first_initial
  ]

let pp_rows = List.iter pp

let convert row = {
  id    = row.(0);
  name  = row.(1);
  age   = int_of_cell row.(2);
  alive = some_bool_of_cell row.(3);
  first_initial = char_of_cell row.(4);
}

let convert_rows = List.map convert

let _ =
  let db = connect config in
  let cnt, rows = execute db "SELECT * FROM example;" in
  print_endline @@ string_of_int cnt;
  rows |> convert_rows |> pp_rows;
  ()
