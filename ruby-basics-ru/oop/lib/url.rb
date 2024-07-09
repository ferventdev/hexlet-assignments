# frozen_string_literal: true

# BEGIN
require 'forwardable'
require 'uri'

class Url
  extend Forwardable
  include Comparable

  attr_reader :query_params

  def initialize(address)
    @uri = URI address
    q = @uri.query
    @query_params = if q.nil? || q.empty?
                      {}
                    else
                      q.split('&').reject(&:empty?).filter { _1.include? '=' }
                       .sort.map { _1.split('=', 2) }.reject { _1.any?(&:empty?) }
                       .to_h.transform_keys!(&:to_sym)
                    end
  end

  def_delegators :@uri, :scheme, :host, :port

  def query_param(pname, default_value = nil) = query_params[pname] || default_value

  def query = query_params.to_a.map { _1.join '=' }.join '&'

  def <=>(other) = to_s <=> other.to_s

  def to_s
    q = query
    query_str = q.nil? || q.empty? ? '' : "?#{q}"
    f = @uri.fragment
    f_str = f.nil? || f.empty? ? '' : "##{f}"
    p = port
    port_str = p.nil? || p.to_s.empty? ? '' : ":#{p}"
    "#{@uri.scheme}://#{@uri.host}#{port_str}#{@uri.path}#{query_str}#{f_str}"
  end
end
# END
