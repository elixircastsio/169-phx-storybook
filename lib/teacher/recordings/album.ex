defmodule Teacher.Recordings.Album do
  use Ecto.Schema
  import Ecto.Changeset

  schema "albums" do
    field :artist, :string
    field :genre, :string
    field :summary, :string
    field :title, :string
    field :year, :integer

    timestamps()
  end

  @doc false
  def changeset(album, attrs) do
    album
    |> cast(attrs, [:title, :artist, :summary, :year, :genre])
    |> validate_required([:title, :artist, :summary, :year, :genre])
  end
end
