class SearchController < ApplicationController
    def search
        @results = Book.search(where: { title: params[:search] })
        
        @results = Book.search('*') if params[:search].blank?
        
        render turbo_stream:
            turbo_stream.update('books', partial: 'books/books', locals: {books: @results})
        
    end
end