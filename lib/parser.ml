(** Implements {!Parser}. *)

exception ParseFailure of string

let get_symtab filepath =
  let cmd = Printf.sprintf "readelf -s %s" filepath in
  Utils.CmdRunner.run cmd

let lines_of s = Str.split (Str.regexp "\n") s

let rec clean l acc =
  match l with
  | [] -> acc
  | h :: t ->
    begin
      match (String.trim h) = "" with
      | true -> clean t acc
      | false -> clean t (List.append acc [h])
    end

let rec grab_until l s acc =
  match l with
  | [] -> acc, []
  | h :: t ->
    begin
      let n = String.length s in
      match Utils.Strings.take n h = s with
      | true -> acc, l
      | false ->
        begin
          let new_acc = List.append acc [h] in
          grab_until t s new_acc 
        end
    end

let rec tables l acc =
  match l with
  | [] -> acc
  | h :: t ->
    begin
      match Utils.Strings.take 15 h with
      | "Symbol table '." ->
        begin
          let raw_data, rest = grab_until t "Symbol table '." [] in
          let data = List.tl raw_data in  (* The first line is just column headers *)
          let data' = clean data [] in    (* Remove blank lines. *)
          let tab = Table.from_strings h data' in
          let new_acc = List.append acc [tab] in
          tables rest new_acc
        end
      | _ ->
        begin
          let msg = 
            Printf.sprintf "Error: unexpected line: '%s'\n%!" h in
          raise (ParseFailure msg)
        end
    end

let parse s =
  let data = lines_of s in
  tables data []

let tables_in filepath =
  let out, _ = get_symtab filepath in
  parse out
