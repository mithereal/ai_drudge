defmodule AiDrudge.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :host, :string
      add :name, :string
      add :title, :string
      add :description, :string
      add :republican, :string
      add :democrat, :string
      add :data_points, :map
      add :support, :string

      timestamps(type: :utc_datetime)
    end
  end
end
