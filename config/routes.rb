Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :articles do
        get 'drafts/index'
        get 'drafts/show'
      end
    end
  end
  root "homes#index"

  # reload 対策
  get "sign_up", to: "homes#index"
  get "sign_in", to: "homes#index"
  get "articles/new", to: "homes#index"
  get "articles/:id", to: "homes#index"

  namespace :api, format: "json" do
    namespace :v1 do
      resources :articles
      mount_devise_token_auth_for "User", at: "auth", controllers: {
        registrations: "api/v1/auth/registrations",
      }
    end
  end
end
