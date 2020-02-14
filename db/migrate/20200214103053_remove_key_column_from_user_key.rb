class RemoveKeyColumnFromUserKey < ActiveRecord::Migration[5.2]
  def up
    remove_column :user_keys, :key
  end

  def down
    add_column :user_keys, :key, :string, null: false,  limit: 500
  end
end
