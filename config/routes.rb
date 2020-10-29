Rails.application.routes.draw do
	#pages static
	root 'static_pages#index'
	get '/team', to: 'static_pages#team'
  get '/contact', to: 'static_pages#contact'
  #resources REST
  get '/gossip/:id', to: 'gossips#show', as: 'gossip'
  delete '/gossip/:id', to: 'gossips#destroy'
  get '/gossip/:id/edit', to: 'gossips#edit'
	resources :gossips do
  	resources :comments
	end
	resources :users
	resources :cities
	resources :session, only: [:new, :create, :destroy]
	resources :likes, only: [:create, :destroy]
  get '/welcome/:first_name', to: 'users#welcome', as: 'welcome'
  #get 'profile/:user_id', to: 'users#profile', as: 'profile'
end

