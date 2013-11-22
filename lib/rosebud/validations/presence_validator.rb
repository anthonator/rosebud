module Rosebud
  module Validations
    class PresenceValidator < Validator
      def validate_param(name, value, options)
        error!(:presence, param: name) if value.nil? || value.strip == ''
      end
    end
    
    Validations.register_validator!(:presence, PresenceValidator)
  end
end