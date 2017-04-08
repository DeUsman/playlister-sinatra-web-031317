require 'pry'

class Artist < ActiveRecord::Base
	has_many :songs
	has_many :genres, through: :songs


	def slug
  	self.name.downcase.gsub(" ", "-")
	end

	def self.find_by_slug(slug)
		name = slug.split("-").collect do |name|
			name.capitalize
		end.join(" ")
		Artist.find_by(name: Artist.all.find do |artist1| artist1.name.downcase == name.downcase end.name)
	end

end