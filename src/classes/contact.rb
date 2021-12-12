require "json"
# This Class is responsible of all the contact details in the birthday file
class Contact
    attr_accessor :name , :email ,:contact_array, :contact_hash
    attr_accessor :bd_month , :bd_day

    def initialize(name,email,month,day)
        @name = name
        @email = email
        @month = month
        @day = day
        @contact_hash = {"name": @name , "email": @email ,"month": @month, "day": @day}
        
    end


    def add_contact_to_list (contact_array)
        contact_array << @contact_hash
    end
    

    #------------Add a contact to the file
    def add_contact_to_file (file_path)
        
             begin
                json_from_file = File.read(file_path)
                json_array = JSON.parse(json_from_file)
                    json_array["contacts"] << @contact_hash
                    #  puts json_array
                    File.write(file_path ,json_array.to_json)   
                
             rescue
                puts "Invalid path! Creating file for you"
                file_path = "./birthday.json"
                default_json_contact = {"contacts":[self.contact_hash]}
                File.open(file_path, "w") do |file| 
                    file.write(default_json_contact.to_json)
                end
            end
             
  
    end
     #-------display contact--------
     def display_contact 
        puts "Name: #{@name} \n Email: #{@email} \n Data of Birth (dd - mm): %0.2d" % [@day] + "- %0.2d" % [@month]
    end
    
    #-----------update contact--------
# def  update_contact (file_path,name,email,month,day)
#     contact_array = file_to_array(file_path)

#     contact_array[0].each do |key, value|
#         puts "#{key} = #{value}"
#     end
#   end



end
