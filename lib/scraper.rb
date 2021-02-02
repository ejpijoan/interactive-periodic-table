require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper

    def open_page
        periodic_table = Nokogiri::HTML(open('https://pubchem.ncbi.nlm.nih.gov/periodic-table/'))
    end
binding.pry

end