require 'spec_helper'

describe ContactsHelper do

  before do
    helper.stub(:url_for).and_return('/')
  end

  describe "#pagination" do
    context "first page" do
      it "should not show the prev page link" do
        helper.stub(:params).and_return(page: 1)
        helper.pagination([]).should_not =~ /prev/
      end
    end

    context "middle page" do
      it "should show prev and next links" do
        contacts = [1] * ContactsAPI::PER_PAGE
        helper.stub(:params).and_return(page: 2)
        helper.pagination(contacts).should =~ /prev/
        helper.pagination(contacts).should =~ /next/
      end
    end

    context "last page" do
      it "should not show the next link" do
        helper.pagination([]).should_not =~/next/
      end
    end
  end

end
