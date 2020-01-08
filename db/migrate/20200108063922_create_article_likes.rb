class CreateArticleLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :article_likes do |t|
      t.refereces :user, foreign_key: true
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
