require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper
    attr_accessor :url

    def initialize(url)
        @url = 'https://www.webelements.com/nexus/list-of-elements-by-atomic-number/'
    end

    def open_page(url)
        Nokogiri::HTML(open(url))
    end

    def collect_elements
        page = self.open_page(self.url)
        elements_list = page.css('div.kcite-section').css('tr').drop(1)
        elements_list.collect do |element| 
            array = element.text.split(/\n/).drop(1)
            hash = { 
                :name => array[0],
                :symbol => array[1],
                :number => array [2], 
                :link => element.css('td a').attribute('href').value
            }
        end
    end

    def collect_data(link = "https://www.webelements.com/hydrogen/")
        page = self.open_page("https://www.webelements.com/hydrogen/")
        #

    end

    binding.pry
end