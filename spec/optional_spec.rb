require 'spec_helper'

describe Rosebud::ParamsScope do
  context 'RequiresController', type: :controller do
    controller(ApplicationController) do
      include Rosebud
      extend(RSpec::Rails::ControllerExampleGroup::BypassRescue)

      params do
        optional :name, type: Integer, default: 1234
      end

      def index
        render nothing: true
      end
    end

    it 'should render 200 if a value is not provided' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'should render an error if validation fails' do
      get :index, name: 'A'
      expect(response.status).to_not eq(200)
      expect(response.body).to eq({
        error: 'invalid_parameter',
        description: 'invalid parameter: name'
      }.to_json)
    end

    it 'should add a default value to the params' do
      get :index
      expect(controller.params[:name]).to eq(1234)
    end
  end
end
