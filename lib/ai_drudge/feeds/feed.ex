defmodule AiDrudge.Feeds.Feed do
  use Ecto.Schema
  import Ecto.Changeset

  schema "feeds" do
    field :host, :string
    field :active, :boolean

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(feed, attrs) do
    feed
    |> cast(attrs, [:host, :active])
    |> validate_required([:host])
  end
end
