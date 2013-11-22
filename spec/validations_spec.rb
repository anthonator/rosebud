require 'spec_helper'

describe Rosebud::Validations do
  context 'register_validator!' do
    it 'should register a validator' do
      Rosebud::Validations.register_validator!(:dummy_validator, DummyValidator)
      Rosebud::Validations.validators[:dummy_validator].should == DummyValidator
    end
    
    it 'should raise an error if validator subclass is not of type Rosebud::Validator' do
      expect { Rosebud::Validations.register_validator!(:dummy_validator, InvalidSubclassValidator) }.to raise_error(ArgumentError)
    end
    
    it 'should raise an error if validator does not implement validate_param' do
      expect { Rosebud::Validations.register_validator!(:dummy_validator, NotImplementedValidator) }.to raise_error(NotImplementedError)
    end
  end
end