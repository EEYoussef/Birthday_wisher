#-------------method to format the list of contact in table--------#
require "tty-prompt"
require "tty-table"
require "colorize"

def table_display(array_of_contacts)
   
    header = ["Name", "Birthday"]
    table = TTY::Table.new(header: header)
    array_of_contacts.each do |contact|
        table<<[contact["name"],contact["day"].to_s + "-" + contact["month"].to_s]
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