defmodule NervesTourUI.MockLowLevel do
  @behaviour NervesTourUI.LowLevel

  @impl true
  def get_gpios() do
    "#{rand_bit()}#{rand_bit()}#{rand_bit()}#{rand_bit()}#{rand_bit()}"
  end

  defp rand_bit() do
    :rand.uniform(2) - 1
  end
end
