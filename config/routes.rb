Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users,
    path: "auth",
    path_names: { sign_in: "login", sign_out: "logout", registration: "signup" },
    controllers: { sessions: "users/sessions", registrations: "users/registrations" }

  namespace :api do
    resources :users, only: [ :index, :show, :update ]
    resources :conversations, only: [ :index, :create ] do
      resources :messages, only: [ :index, :create ]
    end
    get "me", to: "users#me"
  end
end
