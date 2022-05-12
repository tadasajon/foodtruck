defmodule FoodtruckWeb.IndexLive do
  use FoodtruckWeb, :live_view
  alias NimbleCSV.RFC4180, as: CSV

  @impl true
  def mount(_params, _session, socket) do
    %HTTPoison.Response{body: body} =
      HTTPoison.get!("https://data.sfgov.org/api/views/rqzj-sfat/rows.csv")

    [csv_header | csv_body] = CSV.parse_string(body, skip_headers: false)

    location_ndx = Enum.find_index(csv_header, fn header -> header == "LocationDescription" end)
    truckname_ndx = Enum.find_index(csv_header, fn header -> header == "Applicant" end)
    menu_ndx = Enum.find_index(csv_header, fn header -> header == "FoodItems" end)

    csv_body =
      Enum.map(csv_body, fn row ->
        [
          Enum.at(row, truckname_ndx),
          Enum.at(row, menu_ndx),
          Enum.at(row, location_ndx)
        ]
      end)

    {:ok, assign(socket, csv: csv_body, search: false)}
  end

  @impl true
  def handle_event("search", %{"search_text" => search_text}, socket) do
    case String.length(search_text) do
      n when n in [0, 1] ->
        {:noreply, assign(socket, search: false)}

      _ ->
        {:noreply,
         assign(socket, search: true, search_text: Regex.compile!(search_text, [:caseless]))}
    end
  end
end
