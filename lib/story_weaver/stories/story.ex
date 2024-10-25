defmodule StoryWeaver.Stories.Story do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "stories" do
    field :title, :string
    belongs_to :user, StoryWeaver.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(story, attrs) do
    story
    |> cast(attrs, [:title])
    |> cast(attrs, [:user_id])
    |> validate_required([:title])
    |> validate_required([:user_id])
  end
end
