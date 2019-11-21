type connection
type query = string
type cell
type row = cell array
type result = row list

val connect : unit -> connection
val disconnect : connection -> unit
val query : connection -> query -> result
val cell2string : cell -> string
val cell2int : cell -> int
