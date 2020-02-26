defmodule NervesTourUI.LowLevel do
  @callback get_gpios() :: String.t()
end
