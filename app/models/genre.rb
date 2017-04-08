class Genre < ActiveRecord::Base
	has_many :song_genres
	has_many :songs, through: :song_genres
	has_many :artists, through: :songs

	def slug
  	self.name.downcase.gsub(" ", "-")
	end

	def self.find_by_slug(slug)
		genre = slug.split("-").collect do |word|
			word.capitalize
		end.join(" ")
		Genre.find_by(name: Genre.all.find do |genre1| genre1.name.downcase == genre.downcase end.name)
	end

end