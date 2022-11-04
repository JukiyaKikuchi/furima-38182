require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_delivery = FactoryBot.build(:order_delivery, user_id: user.id, item_id: item.id)
    end

    context '内容に問題がない場合' do
      it '全ての値が入力されていれば保存できる' do
        expect(@order_delivery).to be_valid
      end
      it '建物名が空でも保存できる' do
        @order_delivery.building = ''
        expect(@order_delivery).to be_valid
      end
    end

    context '内容に問題がある' do
      it '郵便番号が空では保存できない' do
        @order_delivery.postcode = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Postcode can't be blank")
      end
      it '郵便番号に半角のハイフンが含まれないと保存できない' do
        @order_delivery.postcode = '1234567'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Postcode is invalid. Include hyphen(-)")
      end
      it '都道府県が空では保存できない' do
        @order_delivery.prefecture_id = 1
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空では保存できない' do
        @order_delivery.city = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("City can't be blank")
      end
      it '電話番号が空では保存できない' do
        @order_delivery.tell_number = ''
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Tell number can't be blank")
      end
      it '電話番号が10桁未満では保存できない' do
        @order_delivery.tell_number = '123456789'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Tell number is invalid")
      end
      it '電話番号が12桁以上では保存できない' do
        @order_delivery.tell_number = '123456789123'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Tell number is too long (maximum is 11 characters)")
      end
      it '電話番号に半角数値以外が含まれていては保存できない' do
        @order_delivery.tell_number = '123-4567-1234'
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Tell number is invalid")
      end
      it 'userが紐付いていないと保存できない' do
        @order_delivery.user_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できない' do
        @order_delivery.item_id = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では登録できない' do
        @order_delivery.token = nil
        @order_delivery.valid?
        expect(@order_delivery.errors.full_messages).to include("Token can't be blank")
      end  
    end
  end
end