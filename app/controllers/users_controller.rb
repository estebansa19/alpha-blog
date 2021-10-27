class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @articles = @user.articles
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to articles_path,
        notice: "Welcome to the Alpha Blog #{@user.username}, sign up successfully"
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to articles_path, notice: 'Your account information was successfully updated'
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to articles_path, alert: 'User not found'
  end
end
