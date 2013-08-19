require 'spec_helper'

describe UserAuthentication do
  let(:session) { Hash.new }
  let(:controller) do
    double.tap do |controller|
      controller.stub(:session).and_return(session)
    end
  end
  subject { UserAuthentication.new(controller) }

  context "User already exists in database" do
    let(:user) { FactoryGirl.create(:user) }

    it "should fetch the existing user" do
      response = OpenStruct.new(:info => { "email" => user.email })
      expect {
        subject.authenticate(response).should eq user
      }.to_not change { User.count }
    end

  end

  context "User doesn't exists in database" do
    it "should create a new user" do
      response = OpenStruct.new(info: { "email" => Faker::Internet.email })
      expect {
        user = subject.authenticate(response)
        user.email.should eq response.info["email"]
      }.to change { User.count }.by(1)
    end
  end

  context "session credentials" do
    it "should store in the oauth credentials in session" do
      response = OpenStruct.new(
        info: {
          "email" => Faker::Internet.email
        },
        credentials: "anything")
      subject.authenticate(response)
      session["oauth_credentials"].should eq response.credentials
    end
  end

end
