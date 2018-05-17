Rails.application.routes.draw do

  # 初期画面設定
  root to: 'tasks#index'

  # ログイン情報保持
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  
  # タスク管理用
  resources :tasks
  
  # ユーザ登録用
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]

  #ログイン用  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
end
