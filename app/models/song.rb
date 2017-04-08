class Song < ActiveRecord::Base
	belongs_to :artist
	has_many :song_genres
	has_many :genres, through: :song_genres


	def slug
  	self.name.downcase.gsub(" ", "-")
	end

	def self.find_by_slug(slug)

		song = slug.split("-").collect do |word|
			word.capitalize
		end.join(" ")
		Song.find_by(name: Song.all.find do |song1| song1.name.downcase == song.downcase end.name)
	end



end