require_relative '../methods.rb'
require_relative '../classes/contact.rb'
require 'date'
require 'json'

describe 'methods' do
    # to create at least one contact with today's date
    #  before(:each) do 
        today = Time.now
        today_month = today.month
        today_day = today.day
        contact_test = Contact.new("Today","test_email@abc.com",today_month,today_day)
        begin
            json = File.read('./test-birthday.json')
            secondJsonArray = JSON.parse(json)
            secondJsonArray["contacts"]<< contact_test.contact_hash
            File.open("./test-birthday.json","w") do |f|
                f.puts JSON.pretty_generate(secondJsonArray)
                end
                contacts_array =  secondJsonArray["contacts"]
        rescue
            default_json_contact = {"contacts":[contact_test.contact_hash]}
            
            File.open('./test-birthday.json', "w+") do |file| 
            file.write(default_json_contact.to_json)
            end
            contacts_array =  default_json_contact["contacts"]
         end
        
         

    #  end

    #----to fill the file with test data after all the tests are done
    after(:all) do 
        today = Time.now
        today_month = today.month
        today_day = today.day
        test_contact_array ={"contacts": [{"name":"Test One","email":"test@r.com","month":3,"day":8},
        {"name":"Test Two","email":"one@one.com","month":3,"day":8},
        {"name":"Eman","email":"gcas022101@coderacademy.edu.au","month":6,"day":2},
        {"name":"Three","email":"three@three.COM","month":2,"day":14},
        {"name":"Today","email":"today@three.COM","month":today_month,"day":today_day}]}
        File.open('./test-birthday.json', "w") do |file| 
            file.write(test_contact_array.to_json)

        end 
    end 
     describe 'file_to_array' do
        
    it "file_to_array should return an array" do
        expect(file_to_array('./test-birthday.json')). to be_a (Hash)
        end
        
     end
     describe 'get_birthday_of_today' do
        json = File.read('./test-birthday.json')
        secondJsonArray = JSON.parse(json)
       
        it "get_birthday_of_today should return an array " do
            expect(get_birthday_of_today(secondJsonArray["contacts"])). to be_a (Array)
        end
        it "get_birthday_of_today should return an array " do
            expect(get_birthday_of_today(secondJsonArray["contacts"]).any? {|contact| contact["name"] == "Today"}).to be_truthy

        end
     end
     describe 'get_birthday_in_interval' do
        json = File.read('./test-birthday.json')
        secondJsonArray = JSON.parse(json)
        from_month =2
        to_month =12
       it 'should return array of contacts in interval' do
        expect(get_birthday_in_interval(secondJsonArray["contacts"],from_month,to_month).any? {|contact| contact["name"] == "Today"}). to be_truthy
       end
     end

end 




# describe "get_birthday_in_interval" do
#     contact_test = Contact.new("Test_name","test_email@abc.com",12,9)
#     it "should be defined" do 
#         expect(defined? get_birthday_in_interval).to eq("method")
#     end
#     it "should accept an argument" do
#         expect (get_birthday_in_interval()). to raise_error
#     end

#     it "should return names of contacts who's birthday that lies in the range of months given" do 
#         expect(get_birthday_in_interval(contact_test,1,12)).to be_a Contact 
#     end 

# end
# describe "get_birthday_in_interval" do
#     contact_test = Contact.new("Test_name","test_email@abc.com",12,9)
#     it "should be defined" do 
#         expect(defined? get_birthday_in_interval).to eq("method")
#     end
#     it "should accept an argument" do
#         expect (get_birthday_in_interval()). to raise_error
#     end

#     it "should return names of contacts who's birthday that lies in the range of months given" do 
#         expect(get_birthday_in_interval(contact_test,1,12)).to be_a Contact 
#     end 

# end
# end 
