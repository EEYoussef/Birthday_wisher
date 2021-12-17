require "json"
require 'date'

# require 'active_support/all' #handle the time interval
#-------------to clear the terminal
def self_clear
    print "\e[2J\e[f"
end 
#---------------------------
#-----------Reading from file and extracting data into an array-----------
def file_to_array(file_path)
    begin
        json_from_file = File.read(file_path)
        array_of_hash = JSON.parse(json_from_file)   
        
    rescue
        puts "Invalid path! Creating file for you "
        
        default_json_contact = {"contacts":[]}
        File.open(file_path, "w") do |file| 
            file.write(default_json_contact.to_json)
        end
        array_of_hash = default_json_contact
    end 
    return array_of_hash
end 
#----------searching for contacts that have their birthday today
def get_birthday_of_today(array_of_contacts)
     #  Getting the current  day and month
        today = Time.now
        today_month = today.month
        today_day = today.day
        found_birthdays = []
             
        array_of_contacts.each do |contact|
           
        if contact["month"] == today_month && contact["day"] == today_day
            
            found_birthdays << contact
            puts "Today is #{contact["name"]}'s Birthday"
        end
    end
    return found_birthdays
end
#----------Method that takes the interval of dates to look in and returns a list of name or no one found-----------#
def get_birthday_in_interval(array_of_contacts,from_month,to_month)
    found_birthdays=[]
    if array_of_contacts 
     array_of_contacts.each do |contact|
        if contact["month"] >= from_month && contact["month"] <= to_month
            found_birthdays << contact
        end
    
    end
end
    return found_birthdays

end
#-----------

#-----get contact by name
def get_contact_by_name(name)
    array_of_contacts = file_to_array(BIRTHDAY_FILE_PATH)
    found_array = []
    i=0
    array_of_contacts.each do |key ,contact_list|
        contact_list.each do |contact|
            if contact["name"].include? name
                found_array << contact
            end 

        end
    end
    return found_array
end

def get_contact_index(contact_hash)
    file_array = file_to_array (BIRTHDAY_FILE_PATH)
    index = file_array["contacts"].index(contact_hash)
   return index 
end


def delete_contact_from_file(index)
    file_array = file_to_array (BIRTHDAY_FILE_PATH)
    updated_array = file_array["contacts"].dup.tap{|i| i.delete_at(index)}
    updated_array_in_hash = {"contacts"=> updated_array}
    # File.open(BIRTHDAY_FILE_PATH,'w') { |f| f.puts updated_array.to_json }
    File.write(BIRTHDAY_FILE_PATH ,updated_array_in_hash.to_json)   

end


def update_contact(contact_hash)
    contact_index_in_file = get_contact_index(contact_hash)
    prompt = TTY::Prompt.new(interrupt: :exit)
    answer = prompt.select("Which field do you want to change?") do |menu|
        menu.choice "Email", 1
        menu.choice "Data of Birth", 2
        menu.choice "Exit to main menu", 3
      end
      case answer
      when 1 
        email = prompt.ask("Enter Email:") { |q| q.validate :email,"Invalid email please try again" }
        contact_hash["email"] = email
      when 2
        puts ("Enter Date of Birth ")
        month = select_month
        day = select_day(month)
        contact_hash["day"] = day
        contact_hash["month"]=month
      when 3
        return
    end
        updated_contact = Contact.new(contact_hash["name"],contact_hash["email"],contact_hash["month"],contact_hash["day"])
        updated_contact.display_contact
          if prompt.yes?("Do You want to save?")
            begin
                delete_contact_from_file(contact_index_in_file)
                updated_contact.add_contact_to_file(BIRTHDAY_FILE_PATH)
                confirm_message ("Contact Updated.")
               
                rescue
                    error_message("Something went wrong, please try again!!!")
            end
          else

          end
    
end
def create_write_letter (letter)
    #count files in folder
    dir = './letter_templates'
    number_of_letters = Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
    new_letter_name = "letter_#{number_of_letters + 1}.txt"
    File.open("#{dir}/#{new_letter_name}", "w") do |file| 
    file.puts(letter)
        end

end
    
def require_contact_by_name
    i=0
    prompt_update = TTY::Prompt.new(interrupt: :exit)
    name= prompt_update.ask("Enter Name:")do |q| #to capitalize every word in the name
    q.convert -> (input) { input.split.map(&:capitalize).join(' ')}
    q.modify :strip, :collapse
    q.required true
    q.validate(/^[a-zA-Z\s]*$/,"Invalid name please try again")
    end
    found_contact = get_contact_by_name(name)
    if found_contact.empty?
      puts "No contacts matche this name".red
      return
    else
    if found_contact.length >=2 
      
      puts "You have #{found_contact.length} contacts"
      prompt_choose = TTY::Prompt.new(interrupt: :exit)
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
      return found_contact[change_answer]
    end
end


def choose_contact
    
   contact= require_contact_by_name
  


end

def choose_contact_for_email (found_contact)
       i=0
        puts "You have #{found_contact.length} contacts"
        prompt_choose = TTY::Prompt.new(interrupt: :exit)
        change_answer = prompt_choose.select("Which one do you want to change") do |menu|
            found_contact.each do |contact|
            menu.choice name: "#{contact["name"]} Email: #{contact ["email"]} Data of Birth(dd-mm) %0.2d" % contact["day"]+ "- %0.2d" % contact["month"],  value: i
            i+=1
            end
          end
       
        return found_contact[change_answer]
      
end


def random_letter
    dir = './letter_templates'
    number_of_letters = Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
    random_letter_name = "letter_#{rand (1..number_of_letters)}.txt"
    return random_letter_name
    
end 
def ask_for_signiture
    prompt_update = TTY::Prompt.new(interrupt: :exit)
    name= prompt_update.ask("Enter Signiture Name:")do |q| #to capitalize every word in the name
    q.convert -> (input) { input.split.map(&:capitalize).join(' ')}
    q.modify :strip, :collapse
    q.required true
    q.validate(/^[a-zA-Z\s]*$/,"Invalid name please try again")
    end
    return name 
end

def prepare_email(contact,random_letter,name)
   
# load the file as a string

data = File.read("./letter_templates/#{random_letter}") 
# globally substitute "install" for "latest"
filtered_data = data.gsub("[NAME]", contact["name"]) 
filtered_data_with_signiture = filtered_data.gsub("[YourName]",name)
puts filtered_data_with_signiture
return filtered_data_with_signiture



end
def send_email(message,email)
    prompt = TTY::Prompt.new(interrupt: :exit)
begin    
    
    # Create an instance of Postmark::ApiClient:
    client = Postmark::ApiClient.new(API_TOKEN)
    
    response= client.deliver(
    from: SENDER_SIGNATURE,
    to: email,
    subject: "HAPPY BIRTHDAY!",
    text_body: message,
    track_opens: true) 
    confirm_message ("DONE!!! message has been sent")
   
  rescue Postmark::Error => error
    #message = "#{error.error_code} #{error.message}"
    error_message = "Error Occured Message not sent ***Please Check your account on Postmark***"
    error_message (error_message)
    
    # parsed_json = JSON.parse(client.response.body)
    # puts parsed_json
end
end