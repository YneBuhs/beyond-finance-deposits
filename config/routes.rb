Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :tradelines, only: [:index, :show] do
    resources :deposits, only: [:index, :create, :show]
  end
end