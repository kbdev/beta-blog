class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
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
    @title = "Edit #{@user.username}"
  end
    
  def update
    if @user.update(user_params)
      flash[:success] = "Your account was updated successfully!"
      redirect_to articles_path
    else
      @title = "Edit #{@user.username}"
      render 'edit'
    end
  end
  
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
    @title = @user.username
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  def set_user
     @user = User.find(params[:id])
  end
  
  def require_same_user
    if current_user != @user
      flash[:danger] = "You can only edit your own account"
      redirect_to root_path
    end
  end
  
end