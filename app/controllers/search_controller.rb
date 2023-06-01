class SearchController < ApplicationController
    def search
        
        @results = Book.search(params[:search], page: params[:page], per_page: 5, aggs: {ratings:{}, author:{}, year:{}})
        
        @ratings_aggregations = @results.aggs['ratings']
        @author_aggregations = @results.aggs['author']
        @year_aggregations = @results.aggs['year']
        
        @results = Book.search('*', page: params[:page], per_page: 5) if params[:search].blank?
        
        if params[:sort_by] == 'price_high_to_low'
            @results = @results.order(price: :desc)
            #@results = @results.where(year: params[:sort_by]).order(price: :desc) if params[:sort_by_year].blank?
        elsif params[:sort_by] == 'price_low_to_high'
            @results = @results.order(price: :asc)
        elsif params[:sort_by_year].present?
            @results = @results.where(year: params[:sort_by_year])
        end
        
        render turbo_stream:
            turbo_stream.update('books', partial: 'books/books', locals: { books: @results })
        
    end
end