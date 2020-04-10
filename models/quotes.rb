

class Quotes
	attr_accessor :quoteInventory

	def initialize()
		loadData
	end

	def loadData
		@quoteInventory= JSON.load File.open("./dataSources/quotes.json")
	end

	def random_quote(quantity=1)
		@quoteInventory.sample(quantity.to_i)
	end

	def find_by_author(authorUUID)
		@quoteInventory.select{|quote| quote["author_key"]==authorUUID}
	end

	def find(uuid)
		@quoteInventory.select {|quote| quote["uuid"]===uuid}[0]
	end


end