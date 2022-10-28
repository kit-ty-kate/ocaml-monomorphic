[@@@ocaml.warning "-32"]

module CheckExternal : sig
  external (=) : int -> int -> bool = "%equal"
  external (<>) : int -> int -> bool = "%notequal"
  external (<) : int -> int -> bool = "%lessthan"
  external (>) : int -> int -> bool = "%greaterthan"
  external (<=) : int -> int -> bool = "%lessequal"
  external (>=) : int -> int -> bool = "%greaterequal"
  external compare : int -> int -> int = "%compare"
  val min : int -> int -> int (* TODO: Add some kind of tests to ensure those functions *)
  val max : int -> int -> int (* stay in sync with the standard library in terms of
                                 whether they are externals or not *)
end = Monomorphic.Stdlib

module CheckTypes : sig
  module type T = sig
    val (=) : int -> int -> bool
    val (<>) : int -> int -> bool
    val (<) : int -> int -> bool
    val (>) : int -> int -> bool
    val (<=) : int -> int -> bool
    val (>=) : int -> int -> bool
    val compare : int -> int -> int
    val min : int -> int -> int
    val max : int -> int -> int
  end
end = struct
  module type T = module type of struct
    open Monomorphic.Stdlib

    let (=) = (=)
    let (<>) = (<>)
    let (<) = (<)
    let (>) = (>)
    let (<=) = (<=)
    let (>=) = (>=)
    let compare = compare
    let min = min
    let max = max
  end
end
