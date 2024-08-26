defmodule StoryWeaverWeb.StoryControllerTest do
  use StoryWeaverWeb.ConnCase

  import StoryWeaver.StoriesFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all stories", %{conn: conn} do
      conn = get(conn, ~p"/stories")
      assert html_response(conn, 200) =~ "Listing Stories"
    end
  end

  describe "new story" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/stories/new")
      assert html_response(conn, 200) =~ "New Story"
    end
  end

  describe "create story" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/stories", story: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/stories/#{id}"

      conn = get(conn, ~p"/stories/#{id}")
      assert html_response(conn, 200) =~ "Story #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/stories", story: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Story"
    end
  end

  describe "edit story" do
    setup [:create_story]

    test "renders form for editing chosen story", %{conn: conn, story: story} do
      conn = get(conn, ~p"/stories/#{story}/edit")
      assert html_response(conn, 200) =~ "Edit Story"
    end
  end

  describe "update story" do
    setup [:create_story]

    test "redirects when data is valid", %{conn: conn, story: story} do
      conn = put(conn, ~p"/stories/#{story}", story: @update_attrs)
      assert redirected_to(conn) == ~p"/stories/#{story}"

      conn = get(conn, ~p"/stories/#{story}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, story: story} do
      conn = put(conn, ~p"/stories/#{story}", story: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Story"
    end
  end

  describe "delete story" do
    setup [:create_story]

    test "deletes chosen story", %{conn: conn, story: story} do
      conn = delete(conn, ~p"/stories/#{story}")
      assert redirected_to(conn) == ~p"/stories"

      assert_error_sent 404, fn ->
        get(conn, ~p"/stories/#{story}")
      end
    end
  end

  defp create_story(_) do
    story = story_fixture()
    %{story: story}
  end
end
