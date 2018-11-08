(** Defines the CLI for the program. *)

(** Parses command line arguments. *)
val cli : unit -> unit

(** Retrieves the values of command line arguments. *)
val filepath : unit -> string
val is_verbose : unit -> bool
val format : unit -> string
val table : unit -> string option
val func : unit -> string option
val addr : unit -> string option
