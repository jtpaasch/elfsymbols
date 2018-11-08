(** Represents a parsed symbol table. *)

type t

(** Create a new table from a name (a string) and a list
    of parsed functions (a {!Func.t} list). *)
val create : string -> Func.t list -> t

val name : t -> string
val funcs : t -> Func.t list

(** Create a new table from a name (a string) and a list
    of functions as raw strings taken from [readelf -t]. *)
val from_strings : string -> string list -> t 
