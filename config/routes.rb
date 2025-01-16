Rails.application.routes.draw do  
   devise_for :users
   resources :items, only: [:new, :create]

   root to: 'items#index'
end
