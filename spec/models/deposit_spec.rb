require 'rails_helper'

RSpec.describe Deposit, type: :model do
  describe '.create_deposit' do
    let!(:tradeline) { create(:tradeline, amount: 2000) }

    context 'with valid attributes' do
      it 'creates a new deposit' do
        expect {
          Deposit.create_deposit(tradeline_id: tradeline.id, amount: 100, date: Date.today)
        }.to change(Deposit, :count).by(1)
      end
    end

    context 'with missing attributes' do
      it 'raises MissingArgumentException if tradeline_id is missing' do
        expect {
          Deposit.create_deposit(amount: 100, date: Date.today)
        }.to raise_error(Deposit::MissingArgumentException)
      end

      it 'raises MissingArgumentException if the tradeline_id is invalid' do
        expect {
          Deposit.create_deposit(tradeline_id: 'FAKEID', amount: 100, date: Date.today)
        }.to raise_error(Deposit::MissingArgumentException)
      end

      it 'raises MissingArgumentException if amount is missing' do
        expect {
          Deposit.create_deposit(tradeline_id: tradeline.id, date: Date.today)
        }.to raise_error(Deposit::MissingArgumentException)
      end

      it 'raises MissingArgumentException if date is missing' do
        expect {
          Deposit.create_deposit(tradeline_id: tradeline.id, amount: 100)
        }.to raise_error(Deposit::MissingArgumentException)
      end
    end

    context 'with exceeded funds' do
      it 'raises ExceededFunds if amount exceeds tradeline balance' do
        expect {
          Deposit.create_deposit(tradeline_id: tradeline.id, amount: tradeline.amount + 5000, date: Date.today)
        }.to raise_error(Deposit::ExceededFunds)
      end
    end
  end

  describe '.find_deposit' do
    let!(:tradeline) { create(:tradeline) }
    let!(:deposit) { create(:deposit, tradeline: tradeline) }

    it 'finds a deposit by id and tradeline_id' do
      found_deposit = Deposit.find_deposit(deposit.id, tradeline.id)
      expect(found_deposit).to eq(deposit)
    end

    it 'raises MissingArgumentException if deposit_id is missing' do
      expect {
        Deposit.find_deposit(nil, tradeline.id)
      }.to raise_error(Deposit::MissingArgumentException)
    end

    it 'raises MissingArgumentException if tradeline_id is missing' do
      expect {
        Deposit.find_deposit(deposit.id, nil)
      }.to raise_error(Deposit::MissingArgumentException)
    end
  end

  describe '.find_deposits_for_tradeline' do
    let!(:tradeline) { create(:tradeline) }
    let!(:deposits) { create_list(:deposit, 3, tradeline: tradeline) }

    it 'returns deposits for a given tradeline_id' do
      found_deposits = Deposit.find_deposits_for_tradeline(tradeline.id)
      expect(found_deposits).to match_array(deposits)
    end

    it 'raises MissingArgumentException if tradeline_id is missing' do
      expect {
        Deposit.find_deposits_for_tradeline(nil)
      }.to raise_error(Deposit::MissingArgumentException)
    end
  end
end