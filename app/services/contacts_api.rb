require 'net/http'
require 'net/https'
require 'uri'
require 'rexml/document'

class ContactsAPI
  PER_PAGE = 20

  def initialize(oauth_credentials)
    @credentials = oauth_credentials
  end

  def contacts(page)
    @contacts ||= parse_response(response(page || 1))
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

  def response(page)
    start_index = (page.to_i - 1) * PER_PAGE + 1
    uri = URI.parse("https://www.google.com")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    path = "/m8/feeds/contacts/default/full?max-results=#{PER_PAGE}&start-index=#{start_index}"
    headers = {
      'Authorization' => "AuthSub token=#{@credentials["token"]}",
      'GData-Version' => "3" }
    http.get(path, headers)
  end

end
