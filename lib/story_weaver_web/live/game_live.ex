defmodule StoryWeaverWeb.GameLive do
  # In Phoenix v1.6+ apps, the line is typically: use MyAppWeb, :live_view
  use Phoenix.LiveView
  import StoryWeaverWeb.Components

  defmodule Message do
    defstruct [:content, :from]

    def get_content(%Message{content: content}), do: content
    def user_message(content), do: %Message{content: content, from: :user}
    def user_message?(%Message{from: :user}), do: false
    def user_message?(_), do: false
  end

  def render(assigns) do
    ~H"""
    <div class="container mx-auto p-4">
      <div class="bg-white rounded-lg shadow-lg p-6">
        <h1 class="text-2xl font-bold mb-4">D&D Chat Bot</h1>
        <div id="chat" class="chat-container mb-4 p-4 bg-gray-200 rounded-lg overflow-y-scroll">
          <%= for message <- @messages do %>
            <%= if Message.user_message?(message) do %>
              <div><%= Message.get_content(message) %></div>
            <% else %>
              <div><%= Message.get_content(message) %></div>
            <% end %>
          <% end %>
        </div>
        <form phx-submit="send_message">
          <div class="flex">
            <input
              type="text"
              name="message"
              class="flex-grow p-2 border rounded-lg"
              placeholder="Whats your next move..."
            />
            <button class="ml-2 p-2 bg-blue-500 text-white rounded-lg">Send</button>
          </div>
        </form>
      </div>
    </div>
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
        Message.user_message(message_content) | socket.assigns.messages
      ])

    {:noreply, update(socket, :message, fn _ -> "" end)}
  end
end
