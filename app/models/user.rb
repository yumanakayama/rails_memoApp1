class User < ApplicationRecord
  # リレーション設定。
  has_many :memos, class_name: "Memo", foreign_key: "user_id"

  #　バリデーション設定。
  validates :name, presence: true, length: {minimum: 2, maximum: 32}
  validates :email, presence: true, uniqueness: true #uniqueness: trueとすることでデータベースに登録されていない場合のみ許可。
  validates :password, presence: true, format: { with: /\A[a-zA-Z0-9]+\z/, message: "は英数字のみを含む必要があります" }
end
