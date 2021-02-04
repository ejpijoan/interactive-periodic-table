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

    def self.find_by_name(name)
        @@all.find(|element| element.name == name)
    end

    def self.new_names
         self.find_by_name("ununtrium").name= "nihonium"
         self.find_by_name("ununpentium").name= "moscovium"
         self.find_by_name("ununseptium").name= "tennessine"
         self.find_by_name("ununoctium").name= "oganesson"
    end

#binding.pry
end

