require './config/environment'
require 'rack-flash'
require 'sinatra/base'

class ApplicationController < Sinatra::Base

    configure do
      set :public_folder, 'public'
      set :views, 'app/views'
      enable :sessions
      set :session_secret, "dead_in_the_middle_of_little_italy"
      use Rack::Flash
    end

    get "/" do
      erb :welcome
    end


    helpers do
      def logged_in?
        !!current_user
      end

      def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
      end
    end

end
