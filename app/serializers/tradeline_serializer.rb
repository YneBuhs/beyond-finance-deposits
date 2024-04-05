class TradelineSerializer < ActiveModel::Serializer
    attributes :tradelineLimit, :name, :outstandingBalance

    def tradelineLimit
        object.amount
    end

    def outstandingBalance
        object.outstanding_balance
    end
end  