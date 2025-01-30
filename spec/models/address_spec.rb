require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @purchase_form = FactoryBot.build(:purchase_form)
  end

  describe '購入情報の保存' do
    context '内容に問題がない場合' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@purchase_form).to be_valid
      end

      it '建物名が空でも保存できること' do
        @purchase_form.building_name = ''
        expect(@purchase_form).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が空では保存できないこと' do
        @purchase_form.postal_code = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号が「3桁ハイフン4桁」の半角文字列でないと保存できないこと' do
        @purchase_form.postal_code = '1234567'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      
      it '都道府県が「---」では保存できないこと' do
        @purchase_form.shipping_from_id = 1
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Shipping from must be selected')
      end
      
      it '電話番号が10桁未満では保存できないこと' do
        @purchase_form.phone_number = '090123456'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Phone number is invalid. Enter without hyphen(-)')
      end
      
      it '電話番号が12桁以上では保存できないこと' do
        @purchase_form.phone_number = '090123456789'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Phone number is invalid. Enter without hyphen(-)')
      end
      
      it '電話番号が半角数字でないと保存できないこと' do
        @purchase_form.phone_number = '０９０１２３４５６７８'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Phone number is invalid. Enter without hyphen(-)')
      end
      it 'トークンが空では保存できないこと' do
        @purchase_form.token = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが空では保存できないこと' do
        @purchase_form.user_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空では保存できないこと' do
        @purchase_form.item_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
