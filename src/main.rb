#--------Required Gems---------------

require "tty-prompt"
require "pastel"
require "Artii"
require "tty-box"
require "tty-font"
# require "tty-color"
require_relative './methods.rb'
require_relative "./methods_display.rb"
#----------ARGV Handling--------
if ARGV.length > 0
  flag, *rest = ARGV
  ARGV.clear
  case flag
  when '-help' , '-h'
    puts "Start with choosing one of the options provided in the menu"
    puts "using the up and down arrows and then press return"
    puts "-info   ------- information about the app"
    puts "-c -------------prints all the contacts in your file"
    puts "-l ------prints all the wishies templates"
    exit
  when '-info'
    puts "This program helps you remeber the birthday of your friend and family "
    puts "implemented using #{RUBY_VERSION}"
    puts "It is an assignment submitted to CoderAcademy"
    exit
  when "-c"
    hash_of_contacts = file_to_array ("./birthday.json")
    array_of_contacts = hash_of_contacts["contacts"]
    table_display (array_of_contacts)
    exit
  when "-l"
    file_name = rest[0]
    if file_name
      if letter_display ("./letter_templates/#{file_name}.txt")
      else
        puts "Or type -l for the list of letter templates names"
      end
      
      exit
    else
      dir = './letter_templates'
      count = Dir.glob(File.join(dir ,'**', '*')).select { |file| File.file?(file) }.count
      puts "You have #{count} files"
      puts Dir.entries(dir)
      exit
    end
  else
    puts "Invalid argument ,please type -h for options"
    exit

  end
end


#----------Styling
pastel = Pastel.new(eachline: "\n")
no_data_style    = pastel.red.bold.detach
warning  = pastel.yellow.detach

#-------------------------app welcoming messge
app_heading

#------------------------


# ------------Reading from file birthday all the contacts 
BIRTHDAY_FILE_PATH = "./birthday.json"
hash_of_contacts = file_to_array (BIRTHDAY_FILE_PATH)
array_of_contacts = hash_of_contacts["contacts"]



#-----------,--Main Menu------------
LIST_OF_MONTHS = {
          "JAN." => 1,
          "FEB." => 2,
          "MAR." =>3,
          "APR," => 4,
          "MAY." => 5,
          "JUNE."=>6,
          "JULY."=> 7,
          "AUG." => 8,
          "SEP." =>9,
          "OCT." => 10,
          "NOV." => 11,
          "DEC." =>12
        }
LIST_OF_MAIN_MENU ={
  'Whose birthday is today?'=> 1,
  'I want to know whose birthday is within an interval'=>2,
  'I want to add a contact'=>3,
  'I want to add new letter'=>4,
  'I want to update a contact'=>5,
  'Exit'=>6
}
while true
  prompt = TTY::Prompt.new
  answer = prompt.select("What would you like to do?",LIST_OF_MAIN_MENU,symbols: { marker: ">" },per_page:6)
  case answer
      when 1 #to find a birthday matches today
          found_birthday_array = get_birthday_of_today(array_of_contacts)
          if found_birthday_array.empty? 
            puts no_data_style.("You dont seem to have any Birthdays today!!")
          else
            table_display (found_birthday_array) 
          end
      when 2 # to find contact in an interval 
        puts "Any birthday between:"
        answer = select_month
        from_month = answer
        answer = prompt.select("And:",LIST_OF_MONTHS.select{|key,value| value >= from_month},symbols: { marker: ">" },per_page:12) 
        to_month = answer
        found_birthday_array = get_birthday_in_interval(array_of_contacts,from_month,to_month)
        if found_birthday_array.empty?
          puts no_data_style.("You dont seem to have any Birthdays in this interval!!")
        else
          table_display (found_birthday_array) 
        end
      when 3 # to add new contact
          puts "To add a new contact you need to provide Name, email, and Date of Birth"
          new_contact = enter_contact_data    
          new_contact.display_contact
          if prompt.yes?("Do You want to save?")
            new_contact.add_contact_to_file(BIRTHDAY_FILE_PATH)
          else

          end
      when 4
        
      when 5 # to update a contact using the name
        i=0
        prompt_update = TTY::Prompt.new
        name= prompt_update.ask("Enter Name:")do |q| #to capitalize every word in the name
        q.convert -> (input) { input.split.map(&:capitalize).join(' ')}
        q.modify :strip, :collapse
        q.required true
        q.validate(/^[a-zA-Z\s]*$/,"Invalid name please try again")
        end
        found_contact = get_contact_by_name(name)
        if found_contact.empty?
          puts "No contacts matches this name"
        else
        if found_contact.length >=2 
          
          puts "You have #{found_contact.length} contacts"
          prompt_choose = TTY::Prompt.new
          change_answer = prompt_choose.select("Which one do you want to change") do |menu|
              found_contact.each do |contact|
              menu.choice name: "#{contact["name"]} Email: #{contact ["email"]} Data of Birth(dd-mm) %0.2d" % contact["day"]+ "- %0.2d" % contact["month"],  value: i
              i+=1
               
              end
            end
          else
            puts "Name: #{found_contact[0]["name"]}  Email: #{found_contact[0]["email"]}  Data of Birth (dd - mm): %0.2d" % found_contact[0]["day"] + "- %0.2d" % found_contact[0]["month"]
            change_answer = 0
          end
          
          update_contact (found_contact[change_answer])

        end

      when 6
        end_app_heading
        puts "Thank You for using the app.".blue 
        break
  end
end