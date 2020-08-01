class ArticlesController < ApplicationController

    before_action :set_article, only: [:edit, :update, :show, :destroy]
    before_action :logged_in_user, only: [:edit, :update, :delete]
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
        if logged_in?
            @article = Article.new
        else
            flash[:success] = "Please sign up to create a Guest Book entry. Thank you!"
            redirect_to signup_path
        end
    end
    
    def create 
        @article = Article.new(article_params)
        @article.user = current_user
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
            flash[:success] = "Thanks for signing the guestbook!"
            redirect_to article_path(@article)
        else
            flash[:success] = "Guestbook was not updated."
            render 'edit'
        end
    end

    private
        def article_params
            params.require(:article).permit(:title, :description)
        end

        def logged_in_user
            unless current_user == @article.user
              flash[:danger] = "You do not have authorization to edit this post" #if not logged in as the owner of the post
              redirect_to articles_path
            end
        end

end
