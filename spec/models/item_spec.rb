require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '出品ができる場合' do
      it '全ての項目が正しく入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品ができない場合' do
      it '商品画像が空では出品できない' do
        @item.product_image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Product image can't be blank")
      end

      it '商品名が空では出品できない' do
        @item.product_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product name can't be blank")
      end

      it '商品の説明が空では出品できない' do
        @item.product_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product description can't be blank")
      end

      it 'カテゴリーが未選択（---）では出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end

      it '商品の状態が未選択（---）では出品できない' do
        @item.item_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item status must be other than 1")
      end

      it '配送料の負担が未選択（---）では出品できない' do
        @item.shipping_cost_burden_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping cost burden must be other than 1")
      end

      it '発送元の地域が未選択（---）では出品できない' do
        @item.shipping_from_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping from must be other than 1")
      end

      it '発送までの日数が未選択（---）では出品できない' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day must be other than 1")
      end

      it '価格が空では出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が¥300未満では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end

      it '価格が¥10,000,000以上では出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end

      it '価格が半角数値でないと出品できない' do
        @item.price = '３０００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
    end
  end
end
