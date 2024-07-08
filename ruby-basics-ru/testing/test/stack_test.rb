# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def test_initially_empty
    stack = Stack.new

    assert { stack.empty? }
    assert { stack.to_a.empty? }
  end

  def test_initially_filled
    stack = Stack.new %w[a b c]

    refute { stack.empty? }
    assert { stack.size == 3 }
    refute { stack.to_a.empty? }
    assert { stack.to_a == %w[a b c] }
  end

  def test_clear
    stack = Stack.new %w[a b c]

    refute { stack.empty? }
    assert { stack.size == 3 }

    stack.clear!

    assert { stack.empty? }
    assert { stack.to_a.empty? }
  end

  # rubocop:disable Metrics/AbcSize
  def test_push
    stack = Stack.new

    assert { stack.empty? }

    stack.push! 'ruby'

    assert { stack.size == 1 }

    stack.push! 'clojure'
    stack.push! 'golang'

    assert { stack.size == 3 }

    stack.push! 'elixir'
    stack.push! 'crystal'

    refute { stack.empty? }
    assert { stack.size == 5 }
    refute { stack.to_a.empty? }
    assert { stack.to_a == %w[ruby clojure golang elixir crystal] }
  end

  def test_pop
    stack = Stack.new %w[ruby clojure golang]

    refute { stack.empty? }
    assert { stack.size == 3 }

    assert { stack.pop! == 'golang' }
    assert { stack.size == 2 }
    assert { stack.pop! == 'clojure' }
    assert { stack.size == 1 }
    assert { stack.pop! == 'ruby' }
    assert { stack.empty? }
  end
  # rubocop:enable Metrics/AbcSize
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has no tests!' if test_methods.empty?
