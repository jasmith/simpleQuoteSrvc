require 'rubygems'
require 'sinatra'

class ApplicationMain < Sinatra::Base
	get '/' do
		message = "welcome to simple quote service"
		message << "<h2> Do or Do Not...There is no Try</h2>"
		return message
	end

	get '/quote/:id' do
		
	end

	get '/quote/random' do 

	end
end


