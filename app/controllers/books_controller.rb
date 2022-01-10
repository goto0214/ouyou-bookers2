class BooksController < ApplicationController
  impressionist :actions=> [:show]

  def show

    @a = Book.find(params[:id])
    impressionist(@a, nil, unique: [:request_hash])
    @index = @a
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
      to  = Time.current.at_end_of_day
      from  = (to - 6.day).at_beginning_of_day
      @books = Book.includes(:favorited_users).
      sort {|a,b|
        b.favorited_users.includes(:favorites).where(created_at: from...to).size <=>
        a.favorited_users.includes(:favorites).where(created_at: from...to).size
      }
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
