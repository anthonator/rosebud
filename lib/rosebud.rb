require 'errawr'
require 'errawr/rails'
require 'virtus'

require 'rosebud/params_scope'
require 'rosebud/validations'
require 'rosebud/validator'
require 'rosebud/version'

I18n.load_path << "#{File.dirname(__FILE__)}/rosebud/locale/en.yml"
I18n.reload!

Dir[File.expand_path('../rosebud/validations/*.rb', __FILE__)].each do |path|
  require(path)
end

module Rosebud
  def self.included(base)
    base.extend(ClassMethods)

    unless base.ancestors.include?(Errawr::Rails)
      base.send(:include, Errawr::Rails::Renderable.render_with(Errawr::Rails::Renderers::JSON))
    end
  end

  module ClassMethods
    def params(action = :all, &block)
      action = action.to_s
      before_action do
        if action == 'all' || params[:action] == action
          ParamsScope.new(self, params, &block)
        end
      end
    end
  end
end
