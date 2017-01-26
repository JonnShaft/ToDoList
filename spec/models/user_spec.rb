require 'rails_helper'

RSpec.describe User, type: :model do
  it "user is valid" do
    user1 = FactoryGirl.create(:user)
    expect(user1).to be_valid
  end
  
  it "user's name should be present" do
    user1 = FactoryGirl.create(:user)
    user1.name = "Ahmad"
    expect(user1).to be_valid
  end
  
  it "user's email should be present" do
    user1 = FactoryGirl.create(:user)
    user1.email = "akj824"
    expect(user1).to be_valid
  end
  
  it "user's name should not be too long" do
    user1 = FactoryGirl.create(:user)
    user1.name = "a" * 25
    expect(user1).tonot be_valid
    
  end
  
end
