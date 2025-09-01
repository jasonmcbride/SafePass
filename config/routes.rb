Rails.application.routes.draw do
  devise_for :users, path: 'secure'
  get "pages/about"
  root "pages#home"

  resources :entries
end
