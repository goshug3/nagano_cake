Rails.application.routes.draw do
  
  root to: "public/homes#top"
  
  # 顧客
  namespace :public do
    
    get "/about" => "homes#about", as: "about"
    
    resources :items, only: [:index, :show]
    
    get '/customers/unsubscribe' => "customers#unsubscribe", as: "unsubscribe"
    patch '/customers/withdraw' => "customers#withdraw", as: "withdraw"
    resources :customers, only: [:show, :edit, :update]
    
    delete 'cart_items/destroy_all'
    resources :cart_items, only: [:index, :create, :update, :destroy]
    
    
    get '/orders/complete'
    post '/orders/confirm'
    resources :orders, only: [:new, :create, :index, :show]
    
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
  
  # 管理者
  namespace :admin do
    get '/' => "homes#top"
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show]
  end

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
