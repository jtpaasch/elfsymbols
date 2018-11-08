exe_name = elfsymbols
compiler = ocamlopt
libext = cmxa
objext = cmx
build_dir = build
bin_dir = bin
lib_dir = lib
src_dir = src

all: clean $(build_dir)

clean:
	rm -rf $(bin_dir)
	rm -rf $(build_dir)

$(build_dir): clean
	mkdir $(bin_dir)
	mkdir $(build_dir)
	cp -R $(src_dir) $(build_dir)/
	cp -R $(lib_dir) $(build_dir)/

	ocamlfind $(compiler) -I $(build_dir)/$(lib_dir) -I $(build_dir)/$(src_dir) -c $(build_dir)/$(lib_dir)/ps.mli
	ocamlfind $(compiler) -I $(build_dir)/$(lib_dir) -I $(build_dir)/$(src_dir) -c $(build_dir)/$(lib_dir)/ps.ml
	ocamlfind $(compiler) -I $(build_dir)/$(lib_dir) -I $(build_dir)/$(src_dir) -c $(build_dir)/$(lib_dir)/utils.mli
	ocamlfind $(compiler) -I $(build_dir)/$(lib_dir) -I $(build_dir)/$(src_dir) -c $(build_dir)/$(lib_dir)/utils.ml
	ocamlfind $(compiler) -I $(build_dir)/$(lib_dir) -I $(build_dir)/$(src_dir) -c $(build_dir)/$(lib_dir)/func.mli
	ocamlfind $(compiler) -I $(build_dir)/$(lib_dir) -I $(build_dir)/$(src_dir) -c $(build_dir)/$(lib_dir)/func.ml
	ocamlfind $(compiler) -I $(build_dir)/$(lib_dir) -I $(build_dir)/$(src_dir) -c $(build_dir)/$(lib_dir)/table.mli
	ocamlfind $(compiler) -I $(build_dir)/$(lib_dir) -I $(build_dir)/$(src_dir) -c $(build_dir)/$(lib_dir)/table.ml
	ocamlfind $(compiler) -I $(build_dir)/$(lib_dir) -I $(build_dir)/$(src_dir) -c $(build_dir)/$(lib_dir)/selector.mli
	ocamlfind $(compiler) -I $(build_dir)/$(lib_dir) -I $(build_dir)/$(src_dir) -c $(build_dir)/$(lib_dir)/selector.ml
	ocamlfind $(compiler) -I $(build_dir)/$(lib_dir) -I $(build_dir)/$(src_dir) -c $(build_dir)/$(lib_dir)/parser.mli
	ocamlfind $(compiler) -I $(build_dir)/$(lib_dir) -I $(build_dir)/$(src_dir) -c $(build_dir)/$(lib_dir)/parser.ml
	ocamlfind $(compiler) -I $(build_dir)/$(lib_dir) -I $(build_dir)/$(src_dir) -c $(build_dir)/$(lib_dir)/printer.mli
	ocamlfind $(compiler) -I $(build_dir)/$(lib_dir) -I $(build_dir)/$(src_dir) -c $(build_dir)/$(lib_dir)/printer.ml
	ocamlfind $(compiler) -I $(build_dir)/$(lib_dir) -I $(build_dir)/$(src_dir) -c $(build_dir)/$(src_dir)/cli.mli
	ocamlfind $(compiler) -I $(build_dir)/$(lib_dir) -I $(build_dir)/$(src_dir) -c $(build_dir)/$(src_dir)/cli.ml
	ocamlfind $(compiler) -I $(build_dir)/$(lib_dir) -I $(build_dir)/$(src_dir) -c $(build_dir)/$(src_dir)/preflight.mli
	ocamlfind $(compiler) -I $(build_dir)/$(lib_dir) -I $(build_dir)/$(src_dir) -c $(build_dir)/$(src_dir)/preflight.ml
	ocamlfind $(compiler) -I $(build_dir)/$(lib_dir) -I $(build_dir)/$(src_dir) -c $(build_dir)/$(src_dir)/main.ml

	ocamlfind $(compiler) -I $(build_dir)/$(lib_dir) -I $(build_dir)/$(src_dir) \
		-linkpkg \
		unix.$(libext) \
		str.$(libext) \
		-o $(bin_dir)/$(exe_name) \
		ps.$(objext) \
		utils.$(objext) \
		func.$(objext) \
		table.$(objext) \
		selector.$(objext) \
		parser.$(objext) \
		printer.$(objext) \
		cli.$(objext) \
		preflight.$(objext) \
		main.$(objext)

