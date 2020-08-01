class SessionsController < ApplicationController

    def index
        redirect_to root_path
    end

    def new
    end

    def create 
        user = User.find_by(email: params[:session][:email].downcase)
        if user  && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:success] = "Welcome to Moriarty's Guest Book!"
            redirect_to articles_path
        else
            flash.now[:danger] = "Sorry, there was something wrong with your login information"
            render 'new'
        end
    end 

    def destroy
        session[:user_id] = nil
        flash[:success] = "You have logged out. Thanks for visiting!"
        redirect_to root_path
    end
end
