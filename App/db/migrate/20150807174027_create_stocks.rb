class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
    	t.string :ticker
    	t.string :name
        t.string :industry
    	t.float :eps
    	t.float :pe
    	t.float :pbook
    	t.float :psales
    	t.float :markcap
    	t.float :beta
    	t.float :ask
    	t.float :bid
    	t.float :peg
    	t.float :graham_number
    	t.float :shares
    	t.float :book_value
      t.timestamps null: false
    end
  end
end
