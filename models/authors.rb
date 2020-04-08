class Authors
	attr_accessor :authorInventory

	def initialize()
		loadData
	end

	def loadData
		@authorInventory= JSON.load File.open("./dataSources/authors.json")
	end


	def random_author(quantity=1)
		@authorInventory.sample(quantity.to_i).to_json
	end

	def inventory
		@authorInventory.to_json  
	end

end