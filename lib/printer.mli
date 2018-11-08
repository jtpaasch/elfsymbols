(** Functions to print parsed table data. *)

module Output : sig
  type t =
    | Console 
    | Json
end

(** Takes a table and the name of a function, and returns a 
    string representation (for stdout/console, or json). *)
val func_to_string : Table.t -> string -> string
val func_to_json : Table.t -> string -> string

(** Takes a table (or list of tables) and returns 
    a json representation (a string). *)
val table_to_json : Table.t -> string
val tables_to_json : Table.t list -> string

(** Takes a table (or list of tables) and returns 
    a string representation (for stdout/console). *)
val table_to_string : Table.t -> string
val tables_to_string : Table.t list -> string

(** Takes a format/output type (stdout/console or json) and 
    a list of tables. Returns the output string formatted appropriately. *)
val print : Output.t -> Table.t list -> string
