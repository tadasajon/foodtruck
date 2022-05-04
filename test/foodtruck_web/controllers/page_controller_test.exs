defmodule FoodtruckWeb.PageControllerTest do
  use FoodtruckWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "TRUCK"
    assert html_response(conn, 200) =~ "MENU"
    assert html_response(conn, 200) =~ "ADDRESS"
  end
end
