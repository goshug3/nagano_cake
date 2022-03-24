Rails.application.routes.draw do
  namespace :public do
    get 'items/index'
    get 'items/show'
  end
  namespace :public do
    get 'homes/top'
  end
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
