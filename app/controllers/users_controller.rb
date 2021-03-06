class UsersController < ApplicationController

    #INDEX
    # get "/users" do
    #   @users = User.all.order("created_at DESC")
    #   erb :"/users/index"
    # end

    #NEW
    get "/signup" do
      if logged_in?
        flash[:message] = "You're already apart of the team #{current_user.username}!"
        redirect "/matchups"
      else
        erb :"users/new", :layout => :"users/new"
      end
    end

    #CREATE
    post "/signup" do
      user = User.new(username: params[:username], email: params[:email], password: params[:password])

      if !user.save
        flash[:message] = "What did you do? Are you OK? Let's try this again."
        redirect "/signup"
      else
        flash[:message] = "Welcome to the Team #{user.username}! Sign In."
        session[:user_id] = user.id
        erb :"users/login", :layout => :"users/login"
      end
    end

    #LOGIN
    get '/login' do
      if logged_in?
        flash[:message] = "You're already logged in #{current_user.username}."
        redirect "/"
      else
        erb :"users/login", :layout => :"users/login"
      end
    end

    post "/login" do
      user = User.find_by(email: params[:email])

      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:message] = "Welcome Back #{user.username}"
        redirect "/matchups"
      else
        flash[:message] = "I'm sorry, we haven't met yet..."
        redirect "/signup"
      end
    end

    #LOGOUT
    get '/logout' do
      if logged_in?
        session.destroy
        flash[:message] = "We'll link up later bro"
        redirect '/'
      end
    end

    #SHOW
    get "/users/:id" do
      if logged_in?
        @user = User.find_by_id(params[:id])
        erb :"users/show"
      else
        flash[:message] = "You have to sign in to do that."
        redirect "/login"
      end
    end

    #EDIT
    get "/users/:id/edit" do
      if logged_in?
        @user = User.find_by_id(params[:id])

        if current_user == @user
          erb :"users/edit"
        else
          flash[:message] = "Sorry, You can't do that here!"
          erb :"users/show"
        end

      else
        redirect "/login"
      end
    end

    #UPDATE
    patch "/users/:id" do
      @user = User.find_by_id(params[:id])
      @user.username = params[:username]
      @user.email = params[:email]
      @user.password = params[:password]

      if @user.save
        flash[:message] = "Profile Updated"
        redirect "/users/#{@user.id}"
      else
        flash[:message] = "You either did or didn't do something. Try again."
        erb :"users/edit"
      end
    end

    #DESTROY
    delete "/users/:id/delete" do
       @user = User.find_by_id(params[:id])

       if logged_in?
         @user.delete
         session.clear
         flash[:message] = "Step your game up!"
         redirect "/"
       else
         flash[:message] = "I have no idea what just happened."
         erb :"users/show"
       end
    end

end
