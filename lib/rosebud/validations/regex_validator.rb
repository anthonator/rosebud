module Rosebud
  module Validations
    class RegexValidator < Validator
      def validate_param(name, value, pattern)
        error!(:regex, param: name) unless value.to_s =~ pattern
      end
    end
    
    Validations.register_validator!(:regex, RegexValidator)
  end
end