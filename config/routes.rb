Rails.application.routes.draw do
  
  namespace :public do
    get 'orders/new'
    get 'orders/index'
    get 'orders/show'
  end
  root to: "public/homes#top"
  
  # 顧客
  namespace :public do
    
    get "/about" => "homes#about", as: "about"
    
    resource :customers, only: [:show, :edit, :update] do
      collection do
        get "unsubscribe"
        patch "withdraw"
      end
    end
    
    resources :cart_items, only: [:index, :create, :update, :destroy]
    delete 'cart_items/destroy_all'
    
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post "confirm"
        get "complete"
      end
    end
    
    
  end
  
  # 管理者
  namespace :admin do
    root 'homes#top'
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
