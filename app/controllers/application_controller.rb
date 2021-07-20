class ApplicationController < ActionController::Base
  include SessionsHelper

  rescue_from StandardError, :with => :render_standard_error

  def render_standard_error error
    flash[:danger] = error.message
    redirect_to root_path
  end

  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms a logged-in user is admin.
    def admin_user
      unless current_user.admin?
        flash[:danger] = "Please log as admin user."
        redirect_to login_url
      end
    end
end
