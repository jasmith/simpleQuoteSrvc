class Quotes
	attr_accessor :quoteInventory

	def initialize()
		loadData
	end

	def loadData
		@quoteInventory= JSON.load File.open("./dataSources/quotes.json")
	end


	def random_quote(quantity=1)
		@quoteInventory.sample(quantity.to_i).to_json
	end


end