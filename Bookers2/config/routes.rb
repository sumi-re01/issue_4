Rails.application.routes.draw do
   root to: "homes#top"
   get 'home/about' => "homes#about"

   devise_for :users

   resources :users, only: [:show, :index, :update, :edit] do
      member do
         get :following, :followers
      end
   end

   resources :relationships, only: [:create, :destroy]

   resources :books, only: [:show, :index, :create, :edit, :update, :destroy]
   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

   # resources :users do
   #    member do
   #       get :following, :followers
   #    end
   # end

 end