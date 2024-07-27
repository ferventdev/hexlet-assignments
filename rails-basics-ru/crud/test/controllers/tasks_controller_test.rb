# frozen_string_literal: true

require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  self.use_transactional_tests = true

  setup do
    @attrs = {
      name: Faker::Hobby.unique.activity,
      description: Faker::Lorem.sentence,
      status: %w[new in_progress on_review in_testing done].sample,
      creator: Faker::GreekPhilosophers.name,
      performer: Faker::Name.name,
      completed: false
    }
  end

  test 'list all tasks' do
    get root_url

    assert_response :success
    assert_select 'h1', 'All tasks'
  end

  test 'gets one task with fixture' do
    task = tasks(:one)

    get task_url(task)

    assert_response :success
    assert_select 'h1', 'name1'
    assert_select 'h2', 'Status: new. Completed: false. Performer: p1'
    assert_select 'p', 'Description: desc1'
  end

  test 'creates task' do
    post tasks_url, params: { task: @attrs }

    task = Task.find_by! name: @attrs[:name]

    assert_redirected_to task_url(task)
  end

  test 'updates task' do
    task = tasks(:one)
    put task_url(task), params: { task: @attrs }
    assert_redirected_to task_url(task)

    task.reload

    assert { task.name == @attrs[:name] }
  end

  test 'destroys task' do
    task = tasks(:one)
    delete task_url(task)

    assert_redirected_to tasks_url

    assert { !Task.exists? task.id }
  end
end
