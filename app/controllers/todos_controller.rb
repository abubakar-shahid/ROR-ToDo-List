# app/controllers/todos_controller.rb
class TodosController < ApplicationController
  def index
    response = $firebase.get("todos")
    @todos = response.body || {}
  end

  def create
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
    todo_id = params[:id]
    response = $firebase.delete("todos/#{todo_id}")
    redirect_to root_path
  end
end
