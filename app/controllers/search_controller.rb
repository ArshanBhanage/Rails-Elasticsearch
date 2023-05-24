class SearchController < ApplicationController
    def search
        @results = Book.search(params[:search], page: params[:page], per_page: 5)
        
        @results = Book.search('*') if params[:search].blank?
        
        render turbo_stream:
            turbo_stream.update('books', partial: 'books/books', locals: {books: @results})
        
    end
end