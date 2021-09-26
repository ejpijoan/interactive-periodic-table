class CLI

    def welcome
        puts "Hello! Welcome to the Periodic Table of the Elements!"
        Scraper.collect_elements
        self.choose_element
    end

    def choose_element
        puts "Please choose an element to learn more about it by typing the name, atomic number, or atomic symbol and pressing enter."
        puts "Alternately you may choose from a list of the ten most common elements by entering 'top ten'."
        input = gets.strip
        if element = Element.valid?(input)
            self.ask_for_info(element)
        elsif input == "top ten"
            puts "Ten Most Common Elements on Earth:"
            self.top_ten
        elsif input == "exit"
            abort("Goodbye!")
        else
            puts "The element you have entered is not valid."
            self.choose_element 
        end
    end

    def top_ten
        top_ten = Element.top_ten_list
        binding.pry
        top_ten_names = top_ten.collect{|element| element.name} 
        top_ten_names.each_with_index {|element, index| puts "#{index+1}. #{element}"}
        puts "To choose an element type its name, atomic symbol, or attomic number."
        puts "You may also find an element by typing its pound sine (#) follwoed by its nubmer on the list, as in '#1'"
            input = gets.strip
            if Element.valid_from_list?(input)
                element = Element.valid_from_list?(input)
            self.ask_for_info(element)
            elsif input == "exit"
                abort"Goodbye!"
            else
                puts "You have selected and invalid element, please choose again"
                self.top_ten
            end
    end

    def ask_for_info(element)
        element.add_attributes
        puts "You chose the element #{element.name}, for more information choose from the options below or type 'exit' to exit the program."
        puts "For the atomic number of your element type 'atomic number'"
        puts "For the atomic symbol of your element type 'atomic symbol'"
        puts "For the atomic mass of your element type 'atomic mass'"
        puts "For the standard state of your element type 'standard state'"
        puts "For a short description of the appearance of your element type 'appearance'"
        puts "For the classification of your element type 'classification'"
        puts "For fun facts and/or triva about your element tye 'fun facts'"
        puts "If you would like to choose another element type 'new element'"
        input = gets.strip
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
            self.choose_element
        elsif input == "exit"
            abort"Goodbye!"
        else
            puts "You have given an invalid input, please choose again"
            self.ask_for_info(element)
        end
        self.choose_again(element)
    end

    def choose_again(element)
        puts "Would you like to choose another element, or see further information on your chosen element?"
        puts "If you would like to choose another element type 'new element'."
        puts "If you would like to see further information please type 'more info'."
        input = gets.strip

        if input == "new element"
            self.choose_element
        elsif input == "more info"
            self.ask_for_info(element)
        elsif input == "exit"
            abort"Goodbye!"
        else
            puts "You have given an invalid input, please choose again"
            self.choose_again(element)
        end
    end

    def end
        abort('Goodbye!')
    end

end

