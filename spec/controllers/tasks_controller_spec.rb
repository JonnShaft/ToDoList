require 'rails_helper'

RSpec.describe TasksController, type: :controller do
	describe "tasks#index" do
		it "should list the tasks in the database" do
			task1 = FactoryGirl.create(:task)	#Create items in DB.
			task2 = FactoryGirl.create(:task)
			task1.update_attributes(title: "Something else")	#Update first task after the second is built in.
			get :index	#Trigger the index action.
			expect(response).to have_http_status :success  #HTTP request should be successful.
			response_value = ActiveSupport::JSON.decode(@response.body)	#Access the actual response from the app.
			expect(response_value.count).to eq(2)	#Text in JSON should be produced.
			response_ids = response_value.collect do |task|	#Loop through each item and extract the id.
				task["id"]
			end
			expect(response_ids).to eq([task1.id, task2.id])	#Items should be returned in the order that they were created.
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

	describe "task#create" do
		it "should allow new tasks to be created" do
			post :create, task: {title: "Fix things"}	#POST request on the create action.
			expect(response).to have_http_status(:success)	#POST request is expected to be successful.
			response_value = ActiveSupport::JSON.decode(@response.body)	#Response shold be parsed as JSON and ensure the title has been populated.
			expect(response_value['title']).to eq("Fix things")
			expect(Task.last.title).to eq("Fix things")	#Last item should be stored in the DB.
		end
	end
end
