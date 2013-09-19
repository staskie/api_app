class Api::UsersController < ApplicationController
  before_filter :authenticate, :except => [:index]

  def index
    @users = User.all
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      render 'show'
    else
      render :json => {:errors => @user.errors}
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      render 'show'
    else
      render :json => {:errors => @user.errors}
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    render :json => {:message => "Record removed"}
  end


  def authenticate
    if !Credential.authenticated?(params[:uuid], params[:secret_token])
      render :json => {:error => "Access denied"}
    end
  end
end
