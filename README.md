ocaml-monomorphic is a small library used to shadow polymorphic operators (and functions) contained in Pervasives.
It can be useful to avoid some mistakes and runtime errors due to OCaml's polymorphic comparison functions.

## Usage

Using dune, a simple usage would be:
```
(library
  (public_name your-lib)
  (libraries monomorphic)
  (flags :standard -open Monomorphic.Int))
```

[![Build Status](https://travis-ci.org/kit-ty-kate/ocaml-monomorphic.png?branch=master)](https://travis-ci.org/kit-ty-kate/ocaml-monomorphic)
