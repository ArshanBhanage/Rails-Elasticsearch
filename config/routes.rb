Rails.application.routes.draw do
  resources :books
  get 'search', to: 'search#search'
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "books#index"
end
