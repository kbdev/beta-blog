class SessionsController < ApplicationController
  
  def new
    @title = "Login"
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      @title = "Login"
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user)
    else
      @title = "Login"
      flash.now[:danger] = "There was something wrong with your login information"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
  
end