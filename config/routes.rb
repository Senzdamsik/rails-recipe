Rails.application.routes.draw do
  root "pages#home"
  get 'pages/home', to: 'pages#home'
  
  resources :recipes do   # Ini adalah nested route
    resources :comments, only: [:create]
  end
  
  get '/signup', to: 'chefs#new'
  resources :chefs, except: [:new]

  get '/login', to: 'sessions#new'
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  resources :ingredients, except: [:destroy]

end

# Jadi ada 3 tingkatan user di sini:

  # 1. User yg belum login
  # 2. User yg sudah login (hanya bisa mengedit punyanya)
  # 3. User yg sudah login sekaligus Admin (Bisa mengedit punya siapapun)


# Yang bisa menghapus user hanya admin. User yg terdaftar tidak bisa menghapus dirinya sendiri.