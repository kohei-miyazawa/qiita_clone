class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }

  enum status: { draft: "draft", published: "published" }

  has_many :comments, dependent: :destroy
  has_many :article_likes, dependent: :destroy
  belongs_to :user
end
