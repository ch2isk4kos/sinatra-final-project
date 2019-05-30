class Matchup < ActiveRecord::Base
    validates :team, presence: true
    validates :score, presence: true
    validates :opp_name, presence: true
    validates :opp_team, presence: true
    validates :opp_score, presence: true
    validates :description, presence: true
    validates :system, presence: true

    belongs_to :user
end
