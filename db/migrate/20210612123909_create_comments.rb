class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :support_id
      t.text :body

      t.timestamps
    end
  end
end
