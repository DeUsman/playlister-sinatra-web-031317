require "pry"
require 'sinatra/base'
require 'rack-flash'

class SongsController < Sinatra::Base
	enable :sessions
	use Rack::Flash
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }
  
  get "/songs" do 
  	@songs = Song.all
  	erb :'songs/index'
  end


  get '/songs/new' do 
  	erb :'songs/new'
   
  end


  get "/songs/:slug" do 
  	@song = Song.find_by_slug(params[:slug])
	  erb :'songs/show'
  end


  post "/songs" do
  	artist = Artist.find_or_create_by(name: params[:'Artist Name'])
  	genre_id = params[:genres][0].to_i
	  song = Song.create(name: params[:Name], artist_id: artist.id)
 	  song.genres << Genre.find(genre_id)
 	  song.save
  	flash[:message] = "Successfully created song."
  	redirect to "/songs/#{song.slug}"
  end


  get '/songs/:slug/edit' do
  	@song = Song.find_by_slug(params[:slug])
    @genres = Genre.all
  	erb :'songs/edit'
  end


  patch '/songs/:slug' do
  	song = Song.find_by_slug(params[:slug])

    if (!params["Artist Name"].empty?)
      song.artist = Artist.find_or_create_by(name: params["Artist Name"])
    end

    song.genres.push(Genre.find(params[:genres][0].to_i))
    song.save

    flash[:message] = "Successfully updated song."
    redirect to "/songs/#{song.slug}"
  end 

end











