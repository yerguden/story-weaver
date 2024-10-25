defmodule StoryWeaver.Stories do
  @moduledoc """
  The Stories context.
  """

  import Ecto.Query, warn: false
  alias StoryWeaver.Accounts.User
  alias StoryWeaver.Repo

  alias StoryWeaver.Stories.Story

  @doc """
  Returns the list of stories.

  ## Examples

      iex> list_stories()
      [%Story{}, ...]

  """
  def list_stories do
    Repo.all(Story)
  end

  def list_stories(%User{id: user_id}) do
    Repo.all(from s in Story, where: s.user_id == ^user_id)
  end

  @doc """
  Gets a single story.

  Raises `Ecto.NoResultsError` if the Story does not exist.

  ## Examples

      iex> get_story!(123)
      %Story{}

      iex> get_story!(456)
      ** (Ecto.NoResultsError)

  """
  def get_story!(id), do: Repo.get!(Story, id)

  @doc """
  Gets a single story that belongs to the user.

  Raises `Ecto.NoResultsError` if the Story does not exist.

  ## Examples

      iex> get_story!(%User{}, 123)
      %Story{}

      iex> get_story!(%User{}, 456)
      ** (Ecto.NoResultsError)

  """
  def get_story!(%User{id: user_id}, id), do: Repo.get_by!(Story, id: id, user_id: user_id)

  @doc """
  Creates a story.

  ## Examples

      iex> create_story(%{field: value})
      {:ok, %Story{}}

      iex> create_story(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_story(attrs \\ %{}) do
    %Story{}
    |> Story.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a story.

  ## Examples

      iex> update_story(story, %{field: new_value})
      {:ok, %Story{}}

      iex> update_story(story, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_story(%Story{} = story, attrs) do
    story
    |> Story.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates the users story

  ## Examples

      iex> update_story(story, user, %{field: new_value})
      {:ok, %Story{}}

  """
  def update_story(%Story{} = story, %User{} = user, attrs) do
    if belongs_to_user?(story, user) do
      story
      |> Story.changeset(attrs)
      |> Repo.update()
    else
      {:error, "User is not authorized to update this story"}
    end
  end

  defp belongs_to_user?(%Story{} = story, %User{} = user) do
    story.user_id == user.id
  end

  @doc """
  Deletes a story.

  ## Examples

      iex> delete_story(story)
      {:ok, %Story{}}

      iex> delete_story(story)
      {:error, %Ecto.Changeset{}}

  """
  def delete_story(%Story{} = story) do
    Repo.delete(story)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking story changes.

  ## Examples

      iex> change_story(story)
      %Ecto.Changeset{data: %Story{}}

  """
  def change_story(%Story{} = story, attrs \\ %{}) do
    Story.changeset(story, attrs)
  end
end
