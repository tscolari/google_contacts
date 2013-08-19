require 'net/http'
require 'net/https'
require 'uri'
require 'rexml/document'

class ContactsAPI

  def initialize(oauth_credentials)
    @credentials = oauth_credentials
  end

  def contacts
    @contacts ||= parse_response(response)
  end

  private

  def parse_response(response)
    xml = REXML::Document.new(response.body)
    Array.new.tap do |contacts|
      xml.elements.each('//entry') do |entry|
        contacts << Contact.new(entry)
      end
    end
  end

  def response
    uri = URI.parse("https://www.google.com")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    path = "/m8/feeds/contacts/default/full?max-results=10000"
    headers = {
      'Authorization' => "AuthSub token=#{@credentials["token"]}",
      'GData-Version' => "3" }
    http.get(path, headers)
  end

end
