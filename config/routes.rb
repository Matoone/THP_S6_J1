Rails.application.routes.draw do
  
  
  devise_for :users
  
  resources :events, only: [:index, :new, :show, :create, :edit, :update, :destroy] do
    resources :attendances, only: [:index, :new, :create]
    resources :event_images, only: [:create]
  end
  root to: 'events#index'
  resources :users, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
