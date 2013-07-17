require "ladder/version"

module Ladder

require 'yaml/store'
require 'nokogiri'
require 'open-uri'

	class ClymbScraper
		attr_accessor :doc

		URL = "https://www.theclymb.com/preview?login=true"

		ClymbProduct = Struct.new :name, :expiration

		def initialize
			@doc = Nokogiri::HTML(open(URL))
		end

		def clean_product(product)
			product.gsub("Login to shop", "")
						 .gsub("Learn More", "")
						 .gsub("Win an Epic Adventure!", "")
						 .gsub("Outdoor Essentials at Clymb Prices", "")
						 .gsub("Get $35 for Every Friend You Invite", "")
		end
		
		def scrape
			@scrape ||= doc.at_css("#home_grid ul").text.split(";")
		end

		def clymb_items 
			list = scrape.map do |product| 
				cleaned = clean_product(product)
				ready_items = cleaned[0..-55].split("ends in")
				ClymbProduct.new(*ready_items)
			end
		end

		def product_list
			clymb_items.map do |product|
				next unless product and product.name
				"#{product.name.to_s.ljust(60, ".")} #{product.expiration}" 
			end
		end

		def search(keyword)
			results = []
			clymb_items.each do |product|
				# split_key = keyword.split('')
				next unless product and product.name
				results << product if product.name.downcase.include?(keyword.downcase)
			end
			results.map do |search_product|
				next unless search_product and search_product.name
				"#{search_product.name.to_s.ljust(60, ".")} #{search_product.expiration}"
			end
		end
	end

	clymb_store = YAML::Store.new "product.store"

	clymb_store.transaction do
		clymb_store["products"] = ClymbScraper.new.clymb_items
	end
end