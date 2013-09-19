FactoryGirl.define do
  factory :user do
    first_name  Faker::Name.first_name
    second_name Faker::Name.last_name
    hobby       "Testing"
  end

  factory :invalid_user, :class => User do
    first_name "Michael"
  end
end
