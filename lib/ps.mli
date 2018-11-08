(** A utility for running shell commands. *)

module Cmd : sig

  (** Runs a command in a shell, returns the exit code, stdout, and stderr.

      Arguments:
      - A string (the command to execute in the shell)

      Returns: a triple composed of:
      - The exit code (an int)
      - The command's stdout (a string)
      - The command's stderr (a string) *)
  val run : string -> int * string * string

end

