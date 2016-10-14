Rails.application.routes.draw do

  get 'rides/new'

  root 'static#home'

  get '/signin' => 'sessions#new'
  post 'sessions/create'
  delete '/signout' => 'sessions#destroy'

  post '/rides/new' => 'rides#new'

  resources :users
  resources :attractions

end