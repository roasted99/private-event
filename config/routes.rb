Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root "events#index"
  
  resources :events do
    member do
      get 'attend'
      get 'unattend'
    end
  end

  get '/user/:id', to: 'users#show', as: :user
  resources :users, only: :show

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
