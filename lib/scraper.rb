require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper
    def open_page
        Nokogiri::HTML(open('https://www.webelements.com/nexus/list-of-elements-by-atomic-number/'))
    end

    def collect_elements
        #page = self.open_page
        page = Nokogiri::HTML(open('https://www.webelements.com/nexus/list-of-elements-by-atomic-number/'))
        elements_list = page.css('div.kcite-section').css('tr').drop(1)
        elements_array = elements_list.collect do |element| 
            array = element.text.split(/\n/).drop(1)
            hash = { 
                :name => array[0],
                :symbol => array[1],
                :number => array [2], 
                :link => element.css('td a').attribute('href').value
            }
        end
        
    end

    binding.pry
end