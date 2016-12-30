class TasksController < ApplicationController
	
	before_action :require_user, only: [:index, :show]
	helper_method :current_user
	
	
	def index
		render json: Task.order(:id)
	end
	
	def update
		task = Task.find(params[:id])	#Load the correct item from the DB.
		task.update_attributes(task_params)	#Values should be updated with the values passed through the HTTP request.
		render json: task #Response should be the JSON representation of the item updated.
	end
	
	def create
		task = Task.create(task_params)
		render json: task
	end
	
	private
	
	def task_params
		params.require(:task).permit(:done, :title)
	end
end
