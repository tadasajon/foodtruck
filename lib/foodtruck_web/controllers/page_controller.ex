defmodule FoodtruckWeb.PageController do
  use FoodtruckWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
