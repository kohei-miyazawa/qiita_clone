FactoryBot.define do
  factory :article do
    title { Faker::Lorem.characters(number: Random.new.rand(1..100)) }
    body { Faker::Lorem.paragraph }
    user
  end
end
