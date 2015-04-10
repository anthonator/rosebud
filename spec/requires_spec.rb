require 'spec_helper'

describe Rosebud::ParamsScope do
  context 'RequiresController', type: :controller do
    controller(ApplicationController) do
      include Rosebud
      extend(RSpec::Rails::ControllerExampleGroup::BypassRescue)

      params do
        requires :name
      end

      def index
        render nothing: true
      end
    end

    it 'should render a missing parameter error' do
      get :index
      expect(response.status).to eq(400)
      expect(response.body).to eq({
        error: 'missing_parameter',
        description: 'missing parameter: name'
      }.to_json)
    end

    it 'should render 200 if a paremeter is not missing' do
      get :index, name: 'Anthony'
      expect(response.status).to eq(200)
    end
  end
end
