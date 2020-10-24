(lang dune 2.7)
(name monomorphic)
(version 2.0)

(formatting disabled)
(generate_opam_files true)

(license MIT)
(maintainers "Kate <kit.ty.kate@disroot.org>")
(authors "Kate <kit.ty.kate@disroot.org>")
(source (github kit-ty-kate/ocaml-monomorphic))
(documentation "https://kit-ty-kate.github.io/ocaml-monomorphic")

(package
  (name monomorphic)
  (synopsis "A small library used to shadow polymorphic operators (and functions) contained in the stdlib")
  (depends (ocaml (>= 4.08)))
  (tags (polymorphic compare equal equality monomorphic unsafe safe)))
