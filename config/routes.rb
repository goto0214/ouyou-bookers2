Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books,only: [:show,:index,:create,:edit,:update,:destroy] do
    resource :favorites, only: [:create,:destroy]
  end
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
end