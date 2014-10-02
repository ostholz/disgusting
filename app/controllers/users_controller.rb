class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:login, :logout]

  def login
    if request.post?
      username = params[:username]
      password = params[:password]
      user = User.find_by(username: username)
      auth_user = user.authenticate(password) unless user.nil?
      if auth_user
        session[:user_id] = auth_user.id
        redirect_to noises_path
      else
        flash.now[:error] = password + " failed"
      end
    end
  end

  def logout
    session[:user_id] = nil
    @current_user = nil
    render 'login'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
