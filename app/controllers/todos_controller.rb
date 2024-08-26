# app/controllers/todos_controller.rb
class TodosController < ApplicationController

  def index
    response = $firebase.get("todos")
    @todos = response.body || {}
  end

  def create
    Rails.logger.info "in create function"
    todo = { title: params[:title], completed: false }
    response = $firebase.push("todos", todo)
    redirect_to root_path
  end

  def update
    todo_id = params[:id]
    updated_todo = { title: params[:title], completed: params[:completed] }
    response = $firebase.update("todos/#{todo_id}", updated_todo)
    redirect_to root_path
  end

  def destroy
    Rails.logger.info "in destroy function"
    todo_id = params[:id]
    response = $firebase.delete("todos/#{todo_id}")
    redirect_to root_path
  end

  def render_todo_partial
    @id = params[:id]
    @todo = params[:todo]
    render partial: 'todo', locals: { id: @id, todo: @todo }
  end
  
end











# class TodosController < ApplicationController
#   def index
#     response = $firebase.get("todos")
#     @todos = response.body || {}
#   end

#   def create
#     Rails.logger.info "in create function"
#     todo = { title: params[:title], completed: false }
#     response = $firebase.push("todos", todo)

#     render partial: 'todo', locals: { id: response.body['name'], todo: todo }
#   end

#   def update
#     todo_id = params[:id]
#     updated_todo = { title: params[:title], completed: params[:completed] }
#     response = $firebase.update("todos/#{todo_id}", updated_todo)

#     render partial: 'todo', locals: { id: todo_id, todo: updated_todo }
#   end

#   def destroy
#     Rails.logger.info "in destroy function"
#     todo_id = params[:id]
#     response = $firebase.delete("todos/#{todo_id}")

#     render js: "$('#todo-#{todo_id}').remove();"
#   end

#   def render_todo_partial
#     @id = params[:id]
#     @todo = params[:todo]
#     render partial: 'todo', locals: { id: @id, todo: @todo }
#   end
# end









# class TodosController < ApplicationController

#   def index
#     response = $firebase.get("todos")
#     @todos = response.body || {}
#   end

#   def create
#     Rails.logger.info "in create function"
#     todo = { title: params[:title], completed: false }
#     response = $firebase.push("todos", todo)

#     respond_to do |format|
#       format.html { redirect_to root_path }
#       format.js   { render partial: 'todo', locals: { id: response.body['name'], todo: todo } }
#     end
#   end

#   def update
#     todo_id = params[:id]
#     updated_todo = { title: params[:title], completed: params[:completed] }
#     response = $firebase.update("todos/#{todo_id}", updated_todo)

#     respond_to do |format|
#       format.html { redirect_to root_path }
#       format.js   { render partial: 'todo', locals: { id: todo_id, todo: updated_todo } }
#     end
#   end

#   def destroy
#     Rails.logger.info "in destroy function"
#     todo_id = params[:id]
#     response = $firebase.delete("todos/#{todo_id}")

#     respond_to do |format|
#       format.html { redirect_to root_path }
#       format.js   { render js: "$('#todo-#{todo_id}').remove();" }
#     end
#   end

#     def render_todo_partial
#     @id = params[:id]
#     @todo = params[:todo]
#     render partial: 'todo', locals: { id: @id, todo: @todo }
#   end

# end