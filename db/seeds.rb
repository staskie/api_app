# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(:first_name => Faker::Name.first_name, :second_name =>  Faker::Name.last_name, :hobby => "board sports")
User.create!(:first_name => Faker::Name.first_name, :second_name =>  Faker::Name.last_name, :hobby => "gardening")
User.create!(:first_name => Faker::Name.first_name, :second_name =>  Faker::Name.last_name, :hobby => "golf")
User.create!(:first_name => Faker::Name.first_name, :second_name =>  Faker::Name.last_name, :hobby => "skiing")

Credential.create!(:uuid => "550e8400-e29b-41d4-a716-446655440000", :secret_token => "9e925e9341b490bfd3b4c4ca3b0c1ef2")
Credential.create!(:uuid => "320e8110-f29b-41d4-b716-188912839123", :secret_token => "21582c6c30be1217322cdb9aebaf4a59")

puts "\nUse following uuid and secret tokens to get the access to restricted area\n\n"

Credential.all.each do |auth|
  puts "uuid: #{auth.uuid}\tsecret_token: #{auth.secret_token}"
end
