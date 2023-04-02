defmodule TicTacToeWeb.RoomsLiveTest do
  use TicTacToeWeb.ConnCase

  import Phoenix.LiveViewTest
  import TicTacToe.RoomFixtures

  @create_attrs %{name: "some name", owner: "7488a646-e31f-11e4-aace-600308960662"}
  @update_attrs %{name: "some updated name", owner: "7488a646-e31f-11e4-aace-600308960668"}
  @invalid_attrs %{name: nil, owner: nil}

  defp create_rooms(_) do
    rooms = rooms_fixture()
    %{rooms: rooms}
  end

  describe "Index" do
    setup [:create_rooms]

    test "lists all room", %{conn: conn, rooms: rooms} do
      {:ok, _index_live, html} = live(conn, ~p"/room")

      assert html =~ "Listing Room"
      assert html =~ rooms.name
    end

    test "saves new rooms", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/room")

      assert index_live |> element("a", "New Rooms") |> render_click() =~
               "New Rooms"

      assert_patch(index_live, ~p"/room/new")

      assert index_live
             |> form("#rooms-form", rooms: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#rooms-form", rooms: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/room")

      html = render(index_live)
      assert html =~ "Rooms created successfully"
      assert html =~ "some name"
    end

    test "updates rooms in listing", %{conn: conn, rooms: rooms} do
      {:ok, index_live, _html} = live(conn, ~p"/room")

      assert index_live |> element("#room-#{rooms.id} a", "Edit") |> render_click() =~
               "Edit Rooms"

      assert_patch(index_live, ~p"/room/#{rooms}/edit")

      assert index_live
             |> form("#rooms-form", rooms: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#rooms-form", rooms: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/room")

      html = render(index_live)
      assert html =~ "Rooms updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes rooms in listing", %{conn: conn, rooms: rooms} do
      {:ok, index_live, _html} = live(conn, ~p"/room")

      assert index_live |> element("#room-#{rooms.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#room-#{rooms.id}")
    end
  end

  describe "Show" do
    setup [:create_rooms]

    test "displays rooms", %{conn: conn, rooms: rooms} do
      {:ok, _show_live, html} = live(conn, ~p"/room/#{rooms}")

      assert html =~ "Show Rooms"
      assert html =~ rooms.name
    end

    test "updates rooms within modal", %{conn: conn, rooms: rooms} do
      {:ok, show_live, _html} = live(conn, ~p"/room/#{rooms}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Rooms"

      assert_patch(show_live, ~p"/room/#{rooms}/show/edit")

      assert show_live
             |> form("#rooms-form", rooms: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#rooms-form", rooms: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/room/#{rooms}")

      html = render(show_live)
      assert html =~ "Rooms updated successfully"
      assert html =~ "some updated name"
    end
  end
end
