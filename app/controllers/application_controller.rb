class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def require_user
    return if logged_in?

    redirect_to login_path, notice: 'You must be logged in to perform that action'
  end
end
