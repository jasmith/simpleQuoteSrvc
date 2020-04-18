require_relative '../main'
require 'rack/test'
require './models/authors'
require './models/users'

describe 'ApplicationMain' do
	include Rack::Test::Methods
	
	quote_json=[{"text"=>"string","author"=>"string","uuid"=>"string","author_key"=>"string"}]
	author_json=[{"uuid"=>"string","firstName"=> "string","lastName"=>"string","author"=>"string"}]
	 def app
	 	#Sinatra::Application
	 	ApplicationMain
	 end

	 def getResponseBodyAsHash(url)
	 	get url
	 	JSON.parse(last_response.body)
	 end


	context " random service calls" do 
	 	it "GET /random/quote returns a status 200 OK 'route exists' " do
	 		get "/random/quote"
	 		expect(last_response.status).to eq 200 
	 	end

	 	it "GET /random/quote allows users to fetch a random quote & returns a single quote object" do
	 		get "/random/quote"
	 		expect(JSON.parse(last_response.body)[0].keys).to contain_exactly(*quote_json[0].keys)
	 	end

	 	it "GET /random/quote?quantity=n allows users to fetch n random quotes & returns n quote objects" do
	 		#tests for 0 and >0
	 		response = get "/random/quote?quantity=5"
	 		expect(JSON.parse(response.body).length).to eq(5)
	 	end

	 	it "GET /random/author returns a status 200 OK 'route exists' " do
	 		get "/random/author"
	 		expect(last_response.status).to eq 200 
	 	end

	 	it "GET /random/author allows users to fetch a random author & returns a single author" do
	 		get "/random/author"
	 		expect(JSON.parse(last_response.body)[0].keys).to contain_exactly(*author_json[0].keys)
	 	end

	 	it "GET /random/author?quantity=n allows users to fetch n random authors & returns n author objects" do
	 		#tests for 0 and >0
	 		response = get "/random/author?quantity=5"
	 		expect(JSON.parse(response.body).length).to eq(5)
	 	end

	end

	context "author service calls" do 
		let(:author) { Authors.new }
		let(:random_author){getResponseBodyAsHash("/random/author")[0]}

		it "GET /authors allows users to fetch all available authors & returns a list of Author objects" do 
			author_inventory=getResponseBodyAsHash("/authors")
			expect(author_inventory.length).to eq(author.authorInventory.length)
		end

		it "GET /author/:id allows users to lookup a specific author" do
			target_author=getResponseBodyAsHash("/author/#{random_author['uuid']}")
			expect(target_author['uuid']).to eq(random_author['uuid'])
		end

		it "GET /author/:uuid/quotes allows users to fetch all quotes for the selected Author " do
			target_author_quotes=getResponseBodyAsHash("/author/#{random_author['uuid']}/quotes")
			expect(target_author_quotes.length).to eq(author.quotes(random_author['uuid']).length)
		end

		it "GET /author/:uuid/quote allows users to get a randomly selected quote from a specific author" do
			target_author_quote=getResponseBodyAsHash("/author/#{random_author['uuid']}/quote")
			expect(author.quotes(random_author['uuid'])['quotes']).to include(*target_author_quote)
		end

		it "GET /author/:uuid/quote?quantity=n allows users to get n randomly selected quotes from a specific author " do
			target_author_quotes=getResponseBodyAsHash("/author/#{random_author['uuid']}/quote")
			expect(author.quotes(random_author['uuid'])['quotes']).to include(*target_author_quotes)
		end

	end


	context "quote api calls" do

		#let(:random_quote)

		it "GET /quote/:uuid allows users to fetch a specific quote" do 
			random_quote=getResponseBodyAsHash("/random/quote")
			specific_quote=getResponseBodyAsHash("/quote/#{random_quote[0]["uuid"]}")
			expect(specific_quote["uuid"]).to eq(random_quote[0]["uuid"]) #same uuid's 
			expect(specific_quote).to eq(random_quote[0]) #are the quote objects the same
		end

	end


	context "user api calls" do 

		it "allows users new to register" do
			user=Users.new
		end

		it "prevents users from register under same credentials twice" do 
			
		end

		it "prevents registration under same email & username" do
			
		end

		it "emails api key to newly registered users" do 

		end

		it "allows registered users to login into the system user their api key" do
			
		end

		it "allows users to reissue new api key" do
			
		end

		it "allows users to suspend their account" do 

		end

		it "allows users to cancel account by cancelling their api key" do
			
		end

		it "sets cancelled user to an inactive status" do
			
		end

	end
	
end

=begin

put '/users', {my_user: 'blah'} when wrong param is passed expect 422

	Im interested in the splat below - found a good article
	 #expect(JSON.parse(response.body)[0].keys).to contain_exactly(*quote[0].transform_keys! {|k| k.to_s })
	 #*quote[0].transform_keys! {|k| k.to_s } # transforms symbol hash keys to string


=end