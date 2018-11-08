(** Implements {!Cli}. *)

let program_name = "elfsymbols"
let program_version = "0.1"
let program_desc = "  Extract symbol info from an ELF binary at FILEPATH."

let filepath_value = ref ""
let filepath = fun () -> !filepath_value

let verbose_value = ref false
let is_verbose = fun () -> !verbose_value

let format_value = ref "string"
let format = fun () -> !format_value

let table_value = ref ""
let table = fun () -> 
  match String.trim !table_value with
  | "" -> None
  | s -> Some s

let func_value = ref ""
let func = fun () -> 
  match String.trim !func_value with
  | "" -> None
  | s -> Some s

let addr_value = ref ""
let addr = fun () -> 
  match String.trim !addr_value with
  | "" -> None
  | s -> Some s

let version = fun () -> Printf.printf "%s %s\n%!" program_name program_version; exit 0

let help_hint = fun () -> Printf.sprintf "See %s --help." program_name

let usage = fun () ->
  Printf.sprintf 
  "USAGE: %s [OPTIONS] FILEPATH\n\n%s\n\nOPTIONS:"
  program_name program_desc

let spec = [
  ("--version", Arg.Unit version, "Print the version.");
  ("--verbose", Arg.Set verbose_value, "Print verbose output.");
  ("--format", Arg.Symbol (["json"; "string";], (fun s -> format_value := s)), " Default: string.");
  ("--table", Arg.Set_string table_value, "Name of table to show. Default: all tables.");
  ("--func", Arg.Set_string func_value, "Name of function to show. Default: all functions.");
  ("--addr", Arg.Set_string addr_value, "Address of function to show. Default: all addresses.");
]

let handle_args arg =
  match arg with
  | _ ->
    begin
      match filepath () with
      | "" -> filepath_value := arg
      | _ ->
        begin
          Printf.printf "Error. Unrecognized argument: '%s'. %s\n%!" arg (help_hint ());
          exit 1
        end
    end

let check () =
  match filepath () with
  | "" ->
    begin
      Printf.printf "Specify FILEPATH. %s\n%!" (help_hint ());
      exit 1
    end
  | _ -> ()

let cli () =
  Arg.parse spec handle_args (usage ());
  check ()
