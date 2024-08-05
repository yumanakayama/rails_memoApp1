class AddColumnToMemos < ActiveRecord::Migration[7.0]
  def change
    add_column :memos, :user_id, :integer
  end
end
