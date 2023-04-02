defmodule TicTacToe.Repo.Migrations.CreateRoom do
  use Ecto.Migration

  def change do
    create table(:room, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :owner, :uuid

      timestamps()
    end
  end
end
