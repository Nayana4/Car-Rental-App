class CreateCars < ActiveRecord::Migration[5.1]

  def change
    create_table :cars do |t|
      t.string :model
      t.string :license_no
      t.string :style
      t.string :location
      t.string :manufacturer
      t.string :status
      t.float :hourly_rate

      t.timestamps
    end
  end
end
