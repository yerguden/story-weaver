defmodule StoryWeaverWeb.GameLiveTest do
  use StoryWeaverWeb.ConnCase
  import Phoenix.LiveViewTest

  test "renders form receives the user messages", %{conn: conn} do
    {:ok, view, html} = live(conn, "/")

    assert view |> form("form", %{message: "Hello"}) |> render_submit() =~ "Hello"
  end
end
