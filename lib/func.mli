(** Represents an individual function found in a symbol table. *)

type t

(** Create a new function record, given a name (a string),
    an address (a string), and the original line taken
    from the [readelf -t] output. *)
val create : string -> string -> string -> t

val name : t -> string
val addr : t -> string
val data : t -> string

val from_string : string -> t option

(** Find a [Func.t] by name/address in a [Func.t] list. *)
val find_by_name : t list -> string -> t option
val find_by_addr : t list -> string -> t option
