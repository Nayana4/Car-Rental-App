class Car < ApplicationRecord
  has_many :reservations , dependent: :destroy
 validates :license_no, presence: true, length: { is: 7 },
            format: { with: /[a-zA-Z0-9]+/ },
            uniqueness: true
  validates :manufacturer, presence: true
  validates :model, presence: true
  validates :hourly_rate, presence: true, numericality: { greater_than: 0 }
  validates :style, presence: true, inclusion: { in: %w(Coupe Sedan SUV),
                                                 message: "entered is not a valid style"}
  validates :location, presence: true
  validates :status, presence: true, inclusion: { in: %w(Checked\ Out Reserved Available) }
    
    
  def available?
    available = true
    for booking in reservations
      booking.update_reservations
      if booking.status == "Active"
        available = false
      end
    end
    available
  end
end
