Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 namespace :api, defaults: { format: :json } do
    resources :posts, only: %i[create show] do
      get :avatar, on: :member
    end
  end
end
