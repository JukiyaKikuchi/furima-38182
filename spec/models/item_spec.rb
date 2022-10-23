require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品できるとき' do
      it '全ての情報が存在していれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品できないとき' do
      it '画像が無いと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が無いと出品できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it '商品名が40字より多いと出品できない' do
        @item.item_name = 'テスト' * 40
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name is too long (maximum is 40 characters)")
      end
      it '画像説明が無いと投稿できない' do
        @item.item_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item description can't be blank")
      end
      it '商品説明が1000字より多いと出品できない' do
        @item.item_description = '説明' * 1000
        @item.valid?
        expect(@item.errors.full_messages).to include("Item description is too long (maximum is 1000 characters)")
      end
      it 'カテゴリーが選ばれていないと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品の状態が選ばれていないと出品できない' do
        @item.item_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item status can't be blank")
      end
      it '配送料の負担が選ばれていないと出品できない' do
        @item.delivery_cost_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery cost can't be blank")
      end
      it '発送元が選ばれていないと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送までの日数が選ばれていないと出品できない' do
        @item.delivery_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery date can't be blank")
      end
      it '販売価格が空だと出品できない' do
        @item.item_price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item price can't be blank")
      end
      it '販売価格が300円未満だと出品できない' do
        @item.item_price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Item price must be greater than or equal to 300")
      end
      it '販売価格が9,999,999円より大きいと出品できない' do
        @item.item_price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Item price must be less than or equal to 9999999")
      end
      it '販売価格が文字だと出品できない' do
        @item.item_price = 'テスト'
        @item.valid?
        expect(@item.errors.full_messages).to include("Item price is not a number")
      end
      it 'ユーザーが紐づいていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end
