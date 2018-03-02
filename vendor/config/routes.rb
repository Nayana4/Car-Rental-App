Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :reservations
  resources :cars
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "cars#index"
end
