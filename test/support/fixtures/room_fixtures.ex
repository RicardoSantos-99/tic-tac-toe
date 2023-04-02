defmodule TicTacToe.RoomFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TicTacToe.Room` context.
  """

  @doc """
  Generate a rooms.
  """
  def rooms_fixture(attrs \\ %{}) do
    {:ok, rooms} =
      attrs
      |> Enum.into(%{
        name: "some name",
        owner: "7488a646-e31f-11e4-aace-600308960662"
      })
      |> TicTacToe.Room.create_rooms()

    rooms
  end
end
