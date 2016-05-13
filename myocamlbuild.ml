open Ocamlbuild_pkg

let () =
  Ocamlbuild_plugin.dispatch (
    Pkg.dispatcher {
      Pkg.pkg_name = "monomorphic";
      Pkg.lib = Some {
        Pkg.descr = "A small library used to shadow polymorphic operators (and functions) contained in Pervasives";
        Pkg.version = "1.2";
        Pkg.requires = [];
        Pkg.name = "monomorphic";
        Pkg.dir = "src";
        Pkg.modules = [
          "monomorphic";
        ];
        Pkg.private_modules = [];
        Pkg.subpackages = [];
      };
      Pkg.bins = [
      ];
    }
  )
