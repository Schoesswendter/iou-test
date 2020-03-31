# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  resources :money_transactions
  resources :users
  get 'static/help'
  get 'static/privacy'
  root to: 'static#home'

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy]
    end
  end

end
