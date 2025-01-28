require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:purchase) { FactoryBot.build(:purchase) }

  describe '配送先住所のバリデーション' do
    context '住所情報が正しい場合' do
      it '郵便番号、都道府県、市区町村、番地、電話番号が正しい場合に有効であること' do
        address = purchase.build_address(
          postal_code: '123-4567',
          shipping_from_id: 2,
          city: '渋谷区',
          street_address: '1-1-1',
          phone_number: '09012345678'
        )
        expect(address).to be_valid
      end
    end

    context '住所情報が不正な場合' do
      it '郵便番号が空の場合無効であること' do
        address = purchase.build_address(postal_code: '')
        expect(address).to_not be_valid
        expect(address.errors[:postal_code]).to include("can't be blank")
      end

      it '郵便番号が不正な形式の場合無効であること' do
        address = purchase.build_address(postal_code: '1234567')
        expect(address).to_not be_valid
        expect(address.errors[:postal_code]).to include("is invalid")
      end

      it '都道府県が空の場合無効であること' do
        address = purchase.build_address(shipping_from_id: nil)
        expect(address).to_not be_valid
        expect(address.errors[:shipping_from_id]).to include("is not a number")
      end

      it '市区町村が空の場合無効であること' do
        address = purchase.build_address(city: '')
        expect(address).to_not be_valid
        expect(address.errors[:city]).to include("can't be blank")
      end

      it '番地が空の場合無効であること' do
        address = purchase.build_address(street_address: '')
        expect(address).to_not be_valid
        expect(address.errors[:street_address]).to include("can't be blank")
      end

      it '電話番号が空の場合無効であること' do
        address = purchase.build_address(phone_number: '')
        expect(address).to_not be_valid
        expect(address.errors[:phone_number]).to include("can't be blank")
      end

      it '電話番号が不正な形式の場合無効であること' do
        address = purchase.build_address(phone_number: '090-1234-5678')
        expect(address).to_not be_valid
        expect(address.errors[:phone_number]).to include("is invalid")
      end

      it '電話番号が10桁未満の場合無効であること' do
        address = purchase.build_address(phone_number: '090123456')
        expect(address).to_not be_valid
        expect(address.errors[:phone_number]).to include("is invalid")
      end

      it '電話番号が11桁を超える場合無効であること' do
        address = purchase.build_address(phone_number: '090123456789')
        expect(address).to_not be_valid
        expect(address.errors[:phone_number]).to include("is invalid")
      end
    end
  end
end
