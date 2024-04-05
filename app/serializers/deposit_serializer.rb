class DepositSerializer < ActiveModel::Serializer
    attributes :depositDate, :depositAmount, :tradeline
  
    def depositDate
        object.date.strftime('%Y-%m-%d') if object.date
    end
  
    def depositAmount
        object.amount
    end
  
    def tradeline
        {
          id: object.tradeline.id,
          name: object.tradeline.name,
        }
    end
end  