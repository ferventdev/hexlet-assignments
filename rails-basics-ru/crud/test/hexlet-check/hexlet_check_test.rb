# frozen_string_literal: true

require 'test_helper'
require_relative '../controllers/tasks_controller_test'

class HexletCheckTest < ActionDispatch::IntegrationTest
  test 'TasksControllerTest exists and has methods' do
    assert defined? TasksControllerTest
    test_methods = TasksControllerTest.new({}).methods.select { |method| method.start_with? 'test_' }
    assert_not_empty test_methods
  end

  setup do
    @task = tasks(:one)
    @attrs = {
      name: Faker::Artist.name,
      description: Faker::Movies::HarryPotter.quote,
      status: %w[new in_progress on_review in_testing done].sample,
      creator: Faker::Movies::HarryPotter.character,
      performer: Faker::Movies::HarryPotter.character,
      completed: Faker::Boolean.boolean
    }
  end

  test 'should get index' do
    get tasks_url
    assert_response :success
  end

  test 'should get new' do
    get new_task_url
    assert_response :success
  end

  test 'should create task' do
    post tasks_url, params: { task: @attrs }

    task = Task.find_by! name: @attrs[:name]

    assert_redirected_to task_url(task)
  end

  test 'should show task' do
    get task_url(@task)
    assert_response :success
  end

  test 'should get edit' do
    get edit_task_url(@task)
    assert_response :success
  end

  test 'should update task' do
    patch task_url(@task), params: { task: @attrs }
    assert_redirected_to task_url(@task)

    @task.reload

    assert { @task.name == @attrs[:name] }
  end

  test 'should destroy task' do
    delete task_url(@task)

    assert_redirected_to tasks_url

    assert { !Task.exists? @task.id }
  end
end
