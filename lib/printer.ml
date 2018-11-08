(** Implements {!Printer}. *)

module Output = struct
  type t =
    | Console 
    | Json
end

let json_record func =
  let name = Func.name func in
  let addr = Func.addr func in
  Printf.sprintf "{\"name\": \"%s\", \"addr\": \"%s\"}" name addr

let string_record func =
  let name = Func.name func in
  let addr = Func.addr func in
  Printf.sprintf "\t%s:\t%s" addr name

let func_to_string table name =
  let funcs = Table.funcs table in
  let func = Func.find_by_name funcs name in
  match func with
  | Some a -> string_record a
  | None -> ""

let func_to_json table name =
  let funcs = Table.funcs table in
  let func = Func.find_by_name funcs name in
  match func with
  | Some a -> json_record a
  | None -> ""

let table_to_json table =
  let name = Table.name table in
  let funcs = Table.funcs table in
  match List.length funcs > 0 with
  | false -> ""
  | true ->
    begin
      let func_records = List.map json_record funcs in
      let funcs_str = String.concat ", " func_records in
      Printf.sprintf "{\"name\": \"%s\", \"funcs\": [%s]}" name funcs_str
    end

let tables_to_json tables =
  let table_records = List.map table_to_json tables in
  let table_records' = List.filter Utils.Strings.is_empty table_records in
  let tables_str = String.concat ", " table_records' in
  Printf.sprintf "[%s]" tables_str

let table_to_string table =
  let name = Table.name table in
  let funcs = Table.funcs table in
  match List.length funcs > 0 with
  | false -> ""
  | true ->
    begin
      let func_records = List.map string_record funcs in
      let funcs_str = String.concat "\n" func_records in
      Printf.sprintf "%s\n%s" name funcs_str
    end

let tables_to_string tables =
  let table_records = List.map table_to_string tables in
  let table_records' = List.filter Utils.Strings.is_empty table_records in
  let tables_str = String.concat "\n" table_records' in
  Printf.sprintf "%s" tables_str

let print out tables =
  match out with
  | Output.Console -> tables_to_string tables
  | Output.Json -> tables_to_json tables
