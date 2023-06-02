class SearchController < ApplicationController
    def search
        
        args ={}
        args[:ratings] = params[:ratings] if params[:ratings].present?
        args[:author] = params[:author] if params[:author].present?
        args[:year] = params[:year] if params[:year].present?
        args[:genre] = params[:genre] if params[:genre].present?
        
        @results = Book.search('*', page: params[:page], per_page: 5, where: args, aggs: {ratings:{}, author:{}, year:{}, genre:{}}) if params[:search].blank?
        @results = Book.search(params[:search], page: params[:page], per_page: 5, where: args, aggs: {ratings:{}, author:{}, year:{}, genre:{}})
        
        @ratings_aggregations = @results.aggs['ratings']
        @author_aggregations = @results.aggs['author']
        @year_aggregations = @results.aggs['year']
        @genre_aggregations = @results.aggs['genre']
        
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