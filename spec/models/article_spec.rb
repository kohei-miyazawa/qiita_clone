require "rails_helper"

RSpec.describe Article, type: :model do
  describe "正常系" do
    context "body,titleが存在する場合" do
      let(:article) { build(:article) }
      it "記事が投稿される" do
        expect(article).to be_valid
      end
    end
  end

  describe "異常系" do
    context "titleが存在しない場合" do
      let(:article) { build(:article, title: nil) }
      it "エラーする(can't be blank)" do
        article.valid?
        expect(article.errors.messages[:title]).to include "can't be blank"
      end
    end
  end
end
