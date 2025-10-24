defmodule AiDrudge.Articles.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :host, :string
    field :name, :string
    field :title, :string
    field :description, :string
    field :republican, :string
    field :democrat, :string
    field :data_points, :map
    field :support, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [
      :host,
      :name,
      :title,
      :description,
      :r_summary,
      :d_summary,
      :data_points,
      :support
    ])
    |> validate_required([:host, :name, :title, :description, :r_summary, :d_summary, :support])
  end
end
