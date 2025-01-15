class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # Deviseのバリデーション（メールアドレス、パスワード）を利用
  validates :nickname, presence: true
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/ }

  # 名前のバリデーション
  validates :last_name, :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }

  validates :last_name_kana, :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/ }

   # 生年月日のバリデーション
  validates :birth_date, presence: true

end

