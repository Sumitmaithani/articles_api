class Api::V1::ArticlesController < ApplicationController
MAX_PAGINATION_LIMIT = 100

  def index
    articles = Article.limit(limit).offset(params[:offset])
    render json: ArticlesRepresenter.new(articles).as_json
  end

  def show
    article = Article.find_by(id: params[:id])
    if article
      render json: article, status: 200
    else
      render json: {
        error: "Article not found"
      }
    end
  end

  def create
    author = Author.create!(author_params)
    article = Article.new(arti_params.merge(author_id: author.id))
    if article.save
      render json: ArticleRepresenter.new(article).as_json, status: 200
    else 
      render json: {
        error: "Error Creating..."
      }, status: 400
    end
  end

  def update
    article = Article.find_by(id: params[:id])
    if article
      article.update(title: params[:title], body: params[:body], author: params[:author])
      render json: "Article updated successfully"
    else
      render json: {
        error: "Article not found"
      }
    end
  end

  def destroy
    article = Article.find_by(id: params[:id])
    if article
      article.destroy
      render json: "Article deleted successfully", status: 200
    else
      render json: {
        error: "Article not found"
      }
    end
  end

  private
  def limit
    [
      params.fetch(:limit,MAX_PAGINATION_LIMIT).to_i,
      MAX_PAGINATION_LIMIT
    ].min
  end

  def author_params
    params.require(:author).permit([
      :first_name,
      :last_name,
      :age
    ])
  end

  def arti_params
    params.require(:article).permit([
      :title,
      :body
    ])
  end
end
