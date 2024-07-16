# frozen_string_literal: true

class AdminPolicy
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    request = Rack::Request.new env
    case request.path
    when %r{^/admin} then [403, {}, []]
    else @app.call env
    end
    # END
  end
end
