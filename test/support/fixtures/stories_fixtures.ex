defmodule StoryWeaver.StoriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `StoryWeaver.Stories` context.
  """
  alias StoryWeaver.AccountsFixtures

  @doc """
  Generate a story.
  """
  def story_fixture(attrs \\ %{}) do
    %{id: user_id} = AccountsFixtures.user_fixture()

    {:ok, story} =
      attrs
      |> Enum.into(%{
        title: "some title",
        user_id: user_id
      })
      |> StoryWeaver.Stories.create_story()

    story
  end
end
