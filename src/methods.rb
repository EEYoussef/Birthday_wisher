require "json"
require 'date'
# require 'active_support/all' #handle the time interval
#-------------to clear the terminal
def self_clear
    print "\e[2J\e[f"
end 
#---------------------------

def app_heading
    self_clear
    arter = Artii::Base.new
    puts arter.asciify("Birthday Wisher").blue
    pastel = Pastel.new
    font = TTY::Font.new(:starwars)
    puts pastel.blue(font.write("Welcome", letter_spacing: 1))
    # box = TTY::Box.frame(width: 165, height: 5, align: :center) do
    #      "Welcome to Birthday Wisher".blue
    #     end
    # puts box
    
end 
#------------end of app heading--------
def end_app_heading
    self_clear
    arter = Artii::Base.new
    puts arter.asciify("SEE  YOU  NEXT  TIME !").blue
end 
#-----------Reading from file and extracting data into an array-----------
def file_to_array(file_path)
    begin
        json_from_file = File.read(file_path)
        array_of_hash = JSON.parse(json_from_file)   
        
    rescue
        puts "Invalid path! Creating file for you "
        pp file_path
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
     array_of_contacts.each do |contact|
        if contact["month"] >= from_month && contact["month"] <= to_month
            found_birthdays << contact
            # puts " #{contact["name"]}'s Birthday is IN"
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
            if contact["name"]==name
                found_array << contact
            end 

        end
       
        # if contact[:name] ==name
        #     puts contact["email"]
        # end
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
    prompt = TTY::Prompt.new
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
            delete_contact_from_file(contact_index_in_file)

            updated_contact.add_contact_to_file(BIRTHDAY_FILE_PATH)
          else

          end
    
end