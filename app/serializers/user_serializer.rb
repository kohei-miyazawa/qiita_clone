class UserSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_meny :articles
end
