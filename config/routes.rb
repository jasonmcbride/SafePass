Rails.application.routes.draw do
  devise_for :users, path: 'secure'
  get "pages/about"
  root "entries#index"

  resources :entries
end
