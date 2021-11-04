Rails.application.routes.draw do
  root 'pages#home'

  get 'about', to: 'pages#about'
  resources :articles
  resources :users, except: [:new]
  get 'sign_up', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
