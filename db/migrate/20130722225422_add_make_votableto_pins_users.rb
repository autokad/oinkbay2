class AddMakeVotabletoPinsUsers < ActiveRecord::Migration
   def change
  		add_column :pins, :up_votes, :integer, :null => false, :default => 0
		add_column :pins, :down_votes, :integer, :null => false, :default => 0
		add_column :users, :up_votes, :integer, :null => false, :default => 0
		add_column :users, :down_votes, :integer, :null => false, :default => 0
  end
end
