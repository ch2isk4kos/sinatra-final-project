class MatchupsController < ApplicationController

  # GET: /matchups
  get "/matchups" do
    erb :"/matchups/index.html"
  end

  # GET: /matchups/new
  get "/matchups/new" do
    erb :"/matchups/new.html"
  end

  # POST: /matchups
  post "/matchups" do
    redirect "/matchups"
  end

  # GET: /matchups/5
  get "/matchups/:id" do
    erb :"/matchups/show.html"
  end

  # GET: /matchups/5/edit
  get "/matchups/:id/edit" do
    erb :"/matchups/edit.html"
  end

  # PATCH: /matchups/5
  patch "/matchups/:id" do
    redirect "/matchups/:id"
  end

  # DELETE: /matchups/5/delete
  delete "/matchups/:id/delete" do
    redirect "/matchups"
  end
end
