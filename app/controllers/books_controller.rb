class BooksController < ApplicationController
  def index
    @books = Book.all
    @new_book = Book.new
  end

  def create
    @new_book = Book.new(book_params)
    if @new_book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@new_book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
    @update_book = Book.new
  end

  def update
    @update_book = Book.find(params[:id])
    if @update_book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@update_book.id)
    else
      @book = Book.find(params[:id])
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


   private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
