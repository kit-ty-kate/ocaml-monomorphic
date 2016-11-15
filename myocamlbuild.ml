open Ocamlbuild_pkg

let lib =
  Pkg.Lib.create
    ~descr:"A small library used to shadow polymorphic \
            operators (and functions) contained in Pervasives"
    ~version:"1.4"
    ~requires:[]
    ~name:"monomorphic"
    ~dir:"src"
    ~modules:[
      "monomorphic";
    ]
    ()

let monomorphic =
  Pkg.create
    ~name:"monomorphic"
    ~libs:[lib]
    ()

let () =
  Ocamlbuild_plugin.dispatch (fun hook ->
    Pkg.dispatcher monomorphic hook;
  )
