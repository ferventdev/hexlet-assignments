# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

10.times do |i|
  Post.create(
    title: "#{i + 1}. #{Faker::Hobby.unique.activity}",
    body: Faker::Lorem.paragraphs.join("\n\n"),
    summary: Faker::Lorem.sentence,
    published: Faker::Boolean.boolean(true_ratio: 0.2)
  )
end
