class UsersController < ApplicationController
  before_action :show, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts
  end
 
  def new
    @user = User.new
    @users = User.all
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
     
  def edit
    if logged_in? && session[:user_id] == @user.id
    else
      redirect_to root_path, notice: 'ログインしてください'
    end
  end
  
  def update
    if logged_in? && session[:user_id] == @user.id
      if @user.update(user_params)
        redirect_to login_path, notice: 'プロフィールを編集しました'
      else
        render 'edit'
      end
    else
      redirect_to login_path, notice: 'ログインしてください'
    end
  end
  
  def followings
    @title ="Followings"
    @user = User.find(params[:id])
    @users = @user.following_users
    @microposts = @user.microposts
    if @users.any?
      render 'show_follow'
    else
      render 'show'
    end
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.follower_users
    @microposts = @user.microposts
    if @users.any?
      render 'show_follow'
    else
      render 'show'
    end
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :region)
  end

    
end
