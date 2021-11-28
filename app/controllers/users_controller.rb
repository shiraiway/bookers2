class UsersController < ApplicationController

  def index
    @user = current_user.id
    
    @users = User.all
    
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])

    @books = @user.books
    
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), flash: { notice: 'You have updated user successfully.' }
    else
      render action: :edit
    end

  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to books_path, flash: { notice: 'Welcome! You have signed up successfully.' }
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
