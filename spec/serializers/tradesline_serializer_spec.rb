require 'rails_helper'

RSpec.describe TradelineSerializer, type: :serializer do
  let!(:tradeline) { create(:tradeline, amount: 2000, name: 'Example Tradeline') }
  let!(:deposit) { create(:deposit, date: Date.new(2022, 1, 15), amount: 1000, tradeline: tradeline) }
  let(:serializer) { described_class.new(tradeline) }
  let(:serialization) { serializer.as_json }

  context 'attributes' do
    it 'serializes outstandingBalance' do
      expect(serialization[:outstandingBalance]).to eq(1000)
    end

    it 'serializes tradelineLimit' do
      expect(serialization[:tradelineLimit]).to eq(2000)
    end
  end
end