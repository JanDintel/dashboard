Dashboard::Application.routes.draw do

  resource :message,   only:  [:create]
  resources :messages, only:  [:index] do
    collection { get :events }
  end

  get '/dashboard', to: 'dashboard#index'

  root 'dashboard#index'
end
