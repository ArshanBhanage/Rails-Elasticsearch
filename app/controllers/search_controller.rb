class SearchController < ApplicationController
    def search
        
        args ={}
        args[:ratings] = params[:ratings] if params[:ratings].present?
        args[:author] = params[:author] if params[:author].present?
        args[:year] = params[:year] if params[:year].present?
        args[:genre] = params[:genre] if params[:genre].present?
        #price_ranges = [{to: 200}, {from: 200, to: 400}, {from: 400, to: 600}, {from: 600}]
        price_ranges = [{from: 0, to: 20}, {from: 20, to: 50}, {from: 50}]
        
        @results = Book.search(params[:search], page: params[:page], per_page: 5, where: args, aggs: {price: {ranges: price_ranges}, ratings:{}, author:{}, year:{}, genre:{}})
        
        @ratings_aggregations = @results.aggs['ratings']
        @author_aggregations = @results.aggs['author']
        @year_aggregations = @results.aggs['year']
        @genre_aggregations = @results.aggs['genre']
        @price_aggregations = @results.aggs['price']
        
        @results = Book.search('*', page: params[:page], per_page: 5) if params[:search].blank?
        
        if params[:sort_by] == 'price_high_to_low'
            @results = @results.order(price: :desc)
            #@results = @results.where(year: params[:sort_by]).order(price: :desc) if params[:sort_by_year].blank?
        elsif params[:sort_by] == 'price_low_to_high'
            @results = @results.order(price: :asc)
        elsif params[:sort_by_year].present?
            @results = @results.where(year: params[:sort_by_year])
        elsif params[:selected_genre].present?
            @results = @results.where(genre: params[:selected_genre])
        end
        
        render turbo_stream:
            turbo_stream.update('books', partial: 'books/books', locals: { books: @results })
        
    end
end