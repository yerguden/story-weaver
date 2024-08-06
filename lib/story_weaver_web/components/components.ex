defmodule StoryWeaverWeb.Components do
  use Phoenix.Component

  # Define the attributes for the component
  attr :field, Phoenix.HTML.FormField
  attr :rest, :global, include: ~w(type)

  # Define the input function which renders the input element
  def input(assigns) do
    ~H"""
    <input id={@field.id} name={@field.name} value={@field.value} {@rest} />
    """
  end
end
