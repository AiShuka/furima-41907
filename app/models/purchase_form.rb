class PurchaseForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :shipping_from_id, :city, :street_address, :building_name, :phone_number, :token

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :shipping_from_id, numericality: { other_than: 1, message: 'must be selected' }
    validates :city
    validates :street_address
    validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Enter without hyphen(-)' }
    validates :token
  end

  def save
    purchase = Purchase.create(user_id:, item_id:)
    Address.create(
      postal_code:,
      shipping_from_id:,
      city:,
      street_address:,
      building_name:,
      phone_number:,
      purchase_id: purchase.id
    )
  end
end