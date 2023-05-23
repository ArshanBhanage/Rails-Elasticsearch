class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :price
      t.string :description
      t.string :author
      t.integer :year
      t.integer :ratings

      t.timestamps
    end
  end
end
