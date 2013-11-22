module Rosebud
  module Validations
    @validators = {}
    
    class << self
      attr_reader :validators
    end
    
    def self.register_validator!(name, klass)
      raise(ArgumentError, 'Validation class type expected to be a subclass of Rosebud::Validator...') unless klass.ancestors.include?(Validator)
      raise(NotImplementedError, 'Validator expected validate_param to be implemented...') unless klass.instance_methods.include?(:validate_param)
      name = name.to_sym
      Errawr.register!(name)
      @validators[name] = klass
    end
  end
end