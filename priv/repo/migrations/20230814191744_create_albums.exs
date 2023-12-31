defmodule Teacher.Repo.Migrations.CreateAlbums do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :title, :string
      add :artist, :string
      add :summary, :text
      add :year, :integer
      add :genre, :string

      timestamps()
    end
  end
end
