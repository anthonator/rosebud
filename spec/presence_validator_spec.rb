require 'spec_helper'

describe 'Rosebud::Validations::PresenceValidator' do
  it 'should raise an error if value is nil' do
    expect { Rosebud::Validations::PresenceValidator.new.validate_param(:param, nil, true) }.to raise_error(Errawr::Error)
  end
  
  it 'should raise an error if value is blank' do
    expect { Rosebud::Validations::PresenceValidator.new.validate_param(:param, '', true) }.to raise_error(Errawr::Error)
  end
  
  it 'should raise an error if value is whitespace' do
    expect { Rosebud::Validations::PresenceValidator.new.validate_param(:param, ' ', true) }.to raise_error(Errawr::Error)
  end
  
  it 'should not raise an error if value is not blank' do
    expect { Rosebud::Validations::PresenceValidator.new.validate_param(:param, 'Anthony', true) }.not_to raise_error
  end
end