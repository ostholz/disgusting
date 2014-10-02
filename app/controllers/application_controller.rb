class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_current_user
  before_action :require_login

  def set_current_user
    unless session[:user_id].nil?
      @current_user = User.find(session[:user_id])
    end
  end

  def require_login
    unless @current_user
      redirect_to login_path
    end
  end

end
