require_relative '../config/environment'

class CLI

    def welcome
        puts "Hello! Welcome to the Periodic Table of the Elements!"
    end

    def self.collect_elements
        array = Scraper.collect_elements
        Element.create_from_scraped_data(array)
        Element.new_attr
    end

    def choose_element
        puts "Please choose an element to learn more about it by typing the name, atomic number, or atomic symbol and pressing enter."
        puts "Alternately you may choose from a list of the ten most common elements by entering 'top ten'."
        input = gets
        if self.valid_element?(input)
            binding.pry
            element = Element.all.find{|element| element.name == input.capitalize || element.number == input || element.symbol == input}
            self.ask_for_info(element)
        elsif input == "top ten"
            puts "Ten Most Common Elements on Earth:"
            self.top_ten
        elsif input == exit
            abort "You have chosen to exit the program."
        else
            puts "The element you have entered is not valid."
            self.choose_element 
        end
    end

    def top_ten
        top_ten = ["Oxygen", "Silicone", "Aluminum", "Iron", "Calcium", "Sodium", "Magnesium", "Potassium", "Titanium"]
        top_ten.each_with_index {|element, index| puts "#{index+1}. #{element}"}
            input = gets
            if self.valid_element?(input)
            self.ask_for_info?
            elsif input == exit
                abort "You have chosen to exit the program."
            else
                puts "You have selected and invalid element, please choose again"
                self.top_ten
            end
    end

    def valid_element?(input)
        if Element.all.find{|element| element.name == input.downcase || element.number == input || element.symbol == input}
            true
        else
            false 
        end
    end

    def add_attr_element(element)
        link = element.link 
        Element.add_attributes(link)
    end

    def ask_for_info(element)
        CLI.add_attr_element(element)
        puts "You chose the element #{element}, for more information choose from the options below or type exit to exit the program"
        puts "For the atomic number of your element type 'atomic number'"
        puts "For the atomic symbol of your element type 'atomic symbol'"
        puts "For the atomic mass of your element type 'atomic mass'"
        puts "For the standard state of your element type 'standard state'"
        puts "For a short description of the appearance of your element type 'appearance'"
        puts "For the classification of your element type 'classification'"
        puts "For fun facts and/or triva about your element tye 'fun facts'"
        puts "If you would like to choose another element type 'new element'"
        input = gets
        if input == "atomic number"
            puts "The atomic number of #{element.name} is #{element.number}."
        elsif input == "atomic symbol"
            puts "The atomic symbol of #{element.name} is #{element.symbol}."
        elsif input == "atomic mass"
            puts "The atomic mass of #{element.name} is #{element.mass} amu (atomic mass units)."
        elsif input == "standard state"
            puts "The standard state of #{element.name} is #{element.standard_state}"
        elsif input == "appearance"
            puts "Your element is #{element.appearance}."
        elsif input == "classification"
            puts "#{element.name} is classified as #{element.classification}."
        elsif input == "fun facts"
            puts "#{element.fun_facts}"
        elsif input == "new element"
            self.ask_for_info
        elsif input == exit
            abort "You have chosen to exit the program."
        else
            puts "You have given an invalid input, please choose again"
            self_ask_for_info?
        end
    end

    def periodic_table_run
        self.welcome
        CLI.collect_elements
        self.choose_element
        self.ask_for_info
    end
end

