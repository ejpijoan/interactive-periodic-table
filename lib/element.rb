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

    def name=(name)
        @name = name
    end 
    
    def name
        @name
    end

    def self.find_by_name(name)
        @@all.find{|element| element.name == name}
    end

    def self.new_attr
        hash_1 = {Ununtrium:"Nihonium", Ununpentium:"Moscovium", Ununseptium:"Tennessine", Ununoctium:"Oganesson"}
        hash_1.each do |key, value|
            self.find_by_name("#{key.to_s}").name= value
        end
        hash_2 = {Nihonium:"Nh", Moscovium:"Mc", Tennessine:"Ts", Oganesson:"Og"}
        hash_2.each do |key, value|
            self.find_by_name("#{key.to_s}").symbol= value
        end
    end

    #create a class method that takes and argument of a classification and returns an array of all elements that have that classification.

    def self.list_by_classification(classification)
        self.all.find_all{|element| element.classification == classification} 
    end
end

