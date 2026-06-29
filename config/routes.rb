Rails.application.routes.draw do
  devise_for :users, path: "users"

  devise_scope :user do
    authenticated :user do
      root "dashboard#index", as: :authenticated_root
    end

    unauthenticated :user do
      root "devise/sessions#new", as: :unauthenticated_root
    end
  end

  resources :customers
  resources :reminders do
    member do
      patch :toggle_done
    end
  end
  resource :settings, only: [:show, :update], controller: :settings
  resources :message_templates
end