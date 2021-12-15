#--------Required Gems---------------

require "tty-prompt"
require "pastel"
require "Artii"
require "tty-box"
require "tty-font"
require "postmark"
require "dotenv"
require_relative './methods.rb'
require_relative "./methods_display.rb"

Dotenv.load("./.env")

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

API_TOKEN = ENV['API_TOKEN_POSTMARK']
SENDER_SIGNATURE = ENV['SENDER_SIGNATURE_POSTMORK']





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
  'I want to know whose birthday is today.'=> 1,
  'I want to know whose birthday is within an interval.'=>2,
  'I want to add a contact.'=>3,
  'I want to add new letter.'=>4,
  'I want to update a contact.'=>5,
  'I want to remove a contact.'=>6,
  'I want to send Birthday wish to someone.'=>7,
  'I want to see my contact list.'=>8,
  'Exit'=>9
}
while true
  prompt = TTY::Prompt.new
  answer = prompt.select("What would you like to do?",LIST_OF_MAIN_MENU,symbols: { marker: ">" },per_page:12)
  case answer
      when 1 #to find a birthday matches today
        menu_heading("BIRTHDAY   MATCH")
        hash_of_contacts = file_to_array (BIRTHDAY_FILE_PATH)
        array_of_contacts = hash_of_contacts["contacts"]
          found_birthday_array = get_birthday_of_today(array_of_contacts)
          if found_birthday_array.empty? 
            puts no_data_style.("You dont seem to have any Birthdays today!!")
          else
            table_display (found_birthday_array) 
          if prompt.yes?("Do You want to send an email?") 
            if found_birthday_array.length >=2
              choose_contact_for_email(found_birthday_array)
              contact = choose_contact
              if contact
              random_letter_name =random_letter
              name = ask_for_signiture
              message = prepare_email(contact,random_letter_name,name)
              send_email(message,contact["email"])
              end
            else
              contact = found_birthday_array[0]
              if contact
              random_letter_name =random_letter
              name = ask_for_signiture
              message = prepare_email(contact,random_letter_name,name)
              puts message
              send_email(message,contact["email"])
              end
            end
            
          end
        end

      when 2 # to find contact in an interval 
        menu_heading("BIRTHDAY   MATCH")
        hash_of_contacts = file_to_array (BIRTHDAY_FILE_PATH)
        array_of_contacts = hash_of_contacts["contacts"]
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
        menu_heading("ADD   CONTACT")
          puts "To add a new contact you need to provide Name, email, and Date of Birth"
          new_contact = enter_contact_data    
          new_contact.display_contact
          if prompt.yes?("Do You want to save?")
            new_contact.add_contact_to_file(BIRTHDAY_FILE_PATH)
          else

          end
      when 4 # to add letter template
        menu_heading("ADD   LETTER")
        letter_temp_to = "Dear [NAME],"
        letter_temp_body = prompt.multiline("Please type your message", default: "Happy Birthday")
        if letter_temp_body.is_a?(String)
          letter_temp_body = [letter_temp_body]
        end
        letter_temp_body.join(" ")
        letter_signature = prompt.multiline("Please type your signature", default: "All my love,\n [YourName]") 
        if letter_signature.is_a?(String)
          letter_signature = [letter_signature]
        end
        letter_signature.join(" ")
        letter_temp = "#{letter_temp_to}\n #{letter_temp_body.join(" ")},\n#{letter_signature.join(" ")}"
       
        create_write_letter(letter_temp)
       
        
      when 5 # to update a contact using the name
        menu_heading("UPDATE   CONTACT")
        found_contact = require_contact_by_name  
        if found_contact
          update_contact (found_contact)
        end
      when 6 # to remove a contact from the list
        menu_heading("REMOVE   CONTACT")
        found_contact = require_contact_by_name 
        contact_index_in_file = get_contact_index(found_contact) 
        if found_contact
          if prompt.yes?("Do You want to Delete?")
            begin
              delete_contact_from_file (contact_index_in_file)
              confirm_message("Contact deleted")

                rescue
                  error_message("Something went wrong, please try again!!!")
            end
          else

          end
          
        end
      when 7  # sending email to someone
        menu_heading("SEND   EMAIL")
          contact = choose_contact
          if contact
          random_letter_name =random_letter
          name = ask_for_signiture
          message = prepare_email(contact,random_letter_name,name)
          send_email(message,contact["email"])
          end
      when 8 # to retrieve the contact list in file
        menu_heading("CONTACT   LIST")
          hash_of_contacts = file_to_array(BIRTHDAY_FILE_PATH)
         table_display (hash_of_contacts["contacts"])
      
      when 9
        end_app_heading
        puts "Thank You for using the app.".blue 
        break
  end
end