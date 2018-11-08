(** Implements {!Func}. *)

type t = { name: string; addr: string; data: string; }

let create name addr data = { name; addr; data }

let name t = t.name
let addr t = t.addr
let data t = t.data

let from_string s =
  let cols = Str.split (Str.regexp " +") s in
  let kind = List.nth cols 3 in
  match kind with
  | "FUNC" ->
    begin
      let addr = List.nth cols 1 in
      let name = List.nth cols 7 in
      Some (create name addr s)
    end
  | _ -> None

let rec find_by_name l s =
  match l with
  | [] -> None
  | h :: t ->
    begin
      match name h = s with
      | true -> Some h
      | false -> find_by_name t s
    end

let rec find_by_addr l s =
  match l with
  | [] -> None
  | h :: t ->
    begin
      match addr h = s with
      | true -> Some h
      | false -> find_by_addr t s
    end
