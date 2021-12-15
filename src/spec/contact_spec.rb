require_relative '../classes/contact.rb'

describe "Contact" do

    before (:each) do
        @test_contact = Contact.new("test","test@hotmail.com","12","9",[])
    end
    it "should be an instance of a Contact" do 
        expect(@test_contact).to be_a Contact 
    end 

    it "should have a name property" do 
        expect(@test_contact.name).to eq("test")
    end 

    it "should have a hash of contacts" do 
        expect(@test_contact.contact_hash). to be_an_instance_of(Hash)
    end

end 