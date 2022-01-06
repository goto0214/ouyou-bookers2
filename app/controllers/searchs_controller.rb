class SearchsController < ApplicationController

def search
  @range = params[:range]
  keyword = params[:keyword]

  if @range == '1'
    @user = User.search(@range, keyword)
  elsif @range == '2'
    @book = Book.search(@range, keyword)
  elsif @range == '3'
    @book = Book.search(@range, keyword)
  else
    redirect_back(fallback_location: root_path)
  end
end


end
