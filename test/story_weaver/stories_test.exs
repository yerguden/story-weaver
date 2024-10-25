defmodule StoryWeaver.StoriesTest do
  alias StoryWeaver.AccountsFixtures
  use StoryWeaver.DataCase

  alias StoryWeaver.Stories

  describe "stories" do
    alias StoryWeaver.Stories.Story

    import StoryWeaver.StoriesFixtures
    import StoryWeaver.AccountsFixtures

    @invalid_attrs %{title: nil}

    test "list_stories/0 returns all stories" do
      story = story_fixture()
      assert Stories.list_stories() == [story]
    end

    test "list_stories/1 returns the users stories" do
      user = user_fixture()
      story_a = story_fixture(%{user_id: user.id})
      story_b = story_fixture()
      assert Stories.list_stories(user) == [story_a]
    end

    test "get_story!/1 returns the story with given id" do
      story = story_fixture()
      assert Stories.get_story!(story.id) == story
    end

    test "get_story!/2 returns the user story with given id" do
      user = user_fixture()
      story = story_fixture(%{user_id: user.id})
      assert Stories.get_story!(user, story.id) == story
    end

    test "get_story!/2 throws an error if story belongs to another user" do
      user = user_fixture()
      story = story_fixture()
      assert_raise Ecto.NoResultsError, fn -> Stories.get_story!(user, story.id) end
    end

    test "create_story/1 with valid data creates a story" do
      user = user_fixture()
      valid_attrs = %{title: "some title", user_id: user.id}

      assert {:ok, %Story{} = story} = Stories.create_story(valid_attrs)
      assert story.title == "some title"
      assert story.user_id == user.id
    end

    test "create_story/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stories.create_story(@invalid_attrs)
    end

    test "update_story/2 with valid data updates the story" do
      story = story_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Story{} = story} = Stories.update_story(story, update_attrs)
      assert story.title == "some updated title"
    end

    test "update_story/2 with invalid data returns error changeset" do
      story = story_fixture()
      assert {:error, %Ecto.Changeset{}} = Stories.update_story(story, @invalid_attrs)
      assert story == Stories.get_story!(story.id)
    end

    test "update_story/3 with valid data updates the story of the user" do
      user = user_fixture()
      story = story_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Story{} = story} = Stories.update_story(story, update_attrs)
      assert story.title == "some updated title"
    end

    test "delete_story/1 deletes the story" do
      story = story_fixture()
      assert {:ok, %Story{}} = Stories.delete_story(story)
      assert_raise Ecto.NoResultsError, fn -> Stories.get_story!(story.id) end
    end

    test "change_story/1 returns a story changeset" do
      story = story_fixture()
      assert %Ecto.Changeset{} = Stories.change_story(story)
    end
  end
end
