class Api::V1::ArticlesController < ApplicationController
  def index
    articles = Article.all
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
    article = Article.new(
      title: arti_params[:title],
      body: arti_params[:body],
      author: arti_params[:author]
    )
    if article.save
      render json: article, status: 200
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
  def arti_params
    params.require(:article).permit([
      :title,
      :body,
      :author
    ])
  end
end
