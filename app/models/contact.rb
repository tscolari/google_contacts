class Contact
  attr_reader :name, :email, :phone

  def initialize(contact_element)
    parse_element(contact_element)
  end

  private

  def parse_element(element)
    @name = element.elements['title'].text
    gd_email = element.elements['gd:email']
    @email = gd_email.attributes['address'] if gd_email
  end

end
