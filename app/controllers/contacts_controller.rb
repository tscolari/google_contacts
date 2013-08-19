class ContactsController < ApplicationController
  def index
    @contacts = ContactsAPI.new(session['oauth_credentials']).contacts
  end
end
