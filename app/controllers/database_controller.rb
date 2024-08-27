class DatabaseController < ApplicationController
  # protect_from_forgery except: :save_from_firebase  # Skip CSRF for this action if necessary

  # def save_from_firebase
  #   todo = Todo.find_or_initialize_by(firebase_id: params[:firebase_id])
  #   todo.title = params[:title]
  #   todo.completed = params[:completed]
  #   if todo.save
  #     render json: { status: 'success', todo: todo }
  #   else
  #     render json: { status: 'error', errors: todo.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end
end
