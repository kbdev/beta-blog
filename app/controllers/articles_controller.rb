class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  
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
end