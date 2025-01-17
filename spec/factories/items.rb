FactoryBot.define do
  factory :item do
    product_name { 'テスト商品' }
    product_description { 'テスト商品の説明' }
    category_id { 2 }
    item_status_id { 2 }
    shipping_cost_burden_id { 2 }
    shipping_from_id { 2 }
    shipping_day_id { 2 }
    price { 1000 }

    after(:build) do |item|
      item.product_image.attach(io: File.open('public/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end