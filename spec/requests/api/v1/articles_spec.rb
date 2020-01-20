require "rails_helper"

RSpec.describe "Api::V1::Articles", type: :request do
  describe "GET /api/v1/articles" do
    subject { get(api_v1_articles_path) }

    before do
      create_list(:article, 3, :published_status)
    end

    it "公開記事の一覧が取得できる" do
      subject
      res = JSON.parse(response.body)
      expect(res.length).to eq 3
      expect(res[0].keys).to eq ["id", "title", "body", "updated_at", "status", "user"]
      expect(res[0]["user"].keys).to eq ["id", "name"]
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /api/v1/articles/:id" do
    subject { get(api_v1_article_path(article_id)) }

    context "指定したidの記事が存在する場合（公開記事）" do
      let(:article) { create(:article, :published_status) }
      let(:article_id) { article.id }

      it "指定した記事が取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(res["id"]).to eq article.id
        expect(res["title"]).to eq article.title
        expect(res["body"]).to eq article.body
        expect(res["updated_at"]).to be_present
        expect(res["status"]).to eq "published"
        expect(response).to have_http_status(:ok)
      end
    end

    context "指定したidの記事が存在しない場合" do
      let(:article_id) { 10000 }
      it "記事が取得できない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context "記事が下書きの場合" do
      let(:article) { create(:article) }
      let(:article_id) { article.id }
      it "記事が取得できない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "POST /api/v1/articles" do
    subject { post(api_v1_articles_path, params: params, headers: headers) }
    let(:current_user) { create(:user) }
    let(:headers) { current_user.create_new_auth_token }

    context "statusをpublishedにして投稿した場合" do
      let(:params) { { article: attributes_for(:article, :published_status) } }

      it "公開記事のレコードが作成できる" do
        expect { subject }.to change { current_user.articles.count }.by(1)
        res = JSON.parse(response.body)
        expect(res["title"]).to eq params[:article][:title]
        expect(res["body"]).to eq params[:article][:body]
        expect(res["status"]).to eq "published"
        expect(response).to have_http_status(:ok)
      end
    end

    context "statusをdraftで投稿した場合" do
      let(:params) { { article: attributes_for(:article) } }

      it "下書き設定の記事が作成できる" do
        expect { subject }.to change { Article.count }.by(1)
        res = JSON.parse(response.body)
        expect(res["status"]).to eq "draft"
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "PATCH /api/v1/articles/:id" do
    subject { patch(api_v1_article_path(article.id), params: params, headers: headers) }

    let(:params) { { article: { body: Faker::Lorem.paragraph, created_at: Time.current } } }
    let(:current_user) { create(:user) }
    let(:headers) { current_user.create_new_auth_token }

    context "自分の記事を更新するとき" do
      let(:article) { create(:article, user: current_user) }

      it "記事の更新ができる" do
        expect { subject }.to change { article.reload.body }.from(article.body).to(params[:article][:body]) &
                              not_change { Article.find(article.id).title } &
                              not_change { Article.find(article.id).created_at }
        expect(response).to have_http_status(:ok)
      end
    end

    context "他のuserの記事を更新しようとするとき" do
      let(:other_user) { create(:user) }
      let(:article) { create(:article, user: other_user) }

      it "更新できない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "DELETE /api/v1/articles/:id" do
    subject { delete(api_v1_article_path(article.id), headers: headers) }

    let!(:article) { create(:article, user: current_user) }
    let(:current_user) { create(:user) }
    let(:headers) { current_user.create_new_auth_token }

    context "自分の記事を削除するとき" do
      it "記事を削除できる" do
        expect { subject }.to change { Article.count }.by(-1)
        expect(response).to have_http_status(:ok)
      end
    end

    context "他のuserの記事を削除するとき" do
      let!(:article) { create(:article, user: other_user) }
      let(:other_user) { create(:user) }

      it "削除できない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
