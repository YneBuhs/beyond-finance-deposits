class CreateDeposits < ActiveRecord::Migration[7.1]
  def change
    create_table :deposits do |t|
      t.decimal :amount, null: false
      t.date :date, null: false
      t.belongs_to :tradeline, index: true
      t.timestamps
    end
  end
end
