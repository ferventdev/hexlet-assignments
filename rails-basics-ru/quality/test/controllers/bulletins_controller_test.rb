# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  self.use_transactional_tests = true

  test 'opens all bulletins page' do
    get bulletins_url

    assert_response :success
    assert_select 'h1', 'Bulletins'
  end

  test 'opens one bulletin page' do
    bull = Bulletin.create(title: 'MyTitle', body: 'MyBody', published: false)

    get bulletin_url(bull.id)

    assert_response :success
    assert_select 'h1', 'Bulletin page'
    assert_select 'h4', 'MyTitle'
    assert_select 'p', 'MyBody'
  end

  test 'opens one bulletin page with fixture' do
    bull = bulletins(:one)

    get bulletin_url(bull)

    assert_response :success
    assert_select 'h1', 'Bulletin page'
    assert_select 'h4', 'title1'
    assert_select 'p', 'body1'
  end
end
