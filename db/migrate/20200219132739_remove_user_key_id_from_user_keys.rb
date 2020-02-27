class RemoveUserKeyIdFromUserKeys < ActiveRecord::Migration[5.2]
  def up
    remove_index :user_keys, :user_id
    remove_column :user_keys, :user_id
  end

  def down
    add_index :user_keys, :user_id
    add_index :user_keys, :user_id
  end
end