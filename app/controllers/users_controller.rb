class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def new
    @title = "Signup"
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the beta blog, #{@user.username}!"
      redirect_to user_path(@user)
    else
      @title = "Signup"
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    @title = "Edit #{@user.username}"
  end
    
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully!"
      redirect_to articles_path
    else
      @title = "Edit #{@user.username}"
      render 'edit'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.username
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  
end