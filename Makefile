all:
	ocamlbuild -use-ocamlfind -plugin-tag "package(ocamlbuild-pkg)"
	cp _build/monomorphic.install .

clean:
	ocamlbuild -clean
	rm -f monomorphic.install

.PHONY: all clean
