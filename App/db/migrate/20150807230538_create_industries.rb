class CreateIndustries < ActiveRecord::Migration
  def change
    create_table :industries do |t|
      t.string :name
      t.integer :eps
      t.integer :pe
      t.integer :pbook
      t.integer :psales
      t.integer :markcap
      t.integer :peg
      t.integer :book_value
      t.integer :shares
      t.integer :graham_number

      t.timestamps null: false
    end
  end
end
