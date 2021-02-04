require 'pry'

class CLI

    def welcome
        puts "Hello, welcome to the Periodic Table of the Elements."
    end

    def collect_element
        puts "Please choose an element to learn more about it by typing the name, atomic number, or atomic symbol and pressing enter. Alternatly you may choose from a list of the ten most common elements by entering 'top ten'."
        input = gets
        if name
        elsif number
        elsif symbol
        elsif top ten
        else
            puts "The element you have entered is not valid."
            self.collect_element 
        end
    end
end

