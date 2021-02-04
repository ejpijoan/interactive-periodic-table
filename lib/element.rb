require_relative '../config/environment'

class Element

    @@all = []

    def initialize(hash)
        self.add_attributes(hash)
        @@all << self
    end

    def self.all
        @@all
    end

    def self.create_from_scraped_data(elements_array)
        elements_array.each do|element| 
            element[:name] = Element.new(element)
        end
    end

    def add_attributes(hash)
        hash.each do |key, value|
            self.class.attr_accessor(key)
            self.send(("#{key}="),value)
        end
    end

    def self.find_by_attr(attribute, search_term)
        @@all.find{|element| element.send(("#{attribute}="), search_term)}
    end

    def self.new_names
        array = {Ununtrium:"Nihonium", Ununpentium:"Moscovium", Ununseptium:"Tennessine", Ununoctium:"Oganesson"}
        array.each do |key, value|
         self.find_by_attr("name", "#{key.to_s}").name= value
        end
    end

binding.pry
end

