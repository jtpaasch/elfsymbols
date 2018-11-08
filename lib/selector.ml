(** Implements {!Selector}. *)

let tables data name =
  match name with
  | None -> data
  | Some s ->
    begin
      List.filter 
      (fun tbl -> Utils.Strings.starts_with s (Table.name tbl)) 
      data
    end

let filter_funcs_by_name table name =
  match name with
  | Some s ->
    begin
      let all_funcs = Table.funcs table in
      let matched_funcs = 
        List.filter 
        (fun f -> Utils.Strings.starts_with s (Func.name f)) 
        all_funcs in
      let table_name = Table.name table in
      Table.create table_name matched_funcs
    end
  | None -> table

let funcs tables name =
  List.map (fun tbl -> filter_funcs_by_name tbl name) tables
