defmodule TicTacToe.Room.Rooms do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "room" do
    field :name, :string
    field :owner, Ecto.UUID

    timestamps()
  end

  @doc false
  def changeset(rooms, attrs) do
    rooms
    |> cast(attrs, [:name, :owner])
    |> validate_required([:name, :owner])
  end
end
