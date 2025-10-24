defmodule AiDrudge.ArticlesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AiDrudge.Articles` context.
  """

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
        d_summary: "some d_summary",
        data_points: %{},
        description: "some description",
        host: "some host",
        name: "some name",
        r_summary: "some r_summary",
        support: "some support",
        title: "some title"
      })
      |> AiDrudge.Articles.create_article()

    article
  end
end
