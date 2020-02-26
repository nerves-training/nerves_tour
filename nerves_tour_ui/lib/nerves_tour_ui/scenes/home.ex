defmodule NervesTourUI.Scene.Home do
  use Scenic.Scene
  require Logger

  alias Scenic.Graph
  import Scenic.Primitives

  @graph Graph.build(font: ScenicFontPressStart2p.hash(), font_size: 8)
         |> text("GPIO: ...", translate: {5, 20}, id: :gpio)
         |> text("Last key: ...", translate: {5, 30}, id: :last_key)
         |> text("Hostname", translate: {5, 60}, id: :hostname)

  def init(_, _opts) do
    ScenicFontPressStart2p.load()

    graph = @graph

    {:ok, graph, push: graph}
  end

  def handle_input(event, _context, state) do
    Logger.info("Received event: #{inspect(event)}")
    {:noreply, state}
  end
end
