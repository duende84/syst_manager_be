Rails.application.routes.draw do

  root 'home#index'

  mount API::Base, at: "/api"

  use_doorkeeper

  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
