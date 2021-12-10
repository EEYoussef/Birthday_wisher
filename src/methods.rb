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
        puts "Invalid path! Creating file for you"
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