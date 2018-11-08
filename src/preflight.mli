(** Preflight checks. *)

(** Gets the correct output type for "json" or "string".
    If neither "json" or "string", exit with an error. *)
val format_or_exit : string -> Printer.Output.t

(** Checks if an executable (given as a string) is installed on the system.
    If not, exit with an error. *)
val prog_or_exit : string -> unit

(** Checks if a filepath (given as a string) points to a 64-bit ELF file.
    If not, exit with an error. *)
val elf_or_exit : string -> unit
