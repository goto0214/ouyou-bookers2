class BooksController < ApplicationController

  def show
    @index = Book.find(params[:id])
    @user = @index.user
    @book = Book.new
    @book_comment = BookComment.new
  end

  def index
    if params[:sort_create]
      @books = Book.latest
    elsif params[:sort_a]
      @books = Book.star
    else
      @books = Book.all
    end
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
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
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end




  private

  def book_params
    params.require(:book).permit(:title, :body, :evaluation, :category)
  end

end
