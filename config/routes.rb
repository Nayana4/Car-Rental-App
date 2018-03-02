Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount RailsAdmin::Engine => '/superadmin', as: 'rails_superadmin'
  get 'home/index'

  resources :cars
  resources :reservations
  resources :superadmins
  resources :admins
  root 'home#index'
  devise_for :users, controllers: {registrations: "registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root "cars#index"
end
