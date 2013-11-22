# Rosebud

Rails API parameter validation

[![Build Status](https://travis-ci.org/anthonator/rosebud.png?branch=master)](https://travis-ci.org/anthonator/rosebud) [![Coverage Status](https://coveralls.io/repos/anthonator/rosebud/badge.png?branch=master)](https://coveralls.io/r/anthonator/rosebud?branch=master) [![Code Climate](https://codeclimate.com/github/anthonator/rosebud.png)](https://codeclimate.com/github/anthonator/rosebud)

## Installation

Add this line to your application's Gemfile:

    gem 'rosebud'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rosebud

## Usage

### Getting Started

Just include ```Rosebud``` in your Rails controller.

```ruby
class Api::V1::SomeController < Api::V1::ApplicationController
  include Rosebud
end
```

### Validating Parameters

To validate parameters specify a ```params``` block and choose whether the params are required or optional.

```ruby
class Api::V1::SomeController < Api::V1::ApplicationController
  include Rosebud
  
  params do
    requires :name
    optional :phone_number, regex: /\d{10}/, default: '5555555555'
  end
  
  ...
  
end
```

It's also possible to define validations for a specific action.

```ruby
class Api::V1::SomeController < Api::V1::ApplicationController
  include Rosebud
  
  params :create do
    ...
  end
  
  def create
    ...
  end
end
```

### Rendering Errors

When a parameter error is raised a JSON response will be rendered.

```ruby
{
  "error":       "missing_parameter",
  "description": "missing parameter: name"
}
```

### Custom Validators

Currently the only validators that ship with Rosebud are ```presence```, ```regex``` and ```type```. If you need other validators you can create your own.

```ruby
class MyLengthValidator < Rosebud::Validator
  def validate_param(name, value, options)
    if value.length <= options
      error!(:length, param: name, length: value.length, max_length: options)
    end
  end
end

Rosebud::Validations.register_validator!(:length, MyLengthValidator)
```

Rosebud uses the [Errawr::Rails](http://www.github.com/anthonator/errawr-rails) gem to raise and render localised errors. Add your custom error message to your locale file.

```yaml
en:
  errawr:
    length:
      message: %{length} characters is too long for %{param}, should be less than or equal to %{max_length}
      http_status: 400
      metadata:
        additional_info: Kick him in the shins!
```

Add a validation using your custom validator:

```ruby
class Api::V1::SomeController < Api::V1::ApplicationController
  include Rosebud
  
  params :create do
    requires :name, length: 2
  end
  
  def create
    ...
  end
end
```

The following error will be rendered for the ```name``` parameter when provided with a value of ```abc```:

```json
{
  "error":       "length",
  "description": "3 characters is too long for name, should be less than or equal to 2",
  "additional_info": "Kcik him in the shins!"
}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits
[![Sticksnleaves](http://sticksnleaves-wordpress.herokuapp.com/wp-content/themes/sticksnleaves/images/snl-logo-116x116.png)](http://www.sticksnleaves.com)

Rosebud is maintained and funded by [Sticksnleaves](http://www.sticksnleaves.com)

Thanks to all of our [contributors](https://github.com/anthonator/rosebud/graphs/contributors)