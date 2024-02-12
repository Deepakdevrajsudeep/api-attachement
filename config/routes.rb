Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 get '/favicon.ico', to: proc {[204]}
  namespace :api, defaults: { format: :json } do
    resources :attachments, only: [:index, :show]
    resources :posts, only: [:index, :show, :create, :update, :destroy] do
      member do
        get :avatar
        get :avatar_thumbnail
      end
    end
  end
end 
