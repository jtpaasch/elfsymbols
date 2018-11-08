(** Utility to parse symbol tables. *)

(** Use [Parser.tables_in filepath] to extract all table data
    from an ELF file at [filepath]. Each table is parsed into
    a {!Table.t} object, which has a name (a string) and a list
    of functions. Each of those functions are in turn parsed
    into a {!Func.t} object. 
    
    Note that an ELF file can have more than one symbol table.
    For instance, it can have [symtab] and [dynsym] tables.
    For this reason, [Parser.tables_in filepath] returns a
    list of [Table.t] objects, one for each table found in
    the ELF file. *)

exception ParseFailure of string

(** Takes a filepath (string) to an ELF file. This function uses
    `readelf -t` to get symbol table information from the file, 
    then it parses that data into a [Table.t] list. *)
val tables_in : string -> Table.t list
