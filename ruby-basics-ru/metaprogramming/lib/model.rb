# frozen_string_literal: true

# BEGIN
AttrProperties = Struct.new('AttrProperties', :type, :default)

module Model
  def initialize(attrs = {})
    @attrs = self.class.attrs_config.to_h do |attr_name, attr_props|
      value = convert(attrs[attr_name], attr_props.type)
      [attr_name, (value.nil? ? attr_props.default : value)]
    end
  end

  def attributes = @attrs

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    attr_reader :attrs_config

    # when called, creates getter and setter for the attribute and adds it to the config
    def attribute(name, type: nil, default: nil)
      @attrs_config ||= {}
      @attrs_config[name] = AttrProperties.new(type, default)

      # defines getter
      define_method(name) { @attrs[name] }

      # defines setter
      define_method("#{name}=") { |value| @attrs[name] = convert(value, type) }
    end
  end

  private

  # rubocop:disable Metrics/CyclomaticComplexity
  def convert(value, type)
    return value if type.nil? || value.nil?

    case type
    when :string then value.is_a?(String) ? value : value.to_s
    when :boolean then convert_to_boolean(value)
    when :integer then value.is_a?(Integer) ? value : value.to_i
    when :datetime then value.is_a?(DateTime) ? value : DateTime.parse(value.to_s)
    else value
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  def convert_to_boolean(value)
    if value.is_a?(TrueClass) || value.is_a?(FalseClass)
      value
    elsif value.is_a?(String) && value.downcase == 'true'
      true
    elsif value.is_a?(String) && value.downcase == 'false'
      false
    else
      !!value
    end
  end
end
# END
