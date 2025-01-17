class Item < ApplicationRecord
  has_one_attached :product_image
  belongs_to :user

  validates :product_image, presence: true
  validates :product_name, presence: true
  validates :product_description, presence: true
  validates :category_id, presence: true, numericality: { other_than: 1 }
  validates :item_status_id, presence: true, numericality: { other_than: 1 }
  validates :shipping_cost_burden_id, presence: true, numericality: { other_than: 1 }
  validates :shipping_from_id, presence: true, numericality: { other_than: 1 }
  validates :shipping_day_id, presence: true, numericality: { other_than: 1 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :item_status
  belongs_to_active_hash :shipping_cost_burden
  belongs_to_active_hash :shipping_from
  belongs_to_active_hash :shipping_day
end