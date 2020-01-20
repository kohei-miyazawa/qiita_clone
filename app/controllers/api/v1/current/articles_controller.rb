class Api::V1::Current::ArticlesController < Api::V1::ApiController
  before_action :authenticate_user!

  def index
    articles = current_user.articles.published
    render json: articles, each_serializer: ArticleSerializer
  end
end
