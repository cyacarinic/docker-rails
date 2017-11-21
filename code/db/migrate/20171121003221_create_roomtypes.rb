class CreateRoomtypes < ActiveRecord::Migration[5.0]
  def change
    create_table :roomtypes do |t|
      t.string :description
      t.integer :beds
      t.integer :tvs
      t.integer :baths

      t.timestamps
    end
  end
end
