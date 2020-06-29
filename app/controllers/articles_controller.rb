class ArticlesController < ApplicationController

    before_action :set_article, only: [:edit, :update, :show, :destroy]
    def set_article
        @article = Article.find(params[:id])
    end

    def destroy
        @article.destroy
        flash[:success] = "Post was deleted"
        redirect_to articles_path
    end

    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end
    
    def create 
        @article = Article.new(article_params)
        @article.user = User.first
        if @article.save
            flash[:success] = "Thanks for signing our guest book!"
            redirect_to article_path(@article)
        else
            render 'new'
        end
        # @article.save
        # redirect_to article_path(@article)
    end

    def show
    end


    def edit
        @article = Article.find(params[:id])
    end

    def update
        if @article.update(article_params)
            flash[:success] = "Post was updated"
            redirect_to article_path(@article)
        else
            flash[:success] = "Post was not updated"
            render 'edit'
        end
    end

    private
        def article_params
            params.require(:article).permit(:title, :description)
        end

end
