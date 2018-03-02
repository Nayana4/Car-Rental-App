class HomeController < ApplicationController
  def index
    if user_signed_in? and current_user.superadmin_role?
      redirect_to superadmins_path

    elsif  user_signed_in? and current_user.admin_role?
      redirect_to admins_path

    elsif user_signed_in? and current_user.customer_role?
      redirect_to cars_path
    else
      redirect_to new_user_session_path
    end
  end
end
