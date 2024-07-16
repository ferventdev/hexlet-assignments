# frozen_string_literal: true

class ExecutionTimer
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    request = Rack::Request.new env
    start = current_micros
    resp = @app.call env
    puts "#{request.request_method} #{request.path} - request processed for #{current_micros - start}us"
    resp
    # END
  end

  private

  def current_micros = (Time.now.to_f * 1_000_000).to_i
end
