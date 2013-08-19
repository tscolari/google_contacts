require 'spec_helper'

describe ContactsController do
  render_views
  before(:each) do
    sign_in FactoryGirl.create(:user)
  end

  let(:contacts) { 3.times.map { OpenStruct.new(name: '1', email: '2') } }

  describe "get INDEX" do
    it "returns http success" do
      ContactsAPI.stub_chain(:new, :contacts).and_return(contacts)
      get :index
      response.should be_success
    end
  end

end
