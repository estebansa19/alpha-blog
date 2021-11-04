class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email].downcase)

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to user, notice: 'Logged in succesfully'
    else
      flash.now[:alert] = 'Email or password invalid'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
