class Scraper
    def self.collect_elements
        page = Nokogiri::HTML(open('https://www.webelements.com/nexus/list-of-elements-by-atomic-number/'))
        elements_list = page.css('div.kcite-section tr').drop(1)
        elements_list.collect do |element| 
            array = element.text.split(/\n/).drop(1)
            hash = { 
                :name => array[0],
                :symbol => array[1],
                :number => array [2], 
                :link => element.css('td a').attribute('href').value
            }
            Element.new(hash)
        end
    end

    def self.collect_data(link)
        page = Nokogiri::HTML(open("#{link}"))
        properties = page.css('ul.ul_facts_table').text.split(/\n/).map{|item| item.strip}
        facts = page.css('p.p_first').css('p').text.split(/\n/).drop(1)
        facts.pop
        properties_hash = {}
        if properties.drop(1).find{|item| item.include? "mass"}
            properties_hash[:mass] = properties.drop(1).find{|item| item.include? "mass"}.gsub(/(Relative atomic mass)|\(|[Ar]|\)|\:/,"").strip
        else
            properties_hash[:mass] = "N/A"
        end
        if properties.drop(1).find{|item| item.include? "state"}
            properties_hash[:standard_state] = properties.drop(1).find{|item| item.include? "state"}.gsub(/(Standard state:)/, "").strip
        else   
            properties_hash[:standard_state] = "N/A"
        end
        if properties.drop(1).find{|item| item.include? "Appearance"}
            properties_hash[:appearance] = properties.drop(1).find{|item| item.include? "Appearance"}.gsub(/(Appearance:)/, "").strip
        else   
            properties_hash[:appearance] = "N/A"
        end
        if properties.drop(1).find{|item| item.include? "Class"}
            properties_hash[:classification] = properties.drop(1).find{|item| item.include? "Class"}.gsub(/(Classification:)/, "").strip
        else   
            properties_hash[:classification] = "N/A"
        end
        if facts.join.strip
            properties_hash[:fun_facts] = facts.join.strip 
        else
            properties_hash[:fun_facts] = "N/A"
        end
        element.add_properties(properties_hash)
    end
end