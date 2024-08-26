defmodule StoryWeaverWeb.StoryHTML do
  use StoryWeaverWeb, :html

  embed_templates "story_html/*"

  @doc """
  Renders a story form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def story_form(assigns)
end
