class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :logged_in_user, only:[:edit, :update, :destroy] 
                                        
  before_action :check_user, only:[:edit, :update]
  
  def show
    @microposts = @user.microposts.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end
  
  def new
    @user = User.new
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
    if @user.update_attributes(user_profile)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following_users.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.follower_users.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_profile
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age)
  end
  
  def check_user
    if current_user != @user
      redirect_to root_path
    end    
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
