module Rosebud
  module Validations
    class TypeValidator < Validator
      def validate_param(name, value, type)
        coerced_value = coerce_value(type, value)
        error!(:type, param: name) unless valid_type?(type, coerced_value)
      end
      
      private
      def coerce_value(type, value)
        coercer = Virtus::Attribute.build(type)
        coercer.coerce(value)
      end
      
      def valid_type?(type, value)
        return true if value.nil?
        if type == Virtus::Attribute::Boolean
          value.is_a?(TrueClass) || value.is_a?(FalseClass)
        elsif type == Rack::Multipart::UploadedFile
          value.key?(:tempfile)
        else
          value.is_a?(type)
        end
      end
    end
    
    Validations.register_validator!(:type, TypeValidator)
  end
end