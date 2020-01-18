Rails.application.routes.draw do
  get 'homes/index'
  root "homes#index"
  
  namespace :api, format: "json" do
    namespace :v1 do
      resources :articles
      mount_devise_token_auth_for "User", at: "auth"
    end
  end
end
