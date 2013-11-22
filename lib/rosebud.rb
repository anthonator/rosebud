require 'errawr'
require 'errawr/rails'
require 'virtus'

require 'rosebud/params_scope'
require 'rosebud/validations'
require 'rosebud/validator'
require 'rosebud/version'

Dir[File.expand_path('../rosebud/validations/*.rb', __FILE__)].each do |path|
  require(path)
end

module Rosebud
  I18n.load_path << "#{File.dirname(__FILE__)}/rosebud/locale/en.yml"
  I18n.reload!
  
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, Errawr::Rails::Renderable.render_with(Errawr::Rails::Renderers::JSON))
  end
  
  module ClassMethods
    def params(action = :all, &block)
      action = action.to_s
      before_filter do
        if action == 'all' || params[:action] == action
          ParamsScope.new(self, params, &block)
        end
      end
    end
  end
  
  Errawr.register!(:presence)
  Errawr.register!(:type)
end
