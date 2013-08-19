require 'spec_helper'

describe ContactsAPI do
  let(:entries) do
    OpenStruct.new(
      body: File.read(Rails.root.join('spec/fixtures/response_sample.xml'))
    )
  end

  describe "#contacts" do
    it "should return the entries parsed as 'Contact'" do
      api = ContactsAPI.new({})
      api.stub(:response).and_return(entries)
      contacts = api.contacts(1)
      contacts.size.should eq 3
      contacts.each { |c| c.should be_a(Contact) }
    end
  end
end
