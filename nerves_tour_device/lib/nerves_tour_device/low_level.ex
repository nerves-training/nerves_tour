defmodule NervesTourDevice.LowLevel do
  use GenServer
  alias Circuits.GPIO

  @behaviour NervesTourUI.LowLevel

  @all_gpio_pins [4, 5, 6, 17, 22, 23, 27]

  @spec start_link(keyword()) :: GenServer.on_start()
  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  @impl NervesTourUI.LowLevel
  def get_gpios() do
    case Process.whereis(__MODULE__) do
      nil -> "..."
      pid -> GenServer.call(pid, :get_gpios)
    end
  end

  @impl true
  def init(_args) do
    gpios = Enum.map(@all_gpio_pins, &open_gpio/1)

    state = %{gpios: gpios}
    {:ok, state}
  end

  @impl true
  def handle_call(:get_gpios, _from, state) do
    result = gpios_to_string(state.gpios)

    {:reply, result, state}
  end

  defp open_gpio(pin) do
    {:ok, gpio} = GPIO.open(pin, :input, pull_mode: :pullup)
    gpio
  end

  defp gpios_to_string(gpios) do
    gpios
    |> Enum.map(&GPIO.read/1)
    |> Enum.map(&Integer.to_string/1)
    |> Enum.reduce("", &Kernel.<>/2)
  end
end
