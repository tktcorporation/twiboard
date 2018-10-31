Rails.application.routes.draw do
  get '/', to: "home#top"
  get '/search', to: "home#search"
  get '/advanced_search', to: "board#advanced_search"
  get 'auth/:provider/callback' => 'users#create'
  post 'auth/:provider/callback' => 'users#create'
  get "board/search"
  get '/login', to: "users#login"
  get 'users/logout'
  get 'board/trend'
  get 'board/participating'
  post 'board/new'
  get "/board/:id", to: 'board#board'
  post "board/:id/create", to: 'board#create'
  get "/board/9", to: 'board#testboard'
  post "board/9/testcreate", to: 'board#testcreate'

end
