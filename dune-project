(lang dune 2.7)
(name monomorphic)
(version 2.0)

(generate_opam_files true)

(package
  (name monomorphic)
  (license MIT)
  (synopsis "A small library used to shadow polymorphic operators (and functions) contained in the stdlib")
  (maintainers "Kate <kit.ty.kate@disroot.org>")
  (authors "Kate <kit.ty.kate@disroot.org>")
  (source (github kit-ty-kate/ocaml-monomorphic))
  (depends (ocaml (>= 4.08)))
  (tags (polymorphic compare equal equality monomorphic unsafe safe)))
