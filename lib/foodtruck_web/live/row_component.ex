defmodule FoodtruckWeb.RowComponent do
  use FoodtruckWeb, :live_component

  def render(assigns) do
    row = assigns.row

    ~H"""
        <div class="border border-gray-200 p-2 col-span-2">
            <%= Enum.at(row, 0) %>
        </div>

        <div class="border border-gray-200 p-2 col-span-5">
            <%= Enum.at(row, 1) %>
        </div>

        <div class="border border-gray-200 p-2 text-xs col-span-2">
            <%= Enum.at(row, 2) %>
        </div>
    """
  end
end
