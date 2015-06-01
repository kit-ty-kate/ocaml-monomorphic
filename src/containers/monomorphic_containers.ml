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



module Open = struct
  open Containers

  module Bool = struct
    include Bool

    module Infix = Monomorphic.MakeInfix(struct type t = bool end)
    module Cmp = Monomorphic.MakeCmp(struct type t = bool end)
  end

  module Int = struct
    include Int

    module Infix = Monomorphic.MakeInfix(struct type t = int end)
    module Cmp = Monomorphic.MakeCmp(struct type t = int end)
  end

  module Float = struct
    include Float

    module Infix = Monomorphic.MakeInfix(struct type t = float end)
    module Cmp = Monomorphic.MakeCmp(struct type t = float end)
  end

  module String = struct
    include String

    module Infix = Monomorphic.MakeInfix(struct type t = string end)
    module Cmp = Monomorphic.MakeCmp(struct type t = string end)
  end

  include (Containers :
             module type of Containers
           with module Bool := Bool
            and module Int := Int
            and module Float := Float
            and module String := String
          )
end

module Named = struct
  module CCBool = struct
    include CCBool

    module Infix = Monomorphic.MakeInfix(struct type t = bool end)
    module Cmp = Monomorphic.MakeCmp(struct type t = bool end)
  end

  module CCInt = struct
    include CCInt

    module Infix = Monomorphic.MakeInfix(struct type t = int end)
    module Cmp = Monomorphic.MakeCmp(struct type t = int end)
  end

  module CCFloat = struct
    include CCFloat

    module Infix = Monomorphic.MakeInfix(struct type t = float end)
    module Cmp = Monomorphic.MakeCmp(struct type t = float end)
  end

  module CCString = struct
    include CCString

    module Infix = Monomorphic.MakeInfix(struct type t = string end)
    module Cmp = Monomorphic.MakeCmp(struct type t = string end)
  end
end
