Rails.application.routes.draw do
  root "pages#home"
  get 'pages/home' => 'pages#home'

  resources :recipes do
    resources :comments, only: [:create]
  end

  get '/signup', to: 'chefs#new'
  resources :chefs, except: [:new]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :ingredients, execept: [:destroy]
end
