defmodule PhoenixTrello.Repo.Migrations.CreateCard do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :name, :string, null: false
      add :list_id, references(:lists, on_delete: :nothing), null: false

      timestamps
    end
    create index(:cards, [:list_id])

  end
end
