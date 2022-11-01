(* Copyright (c) 2013-2017 Kate <kit.ty.kate@disroot.org>. *)
(* See the LICENSE file at the top-level directory. *)

[@@@ocaml.alert "-deprecated"]

module Make (Ty : sig type t end) : sig
  external (=) : Ty.t -> Ty.t -> bool = "%equal"
  external (<>) : Ty.t -> Ty.t -> bool = "%notequal"
  external (<) : Ty.t -> Ty.t -> bool = "%lessthan"
  external (>) : Ty.t -> Ty.t -> bool = "%greaterthan"
  external (<=) : Ty.t -> Ty.t -> bool = "%lessequal"
  external (>=) : Ty.t -> Ty.t -> bool = "%greaterequal"
  external compare : Ty.t -> Ty.t -> int = "%compare"
  val min : Ty.t -> Ty.t -> Ty.t
  val max : Ty.t -> Ty.t -> Ty.t
end = Stdlib

module None : module type of Make(struct type t = unit end) = Stdlib
module Int : module type of Make(struct type t = int end) = Stdlib
module Bool : module type of Make(struct type t = bool end) = Stdlib
module Float : module type of Make(struct type t = float end) = Stdlib
module String : module type of Make(struct type t = string end) = Stdlib

module Stdlib = struct
  module Stdlib = struct
    include Int

    module List = struct
      include List

      let mem a ~eq xs  = List.exists (eq a) xs
      let assoc a ~eq xs = snd (List.find (fun (k,_) -> eq a k) xs)
      let assoc_opt a ~eq xs = Option.map snd (List.find_opt (fun (k,_) -> eq a k) xs)
      let mem_assoc a ~eq xs = List.exists (fun (k, _) -> eq k a) xs
      let rec remove_assoc a ~eq = function
        | [] -> []
        | ((k, _) as pair) :: xs ->
            if eq a k then xs else pair :: remove_assoc a ~eq xs
    end

    module ListLabels = struct
      include ListLabels

      let mem a ~eq ~set = List.mem a ~eq set
      let assoc a ~eq xs = List.assoc a ~eq xs
      let assoc_opt a ~eq xs = List.assoc_opt a ~eq xs
      let mem_assoc a ~eq ~map = List.mem_assoc a ~eq map
      let remove_assoc a ~eq xs = List.remove_assoc a ~eq xs
    end

    module StdLabels = struct
      include (StdLabels :
                 module type of StdLabels
               with module List := StdLabels.List
              )

      module List = ListLabels
    end

#if OCAML_VERSION < (5, 0, 0)
    module Pervasives = struct
      include Pervasives
      include Int
    end
#endif

    include (Stdlib :
               module type of Stdlib
             with module List := Stdlib.List
              and module ListLabels := Stdlib.ListLabels
              and module StdLabels := Stdlib.StdLabels
#if OCAML_VERSION < (5, 0, 0)
              and module Pervasives := Stdlib.Pervasives
#endif
              and module Int := Stdlib.Int
              and type in_channel = Stdlib.in_channel
              and type out_channel = Stdlib.out_channel
            )

    include Int
    module Int = Stdlib.Int
  end

  include Stdlib
end
