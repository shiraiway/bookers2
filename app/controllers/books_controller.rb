class BooksController < ApplicationController

  def index
    @books = Book.all

    @book = Book.new

    @user = current_user
  end

  def create
    @user = current_user
    # binding.pry
    @book = Book.new(book_params)

    @book.user_id = current_user.id

    if @book.save
      redirect_to book_path(@book.id), flash: { notice: 'You have created book successfully' }
    else
      @books = Book.all
      render :index
    end

  end

  def show
    @book = Book.find(params[:id])

    @user = User.find(@book.user_id)

    @book_new = Book.new
  end

  def edit
    @user = current_user

    @book = Book.find(params[:id])

    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to book_path(@book.id), flash: { notice: 'You have updated book successfully.' }
    else
      render action: :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])

    @book.destroy

    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

end