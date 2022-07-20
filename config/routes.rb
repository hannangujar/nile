Rails.application.routes.draw do
  get 'books/index'
  namespace :api do 
    namespace :v1 do 
      resources :books, only: [:index, :create, :destroy]
    end
  end
end
