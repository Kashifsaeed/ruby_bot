Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :chats do
    collection do
      post :learn
    end
  end
end
