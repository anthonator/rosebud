require 'spec_helper'

describe Rosebud::ParamsScope do
  context 'OptionalController', type: :controller do
    controller(ApplicationController) do
      include Rosebud

      params do
        optional :name, type: Integer, default: 1234
        optional :other, type: Integer, default: ->(_, _) { 1234 }
      end

      def index
        head :ok
      end
    end

    it 'should render 200 if a value is not provided' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'should render an error if validation fails' do
      get :index, params: { name: 'Anthony' } if Rails.version > '4.2'
      get :index, name: 'Anthony' if Rails.version < '5'
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

    it 'should accept default value with callable' do
      get :index
      expect(controller.params[:other]).to eq(1234)
    end

    it 'should accept coerce value if possible' do
      get :index, params: { other: '123' } if Rails.version > '4.2'
      get :index, name: '123' if Rails.version < '5'
      expect(controller.params[:other]).to eq(123)
    end
  end
end
