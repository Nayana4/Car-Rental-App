class NotificationMailer < ApplicationMailer
  default from: 'notifications@carrentalapp.com'

  def send_email(user_email)
    # mail(to: cmanjun@ncsu.edu, subject: 'Welcome to My Awesome Site')
  end
end
