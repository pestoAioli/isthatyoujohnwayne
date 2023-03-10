defmodule IsThatYouJohnWayneWeb.PageLive do
  use IsThatYouJohnWayneWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, text: nil, task: nil, result: nil)}
  end

  def handle_event("predict", params, socket) do
    case params["text"] do
      "" ->
        {:noreply, assign(socket, text: nil, task: nil, result: nil)}

      text ->
        task = Task.async(fn -> Nx.Serving.batched_run(MyServing, text) end)

        {:noreply, assign(socket, text: text, task: task, result: nil)}
    end
  end

  def handle_info({ref, result}, socket) when socket.assigns.task.ref == ref do
    [%{text: text}] = result.results
    {:noreply, assign(socket, task: nil, result: text)}
  end

  def handle_info(_, socket) do
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="h-screen m-auto flex items-center justify-center antialiased">
    <div class="flex flex-col h-1/2 w-1/2">
    <p> </p>
    <form class="m-0 flex space-x-2" phx-change="predict">
    <textarea
      class="block w-full"
      type="text"
      name="text"
      phx-debounce="300"
      value={@text}
      placeholder="Start typing here and then wait for assistance..."
    />
    </form>
    <div class="mt-2 flex space-x-1.5 items-center">
          <%= if @task do %>            
            <span> thinking...</span>
          <% end %>
    <span class="font-medium"><%= @result %></span>
    </div>
    </div>
    </div>
    """
  end
end
