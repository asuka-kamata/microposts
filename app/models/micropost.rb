class Micropost < ActiveRecord::Base
  # userテーブルに関連付け
  belongs_to :user
  # user_idが存在するか
  validates :user_id, presence: true
  # contentが存在し、文字数は最大140
  validates :content, presence: true, length: { maximum: 140 }
end
