#--------Required Gems---------------

require "tty-prompt"
require "pastel"
require "Artii"
require "tty-box"
require "tty-font"
# require "tty-color"
require_relative './methods.rb'
require_relative "./methods_display.rb"
#----------Styling
pastel = Pastel.new(eachline: "\n")
no_data_style    = pastel.red.bold.detach
warning  = pastel.yellow.detach
# ------------Reading from file birthday all the contacts 
hash_of_contacts = file_to_array ("./birthday.json")
array_of_contacts = hash_of_contacts["contacts"]
#-------------------------
app_heading

#------------------------

#-----------,--Main Menu------------
list_of_months = {
          "JAN." => 1,
          "FEB." => 2,
          "MAR." =>3,
          "APR," => 4,
          "MAY." => 5,
          "JUNE."=>6,
          "JULY,"=> 7,
          "AUG." => 8,
          "SEP." =>9,
          "OCT," => 10,
          "NOV." => 11,
          "DEC." =>12
        }
while true
  prompt = TTY::Prompt.new
  answer = prompt.select("What would you like to do?") do |menu|
      menu.choice 'Whose birthday is today?',1
      menu.choice 'I want to know whose birthday is within an interval',2
      menu.choice 'I want to add a contact',3
      menu.choice 'I want to add new letter',4
      menu.choice 'I want to update a contact',5
      menu.choice 'Exit',6
    end


  case answer
      when 1
          get_birthday_of_today(array_of_contacts)
      when 2
      
        answer = prompt.select("Any birthday between:",list_of_months) 
        from_month = answer

        answer = prompt.select("And:",list_of_months.select{|key,value| value >= from_month}) 
        
        to_month = answer
        found_birthday_array = get_birthday_in_interval(array_of_contacts,'from_month','to_month')
        if found_birthday_array == []
          puts no_data_style.("You dont seem to have any Birthdays in this interval!!")
          
        else
          table_display (found_birthday_array) 
        end
      when 3
      when 4
      when 5
      when 6
        end_app_heading
        puts "Thank You for using the app.".blue 
        break
  end
end