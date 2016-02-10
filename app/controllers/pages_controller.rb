class PagesController < ApplicationController

    def home
      @title = "Home"
      redirect_to user_path(current_user) if logged_in?
    end
    
    def about
       @title = "About" 
    end

end