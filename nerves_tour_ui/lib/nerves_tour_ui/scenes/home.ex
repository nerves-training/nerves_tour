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

    {:ok, hostname} = :inet.gethostname()
    graph = @graph |> Graph.modify(:hostname, &text(&1, to_string(hostname)))

    {:ok, graph, push: graph}
  end

  def handle_input({:key, {key, :press, 0}}, _context, graph) do
    string = "Last key: #{key}"
    new_graph = graph |> Graph.modify(:last_key, &text(&1, string))

    {:noreply, new_graph, push: new_graph}
  end

  def handle_input(event, _context, state) do
    Logger.info("Received event: #{inspect(event)}")
    {:noreply, state}
  end
end
