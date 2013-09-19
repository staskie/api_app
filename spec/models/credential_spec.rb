require 'spec_helper'

describe Credential do
  subject { Credential }

  describe ".authenticated?" do
    before :each do
      FactoryGirl.create(:credential, uuid: "u1-0001", secret_token: "t1-0001")
    end

    context "when uuid and secret_token are correct" do
      it "authenticates the request" do
        Credential.authenticated?("u1-0001", "t1-0001").should be_true
      end
    end

    context "when uuid or secret_token are invalid" do
      it "does NOT authenticate request for invalid uuid" do
        Credential.authenticated?("invalid-0001", "t1-0001").should be_false
      end
      it "does NOT authenticate request for invalid secret token" do
        Credential.authenticated?("u1-0001", "invalid-0001").should be_false
      end

      it "does NOT authenticate reqeust for missing uuid and secret token" do
        Credential.authenticated?(nil, nil).should be_false
      end
    end
  end
end
