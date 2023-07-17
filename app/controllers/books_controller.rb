class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params) #パラメータ取得
    if @book.save #データベースへ反映
      flash[:notice] =  "Book was successfully created."#フラッシュメッセージ
      redirect_to "/books/#{@book.id}" #idを指定してリダイレクト
    else
      @books = Book.all
      flash[:notice] =  "Book was failled created."#フラッシュメッセージ
      flash[:title] = @book.errors.full_messages_for(:title)
      flash[:body] = @book.errors.full_messages_for(:body)
      render :index
    end
  end

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      flash[:notice] =  "Book was successfully updated."
      redirect_to book_path(@book)
    else
      flash[:notice] =  "Book was failled updated."#フラッシュメッセージ
      flash[:title] = @book.errors.full_messages_for(:title)
      flash[:body] = @book.errors.full_messages_for(:body)
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] =  "Book was successfully destroyed."
    redirect_to action: :index
  end

  private
  #ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
