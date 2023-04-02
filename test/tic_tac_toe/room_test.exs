defmodule TicTacToe.RoomTest do
  use TicTacToe.DataCase

  alias TicTacToe.Room

  describe "room" do
    alias TicTacToe.Room.Rooms

    import TicTacToe.RoomFixtures

    @invalid_attrs %{name: nil, owner: nil}

    test "list_room/0 returns all room" do
      rooms = rooms_fixture()
      assert Room.list_room() == [rooms]
    end

    test "get_rooms!/1 returns the rooms with given id" do
      rooms = rooms_fixture()
      assert Room.get_rooms!(rooms.id) == rooms
    end

    test "create_rooms/1 with valid data creates a rooms" do
      valid_attrs = %{name: "some name", owner: "7488a646-e31f-11e4-aace-600308960662"}

      assert {:ok, %Rooms{} = rooms} = Room.create_rooms(valid_attrs)
      assert rooms.name == "some name"
      assert rooms.owner == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_rooms/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Room.create_rooms(@invalid_attrs)
    end

    test "update_rooms/2 with valid data updates the rooms" do
      rooms = rooms_fixture()
      update_attrs = %{name: "some updated name", owner: "7488a646-e31f-11e4-aace-600308960668"}

      assert {:ok, %Rooms{} = rooms} = Room.update_rooms(rooms, update_attrs)
      assert rooms.name == "some updated name"
      assert rooms.owner == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_rooms/2 with invalid data returns error changeset" do
      rooms = rooms_fixture()
      assert {:error, %Ecto.Changeset{}} = Room.update_rooms(rooms, @invalid_attrs)
      assert rooms == Room.get_rooms!(rooms.id)
    end

    test "delete_rooms/1 deletes the rooms" do
      rooms = rooms_fixture()
      assert {:ok, %Rooms{}} = Room.delete_rooms(rooms)
      assert_raise Ecto.NoResultsError, fn -> Room.get_rooms!(rooms.id) end
    end

    test "change_rooms/1 returns a rooms changeset" do
      rooms = rooms_fixture()
      assert %Ecto.Changeset{} = Room.change_rooms(rooms)
    end
  end
end
