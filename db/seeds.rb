# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"
case Rails.env
when "development"
  User.destroy_all
Event.destroy_all
Attendance.destroy_all

user = User.create!(first_name: "Matthieu", last_name: "Degré", email: "matthieu.degre@gmail.com", description: "Hello guys how are you? I am from lyon and I am very happy to see you there!")
event = Event.create!(start_date: Time.now + rand(1..12).month, duration: 60, description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), title: Faker::Lorem.sentence(word_count: 3), price: 35, location: "Bordeaux", admin: user)
10.times do
  new_users = User.create!(first_name: Faker::Name.first_name , last_name: Faker::Name.last_name, email: Faker::Name.first_name + "@yopmail.com", description: Faker::Lorem.paragraph)
end
10.times do
  new_event = Event.create!(start_date: Time.now + 1.month, duration: 60, description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), title: Faker::Lorem.sentence(word_count: 3), price: Faker::Number.between(from: 1, to: 800), location: Faker::Address.city, admin: User.all.sample)
end
30.times do
  new_attendance = Attendance.create!(event: Event.all.sample, attendee: User.all.sample)
end


when "production"
  user = User.create!(first_name: "Matthieu", last_name: "Degré", email: "matthieu.degre@gmail.com", description: "Hello guys how are you? I am from lyon and I am very happy to see you there!")
  user2 = User.create!(first_name: "Charlie", last_name: "Carpene", email: "charlie.carpene@gmail.com", description: "Hello guys how are you? I am from lyon and I am very happy to see you there!")
  new_event = Event.create!(start_date: Time.now + 1.month, duration: 60, description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), title: Faker::Lorem.sentence(word_count: 3), price: Faker::Number.between(from: 1, to: 800), location: Faker::Address.city, admin: User.all.sample)
  new_attendance = Attendance.create!(event: Event.all.sample, attendee: User.all.sample)
else
  
end

