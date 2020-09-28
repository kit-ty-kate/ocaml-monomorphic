(* Copyright (c) 2013-2017 Kate <kit.ty.kate@disroot.org>. *)
(* See the LICENSE file at the top-level directory. *)

[@@@ocaml.alert "-deprecated"]

(** Shadow with specialised functions using [Ty.t] *)
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
end

(** Almost complete removal of the functions by shadowing *)
module None : module type of Make(struct type t = unit end)

(** Specialize functions with [int] *)
module Int : module type of Make(struct type t = int end)

(** Specialize functions with [bool] *)
module Bool : module type of Make(struct type t = bool end)
 
(** Specialize functions with [float] *)
module Float : module type of Make(struct type t = float end)

(** Specialize functions with [string] *)
module String : module type of Make(struct type t = string end)

type 'a eq = 'a -> 'a -> bool

module Stdlib : sig
  module List : sig
    include module type of List

    val mem : 'a -> eq:'a eq -> 'a list -> bool
    val assoc : 'k -> eq:'k eq -> ('k * 'a) list -> 'a
    val mem_assoc : 'k -> eq:'k eq -> ('k * _) list -> bool
    val remove_assoc : 'k -> eq:'k eq -> ('k * 'a) list -> ('k * 'a) list
  end

  module StdLabels : sig
    include module type of (StdLabels :
                              module type of StdLabels
                            with module List := StdLabels.List
                           )

    module List : sig
      include module type of StdLabels.List

      val mem : 'a -> eq:'a eq -> set:'a list -> bool
      val assoc : 'k -> eq:'k eq -> ('k * 'a) list -> 'a
      val mem_assoc : 'k -> eq:'k eq -> map:('k * _) list -> bool
      val remove_assoc : 'k -> eq:'k eq -> ('k * 'a) list -> ('k * 'a) list
    end
  end

  include module type of None
end
