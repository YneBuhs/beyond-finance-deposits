require 'rails_helper'

RSpec.describe Tradeline, type: :model do
  describe '.outstanding_balance' do
    let(:tradeline) { build(:tradeline, amount: 15000) }

    context 'with valid attributes' do
      it 'creates a new deposit' do
        deposit = create(:deposit, amount: 1000, tradeline: tradeline)
        expect(tradeline.outstanding_balance).to eq(tradeline.amount - deposit.amount) #14000
      end
    end
  end
end