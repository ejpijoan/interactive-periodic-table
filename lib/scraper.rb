require_relative '../config/environment' 

class Scraper
    
    def self.collect_elements
        page = Nokogiri::HTML(open('https://www.webelements.com/nexus/list-of-elements-by-atomic-number/'))
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

    def self.collect_data(link)
        page = Nokogiri::HTML(open("#{link}"))
        properties = page.css('ul.ul_facts_table').text.split(/\n/).map{|item| item.strip}
        properties_hash = {
        :mass => properties.drop(1).find{|item| item.include? "mass"}.gsub(/(Relative atomic mass)|\(|[Ar]|\)|\:/,"").strip,
        :standard_state => properties.drop(1).find{|item| item.include? "state"}.gsub(/(Standard state:)/, "").strip,
        :appearance => properties.drop(1).find{|item| item.include? "Appearance"}.gsub(/(Appearance:)/, "").strip,
        :classification => properties.drop(1).find{|item| item.include? "Class"}.gsub(/(Classification:)/, "").strip,
        :facts => page.css('p.p_first').css('p').text.split(/\n/).join.strip
        }
    end

    #binding.pry
end