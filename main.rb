require 'rubygems'
require 'sinatra'
require './models/quotes'
require './models/authors'

class ApplicationMain < Sinatra::Base
	get '/' do
		p "smurf"
		message = "welcome to simple quote service"
		message << "<h2> Do or Do Not...There is no Try</h2>"
		return message
	end

	get '/quote/random' do		
		return Quotes.new.random_quote
	end

	get '/quote/:id' do
		p "hi there #{params[:id]}"
	end

	get '/quotes/random' do
		p "quotes running"
		return Quotes.new.random_quote(params[:quantity].to_i)
	end

	get '/authors' do
		return Authors.new.inventory
	end


	
end

