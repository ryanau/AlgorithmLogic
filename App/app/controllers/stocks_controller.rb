require 'csv'
require 'json'
require 'HTTParty'


# class Stock
# 	def initialize(opts={})
# 		ticker = opts.fetch(:ticker)
# 		eps = opts.fetch(:eps)
# 		pe = opts.fetch(:pe)
# 		pbook = opts.fetch(:pbook)
# 		psales = opts.fetch(:psales)
# 		markcap = opts.fetch(:markcap)
# 		ask = opts.fetch(:ask)
# 		bid = opts.fetch(:bid)
# 	end
# end

class StocksController < ApplicationController
	
	def create

	end

	def index
		url = 'http://finance.yahoo.com/d/quotes.csv?s='
		ticker = "aapl"
		connect = "&f="
		eps = "e"
		pe = "r"
		peg = "r5"
		pbook = "p6"
		psales = "p5"
		markcap = "j1"
		ask = "a"
		bid = "b"
		book_value = "b4"


		# full_url = url + ticker + connect + eps + pe + pbook + psales + markcap + ask + bid
		tickers = ["aapl", "nke", "luv", "tsla", "mmm", "sbux", "ge", "f", "pcg", "vz"]
		# tickers = ["aapl"]

		@stocks = []

		tickers.each do |ticker|
			full_url = url + ticker + connect + eps + pe + pbook + psales + markcap + ask + bid + peg + book_value
			response = HTTParty.get(full_url)
			parsed = CSV.parse(response)[0]
			stock = Stock.create(ticker: ticker, eps: parsed[0].to_f, pe: parsed[1].to_f, pbook: parsed[2].to_f, psales: parsed[3].to_f, markcap: parsed[4].to_f * 1000000000, ask: parsed[5].to_f, bid: parsed[6].to_f, peg: parsed[7].to_f, book_value: parsed[8].to_f * 1000000000)

			shares = stock.markcap/((stock.ask + stock.bid)/2)

			if stock.eps >= 0
				gnum = Math.sqrt(22.5 * (stock.eps * (stock.book_value/shares)))
			else
				gnum = 0
			end

			stock.update_attributes(graham_number: gnum, shares: shares)



		end




		@stocks = Stock.all
		render 'index'
	end
end

