require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
   context '新規登録ができるとき' do
     it '全項目入力が存在すれば登録できること' do
       expect(@user).to be_valid
     end
   end

   context '新規登録できないとき' do
     it 'ニックネームが空だと登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
     end
     it 'Eメールが空では登録できない' do
       @user.email = ''
       @user.valid?
       expect(@user.errors.full_messages).to include("Email can't be blank")
     end
     it '重複したEメールが存在する場合は登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
     end
     it 'メールアドレスに@が含まれていない場合は登録できない' do
      @user.email = 'testmail'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
     end
     it 'passwordが空では登録できない' do
       @user.password = ''
       @user.valid?
       expect(@user.errors.full_messages).to include("Password can't be blank")
     end
     it 'passwordとpassword_confirmationが不一致では登録できない' do
       @user.password = '123456'
       @user.password_confirmation = '1234567'
       @user.valid?
       expect(@user.errors.full_messages).to include("Password is invalid")
     end
     it 'passwordが5文字以下では登録できない' do
      @user.password = '00000'
      @user.password_confirmation = '00000'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
     end
     it 'passwordoが129文字以上では登録できない' do
      @user.password = "g9"+Faker::Internet.password(min_length: 129)
      @user.password_confirmation = @user.password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
     end
     it 'passwordが半角数字のみでは登録できない' do
      @user.password = '000000'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
     end
     it 'passwordが半角英字のみでは登録できない' do
      @user.password = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid")
     end
     it 'passwordに全角文字を含むと登録できない' do
      @user.password = 'A1A1A1'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
     end
     it 'お名前フォームが空だと登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
     end
     it 'お名前フォームが半角だと登録できない' do
      @user.last_name = 'a'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name is invalid")
     end
     it 'お名前カナフォームが空だと登録できない' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
     end
     it 'お名前カナフォームがカタカナ表記意外だと登録できない' do
      @user.last_name_kana = 'てすと'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana is invalid")
     end
     it '生年月日が空だと登録できない' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
     end
   end
  end
end
