# app/models/deposit.rb
class Deposit < ApplicationRecord
    validates_presence_of :amount, :date
    belongs_to :tradeline
  
    class MissingArgumentException < StandardError; end
    class ExceededFunds < StandardError; end
  
    def self.create_deposit(deposit_params)
      tradeline_id = deposit_params[:tradeline_id]
      amount = deposit_params[:amount]
      date = deposit_params[:date]
      
      # Validate required parameters
      raise MissingArgumentException, "Provide tradeline_id, amount, and date" unless tradeline_id.present? && amount.present? && date.present?
  
      # Find tradeline
      tradeline = Tradeline.find_by_id(tradeline_id)
      raise MissingArgumentException, "Invalid Tradeline ID" unless tradeline
  
      # Check if deposit amount exceeds account amount limit
      raise ExceededFunds, "Deposit amount exceeds account outstanding balance" if tradeline.outstanding_balance < amount 

      Deposit.create(deposit_params)
    end
  
    def self.find_deposits_for_tradeline(tradeline_id)
      raise MissingArgumentException, "Provide Tradeline ID" unless tradeline_id.present?
      where(tradeline_id: tradeline_id)
    end
  
    def self.find_deposit(deposit_id, tradeline_id)
      raise MissingArgumentException, "Provide Deposit ID and Tradeline ID" unless deposit_id.present? && tradeline_id.present?
      find_by(tradeline_id: tradeline_id, id: deposit_id)
    end
  end
  