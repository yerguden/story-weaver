defmodule StoryWeaverWeb.StoryLiveTest do
  alias StoryWeaver.AccountsFixtures
  use StoryWeaverWeb.ConnCase

  import Phoenix.LiveViewTest
  import StoryWeaver.StoriesFixtures

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  defp create_story(%{user: user}) do
    story = story_fixture(%{user_id: user.id})

    %{story: story}
  end

  defp create_unauthorised_story(_) do
    user = AccountsFixtures.user_fixture()
    story = story_fixture(%{user: user, title: "some other title"})
    %{other_story: story}
  end

  describe "Index" do
    setup [:register_and_log_in_user, :create_story, :create_unauthorised_story]

    test "lists all stories", %{conn: conn, story: story} do
      {:ok, _index_live, html} = live(conn, ~p"/stories")

      assert html =~ "Listing Stories"
      assert html =~ story.title
    end

    test "saves new story", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/stories")

      assert index_live |> element("a", "New Story") |> render_click() =~
               "New Story"

      assert_patch(index_live, ~p"/stories/new")

      assert index_live
             |> form("#story-form", story: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#story-form", story: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/stories")

      html = render(index_live)
      assert html =~ "Story created successfully"
      assert html =~ "some title"
    end

    test "updates story in listing", %{conn: conn, story: story} do
      {:ok, index_live, _html} = live(conn, ~p"/stories")

      assert index_live |> element("#stories-#{story.id} a", "Edit") |> render_click() =~
               "Edit Story"

      assert_patch(index_live, ~p"/stories/#{story}/edit")

      assert index_live
             |> form("#story-form", story: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#story-form", story: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/stories")

      html = render(index_live)
      assert html =~ "Story updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes story in listing", %{conn: conn, story: story} do
      {:ok, index_live, _html} = live(conn, ~p"/stories")

      assert index_live |> element("#stories-#{story.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#stories-#{story.id}")
    end

    test "can't view other users stories", %{conn: conn, other_story: other_story} do
      {:ok, _index_live, html} = live(conn, ~p"/stories")

      refute html =~ other_story.title
    end
  end

  describe "Show" do
    setup [:register_and_log_in_user, :create_story]

    test "displays story", %{conn: conn, story: story} do
      {:ok, _show_live, html} = live(conn, ~p"/stories/#{story}")

      assert html =~ "Show Story"
      assert html =~ story.title
    end

    test "updates story within modal", %{conn: conn, story: story} do
      {:ok, show_live, _html} = live(conn, ~p"/stories/#{story}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Story"

      assert_patch(show_live, ~p"/stories/#{story}/show/edit")

      assert show_live
             |> form("#story-form", story: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#story-form", story: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/stories/#{story}")

      html = render(show_live)
      assert html =~ "Story updated successfully"
      assert html =~ "some updated title"
    end
  end
end
