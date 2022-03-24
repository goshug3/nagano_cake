Rails.application.routes.draw do
  
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
    
    
  end
  
  # 管理者
  namespace :admin do
    root 'homes#top'
    resources :genres, except: [:new, :show, :destroy]
    resources :items, except: [:destroy]
    resources :customers, except: [:new, :create, :destroy]
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
