Rails.application.routes.draw do

  get 'categories/index'
  get 'categories/edit'
  devise_for :users
  get 'search', to: 'searchs#search'
  get 'search_book' => 'books#search_book'

  resources :users,only: [:show,:index,:edit,:update] do
    resources :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :books,only: [:show,:index,:create,:edit,:update,:destroy] do
    resources :book_comments, only: [:create,:destroy]
    resource :favorites, only: [:create,:destroy]
  end
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
end