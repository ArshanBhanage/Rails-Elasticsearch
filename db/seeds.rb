# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

1000.times do
  Book.create(
    title: Faker::Book.title,
    price: Faker::Commerce.price(range: 100.0..10000.0),
    description: Faker::Lorem.paragraph,
    author: Faker::Book.author,
    year: Faker::Number.between(from: 1990, to: 2023),
    ratings: Faker::Number.between(from: 1, to: 5),
    genre: Faker::Book.genre
  )
end
