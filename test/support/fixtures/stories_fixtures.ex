defmodule StoryWeaver.StoriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `StoryWeaver.Stories` context.
  """

  @doc """
  Generate a story.
  """
  def story_fixture(attrs \\ %{}) do
    {:ok, story} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> StoryWeaver.Stories.create_story()

    story
  end
end
