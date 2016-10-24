class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      # userモデルに関連付けし、user_idにindexを作成、
      # userテーブルのidにのみuser_idに入るよう外部キー制約する
      t.references :user, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
      #複合インデックス、投稿を指定ユーザーで絞り込んだ後、作成時間で検索する
      t.index [:user_id, :created_at]
    end
  end
end
