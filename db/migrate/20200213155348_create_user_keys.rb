class CreateUserKeys < ActiveRecord::Migration[5.2]
  def change
    create_table :user_keys do |t|
      t.integer  :user_id,  null: false,              index: true
      t.string   :key,      null: false,  limit: 500
    end
  end
end
