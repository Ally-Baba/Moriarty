class ApplicationController < ActionController::Base
    rescue_from CanCan::AccessDenied do |exception|
        redirect_to main_app.root_path, :alert => exception.message
    end

    helper_method :current_user, :logged_in?


    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
        !!current_user
    end

    def require_user
        if !logged_in?
            flash[:danger] = "You must be logged in to perform that action."
            redirect_to root_path
        end
    end
end
