defmodule NervesTourDevice.LowLevel do
  @behaviour NervesTourUI.LowLevel

  alias Circuits.GPIO

  @impl NervesTourUI.LowLevel
  def get_gpios() do
    {:ok, gpio} = GPIO.open(5, :input, pull_mode: :pullup)
    value = GPIO.read(gpio)
    GPIO.close(gpio)
    to_string(value)
  end
end
