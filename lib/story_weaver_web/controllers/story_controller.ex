defmodule StoryWeaverWeb.StoryController do
  use StoryWeaverWeb, :controller

  alias StoryWeaver.Stories
  alias StoryWeaver.Stories.Story

  def index(conn, _params) do
    stories = Stories.list_stories()
    render(conn, :index, stories: stories)
  end

  def new(conn, _params) do
    changeset = Stories.change_story(%Story{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"story" => story_params}) do
    case Stories.create_story(story_params) do
      {:ok, story} ->
        conn
        |> put_flash(:info, "Story created successfully.")
        |> redirect(to: ~p"/stories/#{story}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    story = Stories.get_story!(id)
    render(conn, :show, story: story)
  end

  def edit(conn, %{"id" => id}) do
    story = Stories.get_story!(id)
    changeset = Stories.change_story(story)
    render(conn, :edit, story: story, changeset: changeset)
  end

  def update(conn, %{"id" => id, "story" => story_params}) do
    story = Stories.get_story!(id)

    case Stories.update_story(story, story_params) do
      {:ok, story} ->
        conn
        |> put_flash(:info, "Story updated successfully.")
        |> redirect(to: ~p"/stories/#{story}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, story: story, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    story = Stories.get_story!(id)
    {:ok, _story} = Stories.delete_story(story)

    conn
    |> put_flash(:info, "Story deleted successfully.")
    |> redirect(to: ~p"/stories")
  end
end
