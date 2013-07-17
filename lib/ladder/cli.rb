require 'thor'
require 'ladder'

module Ladder
	class CLI < Thor
		
		desc "clymb", "A current list of TheClymb's homepage product deals"
		def products
			say ClymbScraper.new.product_list.join("\n")
		end

		desc "search", "A refined search for current deals via a keyword"
		def search(keyword)
			say ClymbScraper.new.search(keyword).join("\n")	
		end

	end
end