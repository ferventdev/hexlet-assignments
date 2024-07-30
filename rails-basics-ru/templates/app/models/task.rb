# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, :status, :creator, presence: true
  validates :name, uniqueness: true
  validates :status,
            inclusion: { in: %w[new in_progress on_review in_testing done], message: '%<value>s is not a valid status' }
  validates :completed, inclusion: { in: [false, true] }
end
