require 'pry'

class CLI
    def top_ten
        top_ten = [oxygen, silicone, aluminum, iron, calcium, sodium, magnesium, potassium, titanium]
    end

    def welcome
        puts "Hello, welcome to the Periodic Table of the Elements."
    end

    def collect_element
        puts "Please choose an element to learn more about it by typing the name, atomic number, or atomic symbol and pressing enter. Alternately you may choose from a list of the ten most common elements by entering 'top ten'."
        input = gets
        if Element.all.find{|element| element.name == input || element.number == input || element.symbol == input}
        element = Element.all.find{|element| element.name == input || element.number == input || element.symbol == input}
        self.collect_info(element)
        elsif input == "top ten"
            puts "Ten Most Common Elements on Earth:"
            self.top_ten.each_with_index {|element, index| puts "#{index+1}. #{element}"}
        else
            puts "The element you have entered is not valid."
            self.collect_element 
        end
    end

    def valid_element?(input)
        if Element.all.find{|element| element.name == input || element.number == input || element.symbol == input}
            true
        else
            false 
        end
    end

end

