class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.string :email
      t.datetime :start_time
      t.datetime :end_time
      t.string :status
      t.references :license_no, index: true, foreign_key: true

      t.timestamps
    end
  end
end
