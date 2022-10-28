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

module Stdlib : sig
  module Stdlib : sig
    module List : sig
      include module type of List

      val mem : 'a -> eq:('a -> 'a -> bool) -> 'a list -> bool
      val assoc : 'k -> eq:('k -> 'k -> bool) -> ('k * 'a) list -> 'a
      val assoc_opt : 'k -> eq:('k -> 'k -> bool) -> ('k * 'a) list -> 'a option
      val mem_assoc : 'k -> eq:('k -> 'k -> bool) -> ('k * _) list -> bool
      val remove_assoc : 'k -> eq:('k -> 'k -> bool) -> ('k * 'a) list -> ('k * 'a) list
    end

    module ListLabels : sig
      include module type of ListLabels

      val mem : 'a -> eq:('a -> 'a -> bool) -> set:'a list -> bool
      val assoc : 'k -> eq:('k -> 'k -> bool) -> ('k * 'a) list -> 'a
      val assoc_opt : 'k -> eq:('k -> 'k -> bool) -> ('k * 'a) list -> 'a option
      val mem_assoc : 'k -> eq:('k -> 'k -> bool) -> map:('k * _) list -> bool
      val remove_assoc : 'k -> eq:('k -> 'k -> bool) -> ('k * 'a) list -> ('k * 'a) list
    end

    module StdLabels : sig
      include module type of (StdLabels :
                                module type of StdLabels
                              with module List := StdLabels.List
                             )

      module List = ListLabels
    end

#if OCAML_VERSION < (5, 0, 0)
    module Pervasives : sig
      include module type of Pervasives
      include module type of Int
    end
#endif

    include module type of (Stdlib :
                              module type of Stdlib
                            with module List := Stdlib.List
                             and module ListLabels := Stdlib.ListLabels
                             and module StdLabels := Stdlib.StdLabels
#if OCAML_VERSION < (5, 0, 0)
                             and module Pervasives := Stdlib.Pervasives
#endif
                             and module Int := Stdlib.Int
                           )

    include module type of Int
    module Int = Stdlib.Int
  end

  include module type of Stdlib
end
