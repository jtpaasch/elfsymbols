# ELF symbols

A simple tool/library to read off functions/addresses
from the symbol tables in an ELF binary.

Requirements:
* OCaml 4.05.0+


## Build/install

To build it, use `make`:

    $ make

This will create an executable at `bin/elfsymbols`.
Try the help:

    $ bin/elfsymbols --help

To clean/uninstall:

    $ make clean

    
# CLI

The executable reads the symbol table from an ELF binary,
and prints out the names and addresses of the functions in
the tables it finds.

There is one required argument: a path to an ELF binary.
For example, to print the functions in `/bin/true`:

    $ bin/elfsymbols /bin/true

To print the data as JSON:

    $ bin/elfsymbols /bin/true --format=json

To print only functions that start with a string,
e.g., `mem`:

    $ bin/elfsymbols /bin/true --func=mem

You can match the start of function names with a
regular expression too. 
For example, to print functions
that start with `mem` or `str`:


    $ bin/elfsymbols /bin/true --func="mem\|str"

(If you use a regular expression pattern, you must
put it in quotes, and the string must be escaped
in compliance with OCaml's `Str` module.)

If your ELF binary is not stripped, you may have
more than one table. For example, you may have both
a `dynsym` table and a `symtab` table. 

You can filter the output to only a particular table.
For example, to restrict the results only to `symtab`:

    $ bin/elfsymbols /bin/true --table=symtab --func=mem

You can also use a regular expression to filter the tables.
For example:

    $ bin/elfsymbols /bin/true --table="[ds]y[mn]" --func=mem



