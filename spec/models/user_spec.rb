require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー情報' do
    context '内容に問題ない場合' do
      it '全て正常' do
        expect(@user.valid?).to eq true
      end
    end
    context '内容に問題がある場合' do
      it 'ニックネームが必須であること' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが必須であること' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスは@を含む必要があること' do
        @user.email = 'test.co.jp'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが必須であること' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは6文字以上であること' do
        @user.password = '0000a' 
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードが半角英字のみの場合登録できない' do
        @user.password = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワードが半角数字のみの場合登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワードに半角英数字以外が含まれている場合登録できない' do
        @user.password = 'abc@123'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワードは確認用を含めて2回入力すること' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'ユーザー本名の名字が必須であること' do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'ユーザー本名の名前が必須であること' do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it '名字が全角（漢字・ひらがな・カタカナ）でない場合登録できない' do
        @user.last_name = 'kanji,hiragana,katakana'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end
      it '名前が全角（漢字・ひらがな・カタカナ）でない場合登録できない' do
        @user.first_name = 'kanji,hiragana,katakana'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
      it 'ユーザー本名のフリガナの名字が必須であること' do
        @user.last_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'ユーザー本名のフリガナの名前が必須であること' do
        @user.first_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it '名字のフリガナは全角（カタカナ）で入力させること' do
        @user.last_name_kana = 'kana'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end
      it '名前のフリガナは全角（カタカナ）で入力させること' do
        @user.first_name_kana = 'kana'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end
      it '生年月日が必須であること' do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
