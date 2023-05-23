json.extract! book, :id, :title, :price, :description, :author, :year, :ratings, :created_at, :updated_at
json.url book_url(book, format: :json)
