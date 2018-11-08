(** Implements {!Utils}. *)

module Strings = struct

  let is_empty s = String.length (String.trim s) > 0

  let is_regex_match r s =
    let c = Str.regexp r in
    Str.string_match c s 0

  let starts_with s s' =
    let r = Str.regexp s in
    Str.string_match r s' 0

  let find_line r l =
    let lines = List.filter (fun s -> is_regex_match r s) l in
    match List.length lines > 0 with
    | true -> Some (List.nth lines 0)
    | false -> None

  let take n s =
    match String.length s > n with
    | true -> String.sub s 0 n
    | false -> ""

end

module CmdRunner = struct

  exception ExecutionError of string
  exception NonzeroExit of string

  let make_exec_err cmd e =
    Printf.sprintf 
    "Couldn't run command '%s'.\nError: %s" 
    cmd (Printexc.to_string e)

  let make_cmd_err cmd code out err =
    Printf.sprintf
    "Command exited with non-zero exit code.\nCMD: '%s'\nEXIT CODE: '%d'\nSTDOUT: %s\nSTDERR: %s"
    cmd code out err

  let run cmd =
    let code, out, err = try
      Ps.Cmd.run cmd
    with e ->
      let msg = make_exec_err cmd e in
      raise (ExecutionError msg)
      in
    match code with
    | 0 -> out, err
    | n ->
      begin
        let msg = make_cmd_err cmd code out err in
        raise (NonzeroExit msg)
      end

end
