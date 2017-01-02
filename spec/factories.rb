FactoryGirl.define do
  factory :user do
    name "MyString"
    email "MyString"
  end
	factory :task do
		title "Change lawnmower oil"
		done false
	end
end