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
        @matchup = Matchup.new(
           opp_name: params[:opp_name],
           team: params[:team],
           opp_team: params[:opp_team],
           score: params[:score],
           opp_score: params[:opp_score],
           system: params[:system],
           description: params[:description],
           user_id: "#{current_user.id}"
         )

         if @matchup.save
           flash[:message] = "Game On! New Matchup Posted."
           redirect "/matchups/#{@matchup.id}"
         else
           flash[:message] = "What Did You Do? Are You OK? Try Again."
           erb :"matchups/new"
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
      if !logged_in?
        flash[:message] = "You Have to Login to Do That."
        redirect "/login"
      else
        @matchup = Matchup.find_by_id(params[:id])

        if current_user.id == @matchup.user_id
          erb :"matchups/edit"
        else
          flash[:message] = "Sorry, You Can't Do That Here!"
          erb :"matchups/show"
        end

      end
    end

    #UPDATE
    patch "/matchups/:id" do
      if !logged_in?
        flash[:message] = "You Have to Login to Do That."
        redirect "/login"
      else
        @matchup = Matchup.find_by_id(params[:id])

        if current_user.id == @matchup.user_id
          @matchup.update(
            opp_name: params[:opp_name],
            team: params[:team],
            opp_team: params[:opp_team],
            score: params[:score],
            opp_score: params[:opp_score],
            system: params[:system],
            description: params[:description]
          )
          redirect "/matchups/#{@matchup.id}"
        else
          flash[:message] = "I Don't Know What You Did, but Let's Try This Again."
          erb :"matchups/edit"
        end

      end
    end

    #DELETE
    delete "/matchups/:id/delete" do
      if !logged_in?
        flash[:message] = "You Have to Login to Do That."
        redirect "/login"
      else
        matchup = Matchup.find_by_id(params[:id])

        if current_user.id == matchup.user_id
          matchup.delete
          flash[:message] = "Next Time, Play For Keeps!"
          redirect "/users/#{current_user.id}"
        else
          flash[:message] = "You Can't Do That Here!"
          erb :"matchups/show"
        end

      end
    end

end
