class UsersController < ApplicationController
  def welcome
    @user = User.find_by(first_name: params[:first_name])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @cities = City.all
    @user = User.new
  end

  def create
    @cities = City.all
    @city = City.find_by(name: params[:city][0])
    @user = User.new(first_name: params[:first_name], last_name: params[:last_name], description: params[:description], age: params[:age], email: params[:email], password: params[:password], city: @city)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'Welcome Aboard'
      redirect_to root_path
    else
      flash.now[:danger] = 'Tu veux vraiment faire partie de la familia ?'
      render 'new'
    end
  end
end
