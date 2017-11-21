Rails.application.routes.draw do
  resources :rooms
  resources :roomtypes
  resources :notes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'welcome' => 'demo#ggwp'
  get 'messages' => 'messages#index'
end
