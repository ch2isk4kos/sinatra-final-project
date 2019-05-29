class UsersController < ApplicationController

    #INDEX
    # get "/users" do
    #   erb :"/users/index.html"
    # end


    #NEW
    get "/users/new" do
      erb :"users/new"
    end

    #CREATE
    post "/users" do
      redirect "/users"
    end


    #SHOW
    get "/users/:id" do
      erb :"users/show"
    end


    #EDIT
    get "/users/:id/edit" do
      erb :"users/edit"
    end

    #UPDATE
    patch "/users/:id" do
      redirect "/users/:id"
    end


    #DESTROY
    delete "/users/:id/delete" do
      redirect "/users"
    end
end
