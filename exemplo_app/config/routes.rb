Rails.application.routes.draw do

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  root 'static_pages#home' #metodohome da pagina static 
  get  '/help',    to: 'static_pages#help'# cria duas rota: help_path e uma help_url ('help_path', to:'help_url')
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create' #  ao estar na pagina signup acessa o metodo create da classe users_controller e envia os dados 

  get   '/login',  to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
resources :users  #garante automaticamente que nosso aplicativo Rails responda aos URLs RESTful
resources :account_activations, only: [:edit]  #cria uma unica rota da ação editar
resources :password_resets,     only: [:new, :create, :edit, :update]
end

