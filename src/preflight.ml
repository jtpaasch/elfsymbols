(** Implements {!Preflight}. *)

let format_or_exit format =
  match format with
  | "json" -> Printer.Output.Json
  | "string" -> Printer.Output.Console
  | _ ->
    begin
      Printf.printf "Error: output format must be 'json' or 'string'.";
      exit 1
    end

let prog_or_exit prog =
  let cmd = Printf.sprintf "which %s" prog in
  let code, out, err = Ps.Cmd.run cmd in
  match code with
  | 0 -> ()
  | _ ->
    begin
      Printf.printf "Error: cannot find the '%s' executable.\n%!" prog;
      exit 1
    end

let elf_or_exit filepath =
  let cmd = Printf.sprintf "file -b %s" filepath in
  let out, err = Utils.CmdRunner.run cmd in
  let filetype = Utils.Strings.take 10 out in
  match filetype with
  | "ELF 64-bit" -> ()
  | _ ->
    begin
      Printf.printf "Error: '%s' is not a 64-bit ELF file.\n%!" filepath;
      exit 1
    end

