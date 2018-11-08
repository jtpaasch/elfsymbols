(** Utilities to select/filter parsed table data. *)

(** Filter a list of tables by an optional table name.

    If the optional table name is [None], no filtering is done
    and the original table list is returned.

    If the optional name is [Some r], where [r] is a string, 
    this will only those tables whose names begin with [r]. 
    [r] can be a literal string pattern, or a regular 
    expression pattern. *)
val tables : Table.t list -> string option -> Table.t list

(** Filter a list of tables by an optional function name. This
    returns a list of only those tables that contain the matching
    functions, with any non-matching functions removed from the tables.

    If the optional function name is [None], then no filtering
    is done and the original table list is returned.

    If the optional function name is [Some r], where [r] is a 
    string, then this will reduce each table's function list down 
    to only those functions whose names begin with [r]. [r] can be 
    a literal string pattern, or a regular expression pattern. *)
val funcs : Table.t list -> string option -> Table.t list
