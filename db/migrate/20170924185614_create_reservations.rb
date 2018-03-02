class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.string :email
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :checkout_time
      t.string :status
      t.string :license_no
      t.references :car, index: true, foreign_key: true

      t.timestamps
    end
  end
end
