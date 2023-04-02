defmodule TicTacToeWeb.RoomsLive.FormComponent do
  use TicTacToeWeb, :live_component

  alias TicTacToe.Room

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage rooms records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="rooms-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:owner]} type="text" label="Owner" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Rooms</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{rooms: rooms} = assigns, socket) do
    changeset = Room.change_rooms(rooms)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"rooms" => rooms_params}, socket) do
    changeset =
      socket.assigns.rooms
      |> Room.change_rooms(rooms_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"rooms" => rooms_params}, socket) do
    save_rooms(socket, socket.assigns.action, rooms_params)
  end

  defp save_rooms(socket, :edit, rooms_params) do
    case Room.update_rooms(socket.assigns.rooms, rooms_params) do
      {:ok, rooms} ->
        notify_parent({:saved, rooms})

        {:noreply,
         socket
         |> put_flash(:info, "Rooms updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_rooms(socket, :new, rooms_params) do
    case Room.create_rooms(rooms_params) do
      {:ok, rooms} ->
        notify_parent({:saved, rooms})

        {:noreply,
         socket
         |> put_flash(:info, "Rooms created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
