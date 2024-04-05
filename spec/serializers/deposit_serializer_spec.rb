require 'rails_helper'

RSpec.describe DepositSerializer, type: :serializer do
  let(:tradeline) { create(:tradeline, name: 'Example Tradeline') }
  let(:deposit) { create(:deposit, date: Date.new(2022, 1, 15), amount: 1000, tradeline: tradeline) }
  let(:serializer) { described_class.new(deposit) }
  let(:serialization) { serializer.as_json }

  context 'attributes' do
    it 'serializes depositDate as YYYY-MM-DD format' do
      expect(serialization[:depositDate]).to eq('2022-01-15')
    end

    it 'serializes depositAmount' do
      expect(serialization[:depositAmount]).to eq(1000)
    end

    it 'includes tradeline details' do
      expect(serialization[:tradeline]).to eq({ id: tradeline.id, name: 'Example Tradeline' })
    end
  end
end
