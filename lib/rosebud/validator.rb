module Rosebud
  class Validator
    include Errawr::ClassMethods
    
    def validate!(param)
      validate_param(param)
    end
  end
end