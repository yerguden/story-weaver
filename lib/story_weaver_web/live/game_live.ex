defmodule StoryWeaverWeb.GameLive do
  # In Phoenix v1.6+ apps, the line is typically: use MyAppWeb, :live_view
  use Phoenix.LiveView
  import StoryWeaverWeb.Components

  defmodule Message do
    defstruct [:content]

    def get_content(%Message{content: content}), do: content
    def new_message(content), do: %Message{content: content}
  end

  def render(assigns) do
    ~H"""
    <ul>
      <%= for message <- @messages do %>
        <li><%= Message.get_content(message) %></li>
      <% end %>
    </ul>
    <form phx-submit="send_message">
      <input type="text" name="message" value={@message} />
      <button>Save</button>
    </form>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, message: "", messages: [])}
  end

  def handle_event("send_message", %{"message" => message_content}, socket) do
    # Send message to messages list => Which may be a struct ? 
    # reset the existing message 
    socket =
      socket
      |> assign(:messages, [
        Message.new_message(message_content) | socket.assigns.messages
      ])

    {:noreply, update(socket, :message, fn _ -> "" end)}
  end
end
