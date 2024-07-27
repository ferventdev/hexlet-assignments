# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

10.times do |i|
  Task.create(
    name: "#{i + 1}. #{Faker::Hobby.unique.activity}",
    description: [nil, Faker::Lorem.sentence].sample,
    status: %w[new in_progress on_review in_testing done].sample,
    creator: Faker::GreekPhilosophers.name,
    performer: [nil, Faker::Name.name].sample,
    completed: Faker::Boolean.boolean(true_ratio: 0.2)
  )
end
