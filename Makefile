all:
	ocamlbuild -use-ocamlfind -plugin-tag "package(ocamlbuild-pkg)"

clean:
	ocamlbuild -clean

.PHONY: all clean
