Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  post 'users/:id/request', to: 'users#request_friend'
  post 'users/:id/accept', to: 'users#accept_friend'
  post 'users/:id/decline', to: 'users#decline_friend'

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
