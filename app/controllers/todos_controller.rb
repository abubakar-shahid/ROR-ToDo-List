# app/controllers/todos_controller.rb
class TodosController < ApplicationController
  before_action :set_firebase, only: [:index, :create, :update, :destroy]

  def index
    response = @firebase.get("todos")
    if response.success?
      @todos = response.body || {}
    else
      @todos = {}
      Rails.logger.error "Failed to retrieve todos from Firebase: #{response.code} - #{response.body}"
    end
  end

  def create
    Rails.logger.info "in create function"
    todo = { title: params[:title], completed: false }
    response = @firebase.push("todos", todo)
    if response.success?
      redirect_to root_path, notice: "Todo was successfully created."
    else
      redirect_to root_path, alert: "Failed to create todo: #{response.code} - #{response.body}"
    end
  end

  def update
    todo_id = params[:id]
    updated_todo = { title: params[:title], completed: params[:completed] }
    response = @firebase.update("todos/#{todo_id}", updated_todo)
    if response.success?
      redirect_to root_path, notice: "Todo was successfully updated."
    else
      redirect_to root_path, alert: "Failed to update todo: #{response.code} - #{response.body}"
    end
  end

  def destroy
    Rails.logger.info "in destroy function"
    todo_id = params[:id]
    response = @firebase.delete("todos/#{todo_id}")
    if response.success?
      redirect_to root_path, notice: "Todo was successfully deleted."
    else
      redirect_to root_path, alert: "Failed to delete todo: #{response.code} - #{response.body}"
    end
  end

  def render_todo_partial
    @id = params[:id]
    @todo = {
      title: params[:todo][:title],
      completed: params[:todo][:completed] == 'true'
    }
    render partial: 'todo', locals: { id: @id, todo: @todo }
  end

  private

  def set_firebase
    @firebase = $firebase
  end
end










# # app/controllers/todos_controller.rb
# class TodosController < ApplicationController

#   def index
#     response = $firebase.get("todos")
#     @todos = response.body || {}
#   end

#   def create
#     Rails.logger.info "in create function"
#     todo = { title: params[:title], completed: false }
#     response = $firebase.push("todos", todo)
#     redirect_to root_path
#   end

#   def update
#     todo_id = params[:id]
#     updated_todo = { title: params[:title], completed: params[:completed] }
#     response = $firebase.update("todos/#{todo_id}", updated_todo)
#     redirect_to root_path
#   end

#   def destroy
#     Rails.logger.info "in destroy function"
#     todo_id = params[:id]
#     response = $firebase.delete("todos/#{todo_id}")
#     redirect_to root_path
#   end

#   def render_todo_partial
#     @id = params[:id]
#     @todo = params[:todo]
#     render partial: 'todo', locals: { id: @id, todo: @todo }
#   end
  
# end
