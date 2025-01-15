class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # Deviseのバリデーション（メールアドレス、パスワード）を利用
  validates :nickname, presence: true
  validates :password, presence: true, length: { minimum: 6 }, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/ }

  # パスワード確認の一致
  validates_confirmation_of :password

  # 名前のバリデーション
  validates :last_name, :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龯]+\z/ }

  validates :last_name_kana, :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/ }

   # 生年月日のバリデーション
  validates :birth_date, presence: true

end

