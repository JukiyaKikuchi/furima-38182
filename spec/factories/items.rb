FactoryBot.define do
  factory :item do
    item_name {Faker::Name.name}
    item_description {Faker::Lorem.sentence}
    item_price {"300"}
    category_id {2}
    item_status_id {2}
    delivery_cost_id {2}
    prefecture_id {2}
    delivery_date_id {2}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
