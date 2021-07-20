Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root   'packages#home'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users, only: [:create,:edit,:new,:update]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :packages, only: [:new,:create]
  get "packages/:tracker_id/package_updates/new", to: "package_updates#new"
  post "packages/:tracker_id/package_updates", to: "package_updates#create"
  put "packages/:tracker_id", to: "packages#update"
  get "packages/search", to: "packages#search"
  get "packages/:tracker_id/edit", to: "packages#edit"
  get '*path', to: 'packages#home'
end
