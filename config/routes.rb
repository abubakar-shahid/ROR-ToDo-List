# config/routes.rb
Rails.application.routes.draw do
  root 'todos#index'
  resources :todos, only: [:index, :create, :update, :destroy]
  get 'todos/render_todo_partial', to: 'todos#render_todo_partial'
  post 'todos/save_from_firebase', to: 'todos#save_from_firebase'
end
