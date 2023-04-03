defmodule TicTacToeWeb.RoomsLive.Index do
  use TicTacToeWeb, :live_view

  alias TicTacToe.Room
  alias TicTacToe.Room.Rooms

  @impl true
  def mount(_params, _session, socket) do
    IO.inspect(Room.list_room())
    {:ok, stream(socket, :room, Room.list_room())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Rooms")
    |> assign(:rooms, Room.get_rooms!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Rooms")
    |> assign(:rooms, %Rooms{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Room")
    |> assign(:rooms, nil)
  end

  @impl true
  def handle_info({TicTacToeWeb.RoomsLive.FormComponent, {:saved, rooms}}, socket) do
    {:noreply, stream_insert(socket, :room, rooms)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    rooms = Room.get_rooms!(id)
    {:ok, _} = Room.delete_rooms(rooms)

    {:noreply, stream_delete(socket, :room, rooms)}
  end
end
