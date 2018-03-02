class Reservation < ApplicationRecord
  belongs_to :car
  
    validate :valid_change_the_date

 def valid_change_the_date
  if (((end_time-start_time)/1.hour).round > 10 || ((end_time-start_time)/1.hour).round < 1)
   errors.add(:to, "reserve a car: slots allowed are only from 1 hour to 10 hours")
  elsif checkout_time < start_time - 15.minutes or checkout_time > end_time
    errors.add(:to, "reserve a car: Checkout time should be less than End time and at most 15 minutes before Start time.")
  end
 end

      validate :date_cannot_be_too_late

  def date_cannot_be_too_late
    if start_time > Date.today + 7.days
      errors.add(:end_time, "can't be in the past and you have to pick a date only within the next 7 days ")

    end
end
  def update_reservations
    if status == "Checked Out" and end_time < DateTime.now
      update!(:status => "Returned")
      user = User.where(:email => email)
      user.update(:has_reservation => false)
      car = Car.find(car_id)
      puts "Updating car status!!!!"
      car.update!(:status => "Available")

    elsif status == "Reserved" and checkout_time < DateTime.now - 30.minutes
      puts checkout_time
      puts DateTime.now - 30.minutes
      update!(:status => "Cancelled")
      user = User.where(:email => email)
      user.update(:has_reservation => false)
      car = Car.find(car_id)
      puts "Updating car status!!!!"
      car.update!(:status => "Available")
    end
  end
end
