class UsersController < ApplicationController

    #INDEX
    # get "/users" do
    #   @users = User.all.order("created_at DESC")
    #   erb :"/users/index"
    # end

    #NEW
    get "/signup" do
      erb :"users/new"
    end

    #CREATE
    post "/signup" do
      user = User.new(username: params[:username], email: params[:email], password: params[:password])

      if !user.save
        flash[:message] = "What Did You Do? Is Everything OK? Let's Try Again."
        erb :'users/new'
      else
        flash[:message] = "You Have Successfully Signed Up"
        session[:user_id] = user.id
        redirect "/login"
      end
    end

    #LOGIN
    get '/login' do
      erb :"users/login"
    end

    post "/login" do
      user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          flash[:message] = "Welcome Back #{user.username}"
          redirect '/'
        else
          flash[:message] = "I'm sorry, we haven't met..."
          erb :"users/new"
        end
    end

    #LOGOUT
    get '/logout' do
      if logged_in?
        session.destroy
        flash[:message] = "You've Signed Out"
        redirect '/'
      end
    end

    #SHOW
    get "/users/:id" do
      @user = User.find_by_id(params[:id])
      erb :"users/show"
    end

    #EDIT
    get "/users/:id/edit" do
      @user = User.find_by_id(params[:id])
      erb :"users/edit"
    end

    #UPDATE
    patch "/users/:id" do
      @user = User.find_by_id(params[:id])
      @user.username = params[:username]
      @user.email = params[:email]
      @user.password = params[:password]
      @user.save!
      flash[:message] = "You've Updated Your Profile"
      redirect "/users/#{@user.id}"
    end

    #DESTROY
    delete "/users/:id/delete" do
      @user = User.find_by_id(params[:id])
      @user.delete
      session.clear
      flash[:message] = "That's Fucked Up! I Didn't Want You Here Anyway!"
      redirect "/"
    end
end
