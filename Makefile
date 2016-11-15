all:
	ocamlbuild -use-ocamlfind -plugin-tag "package(ocamlbuild-pkg)" monomorphic

clean:
	ocamlbuild -clean

.PHONY: all clean
