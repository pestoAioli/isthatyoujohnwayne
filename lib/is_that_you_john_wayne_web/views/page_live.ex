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
    [%{label: label, score: _} | _] = result.predictions
    {:noreply, assign(socket, task: nil, result: label)}
  end

  def handle_info(_, socket) do
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="h-screen m-auto flex items-center justify-center antialiased">
    <div class="flex flex-col h-1/2 w-1/2">
    <form class="m-0 flex space-x-2" phx-change="predict">
    <input
      class="block w-full"
      type="text"
      name="text"
      phx-debounce="300"
      value={@text}
    />
    </form>
    <div class="mt-2 flex space-x-1.5 items-center">
    <span> Emotion: </span>
    <span class="font-medium"><%= @result %></span>
    </div>
    </div>
    </div>
    """
  end
end
