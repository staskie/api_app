require 'spec_helper'

describe Api::UsersController, :type => :controller do
  include Api
  render_views

  before :each do
    @user = FactoryGirl.create(:user)
  end

  describe "GET /api/users" do
    it "returns json format" do
      get 'index', :format => :json
      response.header['Content-Type'].should include 'application/json'
    end

    it "returns all users" do
      get 'index', :format => :json
      json_response_body.length == User.all.count
    end

    it "shows required fields" do
      get 'index', :format => :json
      json_response_body.first.should include("first_name", "second_name", "hobby")
    end

    it "doesn't show fields that are not required" do
      get 'index', :format => :json
      json_response_body.first.should_not include("created_at", "updated_at")
    end
  end

  context "when uuid and token are provided" do
    let(:credentials) { FactoryGirl.attributes_for :credential }
    let(:_params) { credentials.merge(:format => :json) }

    before :each do
      FactoryGirl.create(:credential)
    end

    describe "POST /api/users" do
      it "creates a new user" do
        expect {
          post 'create', _params.merge(:user => FactoryGirl.attributes_for(:user))
        }.to change(User, :count).by(1)
      end

      it "doesn't create error when user is not valid" do
        expect {
          post 'create', _params.merge(:user => FactoryGirl.attributes_for(:invalid_user))
        }.to_not change(User, :count)
      end
    end

    describe "GET /api/users/:id" do
      it "shows user" do
        get 'show', _params.merge(:id => @user)
        json_response_body.should include("first_name" => @user.first_name)
      end
    end

    describe "PUT /api/users/:id" do
      it "updates user" do
        put 'update', _params.merge(:id => @user, :user => {first_name: "Kate"})
        json_response_body.should include("first_name" => "Kate")
      end
    end

    describe "DELETE /api/users/:id" do
      it "deletes user" do
        delete 'destroy', _params.merge(:id => @user)
        json_response_body.should == {"message" => "Record removed"}
      end
    end
  end

  context "when uuid and token are not provided" do
    let(:access_denied) { {"error"=>"Access denied"} }

    describe "POST /api/users" do
      it "returns access denied" do
        post 'create', :foramt => :json
        json_response_body.should == access_denied
      end
    end

    describe "GET /api/users/:id" do
      it "returns access denied" do
        get 'show', :id => 1, :format => :json
        json_response_body.should == access_denied
      end
    end

    describe "PUT /api/users/:id" do
      it "returns access denied" do
        put 'update', :id => 1, :first_name => "Andrew", :format => :json
        json_response_body.should == access_denied
      end
    end

    describe "DELETE /api/users/:id" do
      it "returns access denied" do
        delete 'destroy', :id => 1
        json_response_body.should == access_denied
      end
    end
  end
end

