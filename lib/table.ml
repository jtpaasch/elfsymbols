(** Implements {!Table}. *)

type t = { 
  name: string; 
  funcs: Func.t list; 
}

let create name funcs = { name; funcs; }

let name t = t.name
let funcs t = t.funcs

let rec func l s =
  match l with
  | [] -> None
  | h :: t ->
    begin
      match Func.name h = s with
      | true -> Some h
      | false -> func t s
    end

let rec addr l s =
  match l with
  | [] -> None
  | h :: t ->
    begin
      match Func.addr h = s with
      | true -> Some h
      | false -> func t s
    end

let extract_name s =
  let exp = Str.regexp "'\\.[^']+'" in
  let _ = Str.search_forward exp s 0 in
  let res = Str.matched_string s in
  String.sub res 2 ((String.length res) - 3)

let extract_funcs l =
  let appender l v =
    match v with
    | Some a -> List.append l [a]
    | None -> l in
  let opts = List.map Func.from_string l in
  List.fold_left appender [] opts

let from_strings header data =
  let name = extract_name header in
  let funcs = extract_funcs data in 
  create name funcs
