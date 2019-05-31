class MatchupsController < ApplicationController

    #INDEX
    get "/matchups" do
      if !logged_in?
        flash[:message] = "You Have to Login to Do That."
        redirect "/login"
      else
        @matchups = Matchup.all.order("created_at DESC")
        erb :"matchups/index"
      end
    end

    #NEW
    get "/matchups/new" do
      if !logged_in?
        flash[:message] = "You Have to Login to Do That."
        redirect "/login"
      else
        erb :"matchups/new"
      end
    end

    #CREATE
    post "/matchups" do
      if !logged_in?
        flash[:message] = "You Have to Login to Do That."
        redirect "/login"
      else
        if params.values == ""
          flash[:message] = "What Did You Do? Are You OK? Try Again."
          erb :"matchups/new"
        else
          @matchup = Matchup.create(
            opp_name: params[:opp_name],
            team: params[:team],
            opp_team: params[:opp_team],
            score: params[:score],
            opp_score: params[:opp_score],
            system: params[:system],
            description: params[:description],
            user_id: "#{current_user.id}"
          )
          flash[:message] = "Game On! New Matchup Posted."
          redirect "/matchups/#{@matchup.id}"
        end
      end
    end

    #SHOW
    get "/matchups/:id" do
        if !logged_in?
          flash[:message] = "You Have to Login to Do That."
          redirect "/login"
        else
          @matchup = Matchup.find_by_id(params[:id])
          erb :"matchups/show"
        end
    end

    #EDIT
    get "/matchups/:id/edit" do
      erb :"matchups/edit"
    end

    #UPDATE
    patch "/matchups/:id" do
      redirect "/matchups/:id"
    end

    #DELETE
    delete "/matchups/:id/delete" do
      redirect "/matchups"
    end
end
