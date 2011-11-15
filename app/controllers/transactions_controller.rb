class TransactionsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @transactions = Transaction.find
  end
  
end
