class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @title = "All Articles"
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @title = "New Article"
    @article = Article.new
  end
  
  def edit
    @title = "Edit #{@article.title}"
  end
  
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      @title = 'New Article'
      render 'new'
    end
  end
  
  def update
   
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated!"
      redirect_to article_path(@article)
    else
      @title = "Edit #{@article.title}"
      render 'edit'
    end
  end
    
  def show
    @title = "#{@article.title}"
  end
  
  def destroy
    @article.destroy
    flash[:danger] = "Article was successfully deleted"
    redirect_to articles_path
  end
  
  private
  def set_article
    @article = Article.find(params[:id])
  end
  def article_params
      params.require(:article).permit(:title, :description)
  end
  
  def require_same_user
    if current_user != @article.user
      flash[:danger] = "You can only do this to your own owrticle"
      redirect_to root_path
    end
  end
end