Rails.application.routes.draw do
  root :to => 'memos#index'#memosフォルダのindex.html.erbがトップページになる。
  resources :memos, only: [:index, :create, :update, :destroy]
  get 'search', to: 'memos#search', as: 'search' #toでmemosコントローラの中のsearchメソッドを実行する。as: 'search'　＝　/search

  #ユーザーログインに関するルーティング設定
  # resources :sessions, only: [:new, :create, :destroy]
  get 'login', to: 'sessions#new', as: 'login' #ユーザーがログインページにアクセスしたときに、このルートが使用される。
  post 'login', to: 'sessions#create', as: 'create' #ログインに必要な情報を送信する。 
  delete 'logout', to: 'sessions#destroy', as: 'logout' #ログアウト処理を行う。現在のセッションの破棄を行う。
  
  #ユーザー登録,詳細情報に関するルーティング設定
  get 'my-info', to: 'users#index', as: 'myInfo'
  get 'register', to: 'users#new'
  post 'register', to: 'users#create', as: 'registerCreate'
  get 'my-info/edit', to: 'users#edit', as: 'myInfo_edit'
  patch 'my-info/update', to: 'users#update', as: 'myInfo_update'

end
