(* Copyright (c) 2013-2017 Kate <kit.ty.kate@disroot.org>. *)
(* See the LICENSE file at the top-level directory. *)

[@@@ocaml.alert "-deprecated"]

module Make (Ty : sig type t end) : sig
  val (=) : Ty.t -> Ty.t -> bool
  val (<>) : Ty.t -> Ty.t -> bool
  val (<) : Ty.t -> Ty.t -> bool
  val (>) : Ty.t -> Ty.t -> bool
  val (<=) : Ty.t -> Ty.t -> bool
  val (>=) : Ty.t -> Ty.t -> bool
  val compare : Ty.t -> Ty.t -> int
  val min : Ty.t -> Ty.t -> Ty.t
  val max : Ty.t -> Ty.t -> Ty.t
end = Pervasives

module None : module type of Make(struct type t = unit end) = Pervasives
module Int : module type of Make(struct type t = int end) = Pervasives
module Bool : module type of Make(struct type t = bool end) = Pervasives
module Float : module type of Make(struct type t = float end) = Pervasives
module String : module type of Make(struct type t = string end) = Pervasives

module Stdlib = struct
  module Stdlib = struct
    include (Stdlib :
               module type of Stdlib
             with module List := Stdlib.List
              and module ListLabels := Stdlib.ListLabels
              and module StdLabels := Stdlib.StdLabels
              and module Pervasives := Stdlib.Pervasives
              and type in_channel := Stdlib.in_channel
              and type out_channel := Stdlib.out_channel
            )

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

    module Pervasives = struct
      include Pervasives
      include Int
    end

    include Pervasives
  end

  include Stdlib
end
