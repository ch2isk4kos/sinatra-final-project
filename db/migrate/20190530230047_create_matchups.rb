class CreateMatchups < ActiveRecord::Migration
  def change
    create_table :matchups do |t|
      t.string :team
      t.integer :score
      t.string :opp_name
      t.string :opp_team
      t.integer :opp_score
      t.text :description
      t.string :system
      t.integer :user_id
      
      t.timestamps null: false
    end
  end
end
