(** The main entry point to the executable. *)

let () =
  Cli.cli ();

  let filepath = Cli.filepath () in
  let format = Cli.format () in
  let table = Cli.table () in
  let func = Cli.func () in

  let output = Preflight.format_or_exit format in
  Preflight.prog_or_exit "file";
  Preflight.prog_or_exit "readelf";
  Preflight.elf_or_exit filepath;

  try
    let data = Parser.tables_in filepath in
    let tables = Selector.tables data table in
    let funcs = Selector.funcs tables func in
    let res = Printer.print output funcs in
    match String.length res > 0 with 
    | true -> Printf.printf "%s\n%!" res
    | false -> ()
  with e ->
    match e with
    | _ -> Printf.printf "Error: %s\n%!" (Printexc.to_string e); exit 1
