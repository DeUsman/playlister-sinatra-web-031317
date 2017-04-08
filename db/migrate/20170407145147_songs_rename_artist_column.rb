class SongsRenameArtistColumn < ActiveRecord::Migration
  def change
  	rename_column :songs, :artis_id, :artist_id
  end
end
