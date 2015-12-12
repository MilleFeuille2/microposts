class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate!, only: [:edit, :update]
  
  def show
    @microposts = @user.microposts.order(created_at: :desc)
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
  end
  
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'プロフィールを編集しました'
    else
      render 'edit'
    end
  end
  
  def followings
    @title = "Followings"
    @user = User.find(params[:id])
    @users = @user.following_users
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.follower_users
    render 'show_follow'
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :region)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def authenticate!
    if @user != current_user
      redirect_to @user, notice: '不正なアクセス'
    end
  end
    
end
