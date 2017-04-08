class CreateSongs < ActiveRecord::Migration
  def change
  	create_table :songs do |t|
  		t.string :name
  		t.integer :artis_id
  	end
  end
end
