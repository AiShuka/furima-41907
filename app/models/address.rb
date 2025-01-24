class Address < ApplicationRecord
  belongs_to :purchase

  validates :postal_code, presence: true, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
  validates :shipping_from_id, presence: true, numericality: { other_than: 1 }
  validates :city, presence: true
  validates :street_address, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/ }
end
