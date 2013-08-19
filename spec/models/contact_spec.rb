require 'spec_helper'

describe Contact do
  let(:xml) { File.read(Rails.root.join('spec/fixtures/response_sample.xml')) }
  let(:contacts_entry) { REXML::Document.new(xml).elements }

  it "should parse correctly the fields" do
    contacts_entry.each('//entry') do |entry|
      contact = Contact.new(entry)
      contact.name.should eq 'Fitzwilliam Darcy'
      contact.email.should eq 'sample@test.com'
    end
  end

end
