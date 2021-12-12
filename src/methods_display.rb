#-------------method to format the list of contact in table--------#
require "tty-prompt"
require "tty-table"
require "colorize"
require_relative "./classes/contact.rb"

def table_display(array_of_contacts)
   
    header = ["Name", "Birthday","Email"]
    table = TTY::Table.new(header: header)
    array_of_contacts.each do |contact|
        table<<[contact["name"],contact["day"].to_s + "-" + contact["month"].to_s, contact["email"]]
    end
      
    puts table.render(:ascii).red
      
end

def letter_display (letter_name)
    begin
        File.foreach(letter_name) do |line|
            puts "#{line}"
        end
      
    rescue
        puts "Invalid path! please check file name"
        
    end 

end
#----------------Method to ask the user to select a month
def select_month 
    prompt = TTY::Prompt.new
     prompt.select("Select a month",LIST_OF_MONTHS,symbols: { marker: ">" },per_page:12)
    
  end

def select_day(month)
    prompt = TTY::Prompt.new
    case month
    when 4,6,9,11
            day =prompt.ask("Enter Date of Birth \n Day:"){ |q| q.in("1-30") }
    when 1,3,5,7,8,10,12
            day =prompt.ask("Enter Date of Birth \n Day:"){ |q| q.in("1-31") }
    when 2
            day = prompt.ask("Enter Date of Birth \n Day:"){ |q| q.in("1-29") }
    end  
return day

end
#----------Method to collect data from user for the contact
def enter_contact_data
    prompt = TTY::Prompt.new
    name= prompt.ask("Enter Name:")do |q| #to capitalize every word in the name
    q.convert -> (input) { input.split.map(&:capitalize).join(' ')}
    q.modify :strip, :collapse
    q.required true
    q.validate(/^[a-zA-Z\s]*$/,"Invalid name please try again")
    end
    email = prompt.ask("Enter Email:") { |q| q.validate :email,"Invalid email please try again" }
    puts ("Enter Date of Birth ")
    month = select_month
    day = select_day(month)

    new_contact = Contact.new(name,email,month,day)
    return new_contact
end