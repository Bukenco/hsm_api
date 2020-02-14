class AddNewColumnToUseKey < ActiveRecord::Migration[5.2]
  def up
    add_column :user_keys, :key_ciphertext, :text
  end

  def down
    remove_column :user_keys, :key_ciphertext
  end
end
