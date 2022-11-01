FactoryBot.define do
  factory :order_delivery do
    postcode          { '123-4567' }
    prefecture_id     { 2 }
    city              { '青葉区' }
    address           { '1-1' }
    building          { 'ヤマダ' }
    tell_number       { 22222222222 } 
  end
end