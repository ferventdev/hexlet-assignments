# frozen_string_literal: true

class AddStatusRefToTasks < ActiveRecord::Migration[7.1]
  def change
    add_reference :tasks, :status, null: false, foreign_key: true
  end
end
