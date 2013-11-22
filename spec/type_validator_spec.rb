require 'spec_helper'

describe Rosebud::Validations::TypeValidator do
  it 'should raise an error if value cannot be converted to provided type' do
    expect { Rosebud::Validations::TypeValidator.new.validate_param(:param, 'A', Integer) }.to raise_error(Errawr::Error)
  end
  
  it 'should raise an error if a boolean value cannot be converted to provided type' do
    expect { Rosebud::Validations::TypeValidator.new.validate_param(:param, 'A', Virtus::Attribute::Boolean) }.to raise_error(Errawr::Error)
  end
  
  it 'should not raise an error if coercion is successful' do
    expect { Rosebud::Validations::TypeValidator.new.validate_param(:param, '1', String) }.not_to raise_error
  end
end