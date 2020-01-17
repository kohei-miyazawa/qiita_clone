require 'rails_helper'

RSpec.describe User, type: :model do
  describe "正常系" do
    context "ユーザ情報が条件通りに入力されている時" do
      let(:user){build(:user)}
      it "ユーザ登録できる" do
        expect(user).to be_valid
      end
    end
  end

  describe "異常系のテスト" do
    describe "nameについて" do
      context "nameが入力されていない時" do
        let(:user){build(:user, name: nil)}
        it "エラーする(can't be blank)" do
          user.valid?
          expect(user.errors.messages[:name]).to include "can't be blank"
        end
      end
    end

    describe "emailについて" do
      context "emailが入力されていない時" do
        let(:user){build(:user, email:nil)}
        it "エラーする(can't be blank)" do
          user.valid?
          expect(user.errors.messages[:email]).to include "can't be blank"
        end
      end

      context "同一のemailが存在する時" do
        before{create(:user, email:"miyazawa@example.com") }
        let(:user){build(:user, email:"miyazawa@example.com")}
        it "エラーする(has already been taken)" do
          user.valid?
          expect(user.errors.messages[:email]).to include "has already been taken"
        end
      end
    end

    describe "passwordについて" do
      context "passwordが入力されていない時" do
        let(:user){build(:user, password:nil)}
        it "エラーする(can't be blank)" do
          user.valid?
          expect(user.errors.messages[:password]).to include "can't be blank"
        end
      end

      context "passwordが5文字以下の時" do
        let(:user){build(:user, password:"abcde")}
        it "エラーする(is too short (minimum is 6 characters))" do
          user.valid?
          expect(user.errors.messages[:password]).to include "is too short (minimum is 6 characters)"
        end
      end

      context "passwordが129文字以上の場合" do
        let(:user){build(:user, password:"a"*129)}
        it "エラーする(is too long (maximum is 128 characters))" do
          user.valid?
          expect(user.errors.messages[:password]).to include "is too long (maximum is 128 characters)"
        end
      end
    end
  end
end
