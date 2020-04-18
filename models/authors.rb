class Authors
	attr_accessor :authorInventory

	def initialize()
		loadData
	end

	def loadData
		@authorInventory=JSON.load File.open("./dataSources/authors.json")
	end

	def random_author(quantity=1)
		@authorInventory.sample(quantity.to_i)
	end

	def inventory
		@authorInventory
	end

	def find(uuid)
		@authorInventory.select {|author| author["uuid"]===uuid}[0]
	end

	def find_all()
		@authorInventory  
	end

	def quotes(uuid) #extended to include text - orginally wanted to return just the uuid
		author=find(uuid)
		author["quotes"]=Quotes.new.find_by_author(uuid).collect{|item|  {"uuid" => item["uuid"],"text"=>item["text"]} }
		author
	end

	def randomQuote(uuid)
		quotes(uuid)["quotes"].sample(1)
	end

end