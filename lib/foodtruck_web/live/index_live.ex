defmodule FoodtruckWeb.IndexLive do
  use FoodtruckWeb, :live_view
  alias NimbleCSV.RFC4180, as: CSV

  @impl true
  def mount(_params, _session, socket) do
    %HTTPoison.Response{body: body} =
      HTTPoison.get!("https://data.sfgov.org/api/views/rqzj-sfat/rows.csv")

    csv =
      CSV.parse_string(body)
      |> Enum.map(fn row -> [Enum.at(row, 1), Enum.at(row, 11), Enum.at(row, 4)] end)

    {:ok, assign(socket, csv: csv, search: false)}
  end

  @impl true
  def handle_event("search", %{"search_text" => search_text}, socket) do
    {:noreply,
     assign(socket, search: true, search_text: Regex.compile!(search_text, [:caseless]))}
  end
end
