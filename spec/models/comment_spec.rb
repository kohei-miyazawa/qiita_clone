require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "正常系" do
    context "コメントが入力されている時" do
      let(:comment) { build(:comment) }
      it "コメントが投稿できる" do
        expect(comment).to be_valid
      end
    end
  end

  describe "異常系" do
    context "コメントが空のとき" do
      let(:comment) { build(:comment, body: nil) }
      it "投稿できない(can't be blank)" do
        comment.valid?
        expect(comment.errors.messages[:body]).to include "can't be blank"
      end
    end
  end
end
