(*
Copyright (c) 2014-2015 Jacques-Pascal Deplaix <jp.deplaix@gmail.com>

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

module Open : sig
  open Containers

  module Bool : sig
    include module type of Bool

    module Infix : module type of Monomorphic.MakeInfix(struct type t = bool end)
    module Cmp : module type of Monomorphic.MakeCmp(struct type t = bool end)
  end

  module Int : sig
    include module type of Int

    module Infix : module type of Monomorphic.MakeInfix(struct type t = int end)
    module Cmp : module type of Monomorphic.MakeCmp(struct type t = int end)
  end

  module Float : sig
    include module type of Float

    module Infix : module type of Monomorphic.MakeInfix(struct type t = float end)
    module Cmp : module type of Monomorphic.MakeCmp(struct type t = float end)
  end

  module String : sig
    include module type of String

    module Infix : module type of Monomorphic.MakeInfix(struct type t = string end)
    module Cmp : module type of Monomorphic.MakeCmp(struct type t = string end)
  end

  include module type of (Containers :
                            module type of Containers
                          with module Bool := Bool
                           and module Int := Int
                           and module Float := Float
                           and module String := String
                         )
end

module Named : sig
  module CCBool : sig
    include module type of CCBool

    module Infix : module type of Monomorphic.MakeInfix(struct type t = bool end)
    module Cmp : module type of Monomorphic.MakeCmp(struct type t = bool end)
  end

  module CCInt : sig
    include module type of CCInt

    module Infix : module type of Monomorphic.MakeInfix(struct type t = int end)
    module Cmp : module type of Monomorphic.MakeCmp(struct type t = int end)
  end

  module CCFloat : sig
    include module type of CCFloat

    module Infix : module type of Monomorphic.MakeInfix(struct type t = float end)
    module Cmp : module type of Monomorphic.MakeCmp(struct type t = float end)
  end

  module CCString : sig
    include module type of CCString

    module Infix : module type of Monomorphic.MakeInfix(struct type t = string end)
    module Cmp : module type of Monomorphic.MakeCmp(struct type t = string end)
  end
end
