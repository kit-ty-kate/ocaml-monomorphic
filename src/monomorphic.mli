(*
Copyright (c) 2014 Jacques-Pascal Deplaix <jp.deplaix@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*)

(** Almost complete removal of the functions by shadowing *)
module None : sig
  val (=) : unit -> unit -> unit
  val (<>) : unit -> unit -> unit
  val (<) : unit -> unit -> unit
  val (>) : unit -> unit -> unit
  val (<=) : unit -> unit -> unit
  val (>=) : unit -> unit -> unit
  val compare : unit -> unit -> unit
  val min : unit -> unit -> unit
  val max : unit -> unit -> unit
end

module type TY = sig
  type t
end

(** Shadow with specialised functions using [TY.t] *)
module Make (Ty : TY) : sig
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

(** Specialize functions with [int] *)
module Int : module type of Make(struct type t = int end)

(** Specialize functions with [float] *)
module Float : module type of Make(struct type t = float end)

module Stdlib : sig
  type 'a eq = 'a -> 'a -> bool

  module List : sig
    include module type of List

    val mem : 'a -> f:'a eq -> 'a list -> bool
    val assoc : 'k -> f:'k eq -> ('k * 'a) list -> 'a
    val mem_assoc : 'k -> f:'k eq -> ('k * _) list -> bool
    val remove_assoc : 'k -> f:'k eq -> ('k * 'a) list -> ('k * 'a) list
  end
end
