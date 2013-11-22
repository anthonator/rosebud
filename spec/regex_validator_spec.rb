require 'spec_helper'

describe Rosebud::Validations::RegexValidator do
  it 'should raise an error if value does not match regex pattern' do
    expect { Rosebud::Validations::RegexValidator.new.validate_param(:param, 'A', /\d/) }.to raise_error(Errawr::Error)
  end
  
  it 'should not raise an error if does match regex pattern' do
    expect { Rosebud::Validations::RegexValidator.new.validate_param(:param, '1', /\d/) }.not_to raise_error
  end
end