Rails.application.routes.draw do
  resources :items, only: [:index, :show, :create]

  resources :users, only: [:show, :index, :create] do
    resources :items, only: [:index, :create, :show]
  end
end
