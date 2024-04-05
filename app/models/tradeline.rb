class Tradeline < ApplicationRecord
    has_many :deposits

    def outstanding_balance
        debits = deposits.sum(:amount)
        amount - debits
    end
end