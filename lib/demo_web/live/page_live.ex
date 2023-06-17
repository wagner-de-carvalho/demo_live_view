defmodule DemoWeb.PageLive do
  use DemoWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, assign(socket, number: 0, form: to_form(%{adding_amount_default: 7}))}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <%= @number %>
    <.button phx-click="add">Add</.button>

    <.simple_form for={@form} phx-submit="adding_more">
      <.input field={@form[:add_amount]} value={@form.params.adding_amount_default} />
      <.button>Add More</.button>
    </.simple_form>
    """
  end

  @impl true
  def handle_event("add", _params, socket) do
    {:noreply, assign(socket, number: socket.assigns.number + 1)}
  end

  @impl true
  def handle_event("adding_more", %{"add_amount" => the_added_amount}, socket) do
    {number, _} = Integer.parse(the_added_amount)
    {:noreply, assign(socket, number: socket.assigns.number + number)}
  end
end
