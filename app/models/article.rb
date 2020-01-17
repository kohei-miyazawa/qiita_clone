class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }

  has_many :comments, dependent: :destroy
  has_many :article_likes, dependent: :destroy
  belongs_to :user
end
