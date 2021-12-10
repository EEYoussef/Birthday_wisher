require_relative '../methods.rb'


describe "get_birthday_of_today" do
    contact_test = Contact.new("Test_name","test_email@abc.com",12,9)
    it "should be defined" do 
        expect(defined? get_birthday_of_today).to eq("method")
    end
    it "should accept an argument" do
        expect (get_birthday_of_today()). to raise_error
    end

    it "should return names of contacts who's birthday is today" do 
        expect(get_birthday_of_today(contact_test)).to be_a Contact 
    end 

end
describe "get_birthday_in_interval" do
    contact_test = Contact.new("Test_name","test_email@abc.com",12,9)
    it "should be defined" do 
        expect(defined? get_birthday_in_interval).to eq("method")
    end
    it "should accept an argument" do
        expect (get_birthday_in_interval()). to raise_error
    end
    it "should accept three argument array and start and end date" do
        expect (get_birthday_in_interval(contact_test,)). to raise_error
    end
    it "should return names of contacts who's birthday is tody" do 
        expect(get_birthday_in_interval(contact_test,'1-1','30-12')).to be_a Contact 
    end 

end