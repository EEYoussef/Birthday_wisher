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