class ApplicationController < ActionController::Base
  
  # Authentication with bicrypt-ruby, only registered users can  # access certain areas of the website

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end


private

  def authenticate
    unless logged_in?
      flash[:error] = "You must be logged in to access this section of the site"
      redirect_to login_url
    end
  end

end