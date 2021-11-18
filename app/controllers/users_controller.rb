class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :require_user, only: %i[edit update]
  before_action :require_same_user, only: %i[edit update destroy]

  def index
    @users = User.left_joins(:articles).select(
      :id, :username, :email, :created_at, Article.arel_table[:id].count.as('articles_count')
    ).group(:id).paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 4)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to articles_path,
        notice: "Welcome to the Alpha Blog #{@user.username}, sign up successfully"
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Your account information was successfully updated'
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil

    redirect_to articles_path, notice: 'Account and all associated articles successfully deleted'
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

  def require_same_user
    return unless current_user != @user

    redirect_to user_path(@user), alert: 'You can only edit your own account'
  end
end
