require 'rubygems'
require 'sinatra'
require './models/quotes'
require './models/authors'


class ApplicationMain < Sinatra::Base


	helpers do

		def authorized?(params)
			#p "------#{params[:api_key]}"
			authorized = params[:api_key]=='123456' ? true : false
			#p "------------------------#{authorized}"
		end

		def sayHello()
			p "hello there"
		end
		def setQuantity(quantity)
			quantity.nil? ? quantity=1 : quantity.to_i
		end
	end
	before do
		@quotes=Quotes.new
		@authors=Authors.new
		authorized?(params)
	end

	get '/' do
		message = "Simple Quote Service"
		return message
	end

	post '/user/register' do

	end


	get '/quote/:uuid' do
		@quotes.find(params[:uuid]).to_json
	end


	get '/authors' do  #get all authors
		@authors.find_all.to_json
	end

	get '/author/:uuid' do #get singleton
		@authors.find(params[:uuid]).to_json
	end

	get '/author/:uuid/quotes' do #get all quotes for an author
		#does this suggest a "random" peer class to quote and author
		@authors.quotes(params[:uuid]).to_json
	end

	get '/author/:uuid/quote' do 
		@authors.randomQuote(params[:uuid]).to_json
	end


	get '/random/quote' do  #conceptually same as /author/random/quote/random
		return @quotes.random_quote(setQuantity(params[:quantity])).to_json
	end

	get '/random/author' do
		return @authors.random_author(setQuantity(params[:quantity])).to_json
	end


end

=begin
NOTES:
- .to_json is handled here as consumer may request different format types - translation should be the concern of the service itself via helper
	
=end