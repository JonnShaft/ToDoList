require 'rails_helper'

RSpec.describe TasksController, type: :controller do
	describe "tasks#index" do
		it "should list the tasks in the database" do
			task1 = FactoryGirl.create(:task)	#Create items in DB.
			task2 = FactoryGirl.create(:task)
			get :index	#Trigger the index action.
			expect(response).to have_http_status :success  #HTTP request should be successful.
			response_value = ActiveSupport::JSON.decode(@response.body)	#Access the actual response from the app.
			expect(response_value.count).to eq(2)	#Text in JSON should be produced.
		end
	end

	describe "tasks#update" do
		it "should allow tasks to be marked as done" do
			task = FactoryGirl.create(:task, done: false)	#Create item in DB.
			put :update, id: task.id, task: { done: true } #PUT request should trigger update, done value should be updated to "true" to toggle item's completion status.
			expect(response).to have_http_status(:success) #HTTP request should produce a successful response.
			task.reload #Reload task from DB.
			expect(task.done).to eq(true) #Attribute for "done" should be changed from false to true.
		end
	end
end
