FactoryBot.define do
  factory :order do
    postal_code    {'123-4567'}
    prefecture_id  {'2'}
    city_name      {'横浜市'}
    block_name     {'1-2-3'}
    building_name  {'ビル名'}
    phone_number   {'09012345678'}
    association :user        
    association :item       
  end
end