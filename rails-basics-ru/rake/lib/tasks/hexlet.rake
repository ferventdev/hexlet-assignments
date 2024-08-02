# frozen_string_literal: true

require 'csv'
require 'date'

namespace :hexlet do
  desc "Imports users from the supplied CSV file into the DB table 'users'"
  task :import_users, [:csv_path] => :environment do |_t, args|
    # puts 'Started...'
    CSV.foreach(args[:csv_path]).drop(1).each do |(first_name, last_name, birthday, email)|
      User.create(first_name:, last_name:, birthday: Date.strptime(birthday, '%m/%d/%Y'), email:)
    end
  end
end
