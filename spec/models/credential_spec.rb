require 'spec_helper'

describe Credential do
  subject { Credential }

  describe ".authenticated?" do
    before :each do
      FactoryGirl.create(:credential, uuid: "u1-0001", secret_token: "t1-0001")
    end

    context "uuid and secret_token are correct" do
      it "authenticates request if uuid and secret_token is provided" do
        Credential.authenticated?("u1-0001", "t1-0001").should be_true
      end
    end

    context "uuid or secret_token are invalid" do
      it "does NOT authenticate request if uuid is invalid" do
        Credential.authenticated?("invalid-0001", "t1-0001").should be_false
      end
      it "does NOT authenticate request if secret_token is invalid" do
        Credential.authenticated?("u1-0001", "invalid-0001").should be_false
      end

      it "does NOT authenticate reqeust if uuid and secret_token is missing" do
        Credential.authenticated?(nil, nil).should be_false
      end
    end
  end
end
