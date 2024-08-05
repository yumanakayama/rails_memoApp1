class Memo < ApplicationRecord
  # リレーション設定。
  belongs_to :user, class_name: "User", foreign_key: "user_id" #class_nameとはモデル名に当たる。どのモデルに対してなのかを指定する。

  #　バリデーション設定。
  validates :user_id, presence: true
  validates :title, presence: true, length: { minimum: 2, maximum: 32 } #presence trueで未入力を受け付けない。lengthで最低文字数と最大文字数を指定する。
  validates :description, presence: true, length: { minimum: 2, maximum: 140 } #presence trueで未入力を受け付けない。lengthで最低文字数と最大文字数を指定する。
end
