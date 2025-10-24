defmodule AiDrudge.ArticlesTest do
  use AiDrudge.DataCase

  alias AiDrudge.Articles

  describe "articles" do
    alias AiDrudge.Articles.Article

    import AiDrudge.ArticlesFixtures

    @invalid_attrs %{
      name: nil,
      host: nil,
      description: nil,
      title: nil,
      r_summary: nil,
      d_summary: nil,
      data_points: nil,
      support: nil
    }

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Articles.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Articles.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      valid_attrs = %{
        name: "some name",
        host: "some host",
        description: "some description",
        title: "some title",
        r_summary: "some r_summary",
        d_summary: "some d_summary",
        data_points: %{},
        support: "some support"
      }

      assert {:ok, %Article{} = article} = Articles.create_article(valid_attrs)
      assert article.name == "some name"
      assert article.host == "some host"
      assert article.description == "some description"
      assert article.title == "some title"
      assert article.r_summary == "some r_summary"
      assert article.d_summary == "some d_summary"
      assert article.data_points == %{}
      assert article.support == "some support"
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Articles.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()

      update_attrs = %{
        name: "some updated name",
        host: "some updated host",
        description: "some updated description",
        title: "some updated title",
        r_summary: "some updated r_summary",
        d_summary: "some updated d_summary",
        data_points: %{},
        support: "some updated support"
      }

      assert {:ok, %Article{} = article} = Articles.update_article(article, update_attrs)
      assert article.name == "some updated name"
      assert article.host == "some updated host"
      assert article.description == "some updated description"
      assert article.title == "some updated title"
      assert article.r_summary == "some updated r_summary"
      assert article.d_summary == "some updated d_summary"
      assert article.data_points == %{}
      assert article.support == "some updated support"
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Articles.update_article(article, @invalid_attrs)
      assert article == Articles.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Articles.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Articles.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Articles.change_article(article)
    end
  end
end
