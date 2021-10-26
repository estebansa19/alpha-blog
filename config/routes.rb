Rails.application.routes.draw do
  root 'pages#home'

  get 'about', to: 'pages#about'
  resources :articles
  resources :users, except: [:new]
  get 'sign_up', to: 'users#new'
end
