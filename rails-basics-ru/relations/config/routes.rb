# frozen_string_literal: true

Rails.application.routes.draw do
  root 'tasks#index'
  resources :users
  resources :statuses
  resources :tasks
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
