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

    it "should make the correct api call to google" do
      credentials = { "token" => '1234' }
      page = 1
      start = (page - 1) * ContactsAPI::PER_PAGE + 1
      path   = "/m8/feeds/contacts/default/full?max-results=#{ContactsAPI::PER_PAGE}&start-index=#{start}"
      headers = {
        'Authorization' => "AuthSub token=#{credentials["token"]}",
        'GData-Version' => "3" }
      Net::HTTP.any_instance.should_receive(:get).with(path, headers)
      api = ContactsAPI.new(credentials)
      api.stub(:parse_response)
      api.contacts(page)
    end
  end
end
