(* Copyright (c) 2013-2017 Kate <kit.ty.kate@disroot.org>. *)
(* See the LICENSE file at the top-level directory. *)

[@@@ocaml.alert "-deprecated"]

module type TY = sig
  type t
end

module MakeInfix (Ty : TY) = Pervasives
module MakeCmp (Ty : TY) = Pervasives
module Make (Ty : TY) = Pervasives

module None = Pervasives

module Int = Pervasives
module Bool = Pervasives
module Float = Pervasives
module String = Pervasives

type 'a eq = 'a -> 'a -> bool

module List = struct
  include List

  let mem a ~eq xs  = List.exists (eq a) xs
  let assoc a ~eq xs = snd (List.find (fun (k,_) -> eq a k) xs)
  let mem_assoc a ~eq xs = List.exists (fun (k, _) -> eq k a) xs
  let rec remove_assoc a ~eq = function
    | [] -> []
    | ((k, _) as pair) :: xs ->
        if eq a k then xs else pair :: remove_assoc a ~eq xs
end

module Stdlib = struct
  module List = List

  module StdLabels = struct
    include (StdLabels :
               module type of StdLabels
             with module List := StdLabels.List
            )

    module List = struct
      include StdLabels.List

      let mem a ~eq ~set = List.mem a ~eq set
      let assoc a ~eq xs = List.assoc a ~eq xs
      let mem_assoc a ~eq ~map = List.mem_assoc a ~eq map
      let remove_assoc a ~eq xs = List.remove_assoc a ~eq xs
    end
  end

  include None
end
