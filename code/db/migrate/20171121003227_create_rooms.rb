class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.references :roomtype, foreign_key: true
      t.string :correlative
      t.boolean :available
      t.integer :bedsExtra
      t.integer :tvsExtra
      t.integer :bathsExtra

      t.timestamps
    end
  end
end
