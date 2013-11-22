module Rosebud
  class ParamsScope
    def initialize(controller, params, &block)
      @controller = controller
      @params = params
      @declared_params = []
      
      instance_eval(&block)
    end
    
    def requires(name, validations = {})
      name = name.to_sym
      validations.merge!({ presence: true })
      
      validate(name, @params[name], validations)
    end
    
    def optional(name, validations = {})
      name = name.to_sym
      validate(name, @params[name], validations)
    end
    
    private
    def validate(attribute, value, validations)
      validations.each do |type, options|
        validator_class = Validations.validators[type]
        raise("Validator #{type} is not registered...") unless validator_class
        validator_class.new.validate_param(attribute, value, options)
      end
    end
  end
end