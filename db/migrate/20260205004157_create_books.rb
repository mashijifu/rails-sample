class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.integer :number
      t.string :title
      t.text :description
      t.integer :genre
      t.float :price

      t.timestamps
    end
  end
end
