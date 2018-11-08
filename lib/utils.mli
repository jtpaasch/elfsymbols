(** {!Dwarf} utilities. *)

module Strings : sig

  (** Takes a string and returns a boolean if the string is empty. *)
  val is_empty : string -> bool 

  (** Takes a regular expression pattern (a string) and a string,
      and returns a boolean if the pattern is matched at the
      start of string. *)
  val is_regex_match : string -> string -> bool

  (** Takes a regular expression pattern (a string) and a string,
      and returns a boolean if the string starts with that pattern. *)
  val starts_with : string -> string -> bool

  (** Takes a regular expression pattern (a string) and a 
      list of strings, and returns [Some] string that matches
      or [None] if no matches were found. *) 
  val find_line : string -> string list -> string option

  (** Returns the first [n] characters of a string, or an empty
      string if the string isn't [n] characters long. *)
  val take : int -> string -> string

end


module CmdRunner : sig

  exception ExecutionError of string
  exception NonzeroExit of string

  (** Takes a command to run (as a string), executes it,
      and returns the stdout and stderr (a pair of strings). *)
  val run : string -> string * string

end
