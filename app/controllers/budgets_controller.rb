class BudgetsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @budgets = current_user.budgets
  end
  
  def new
    @budget = Budget.new
  end
  
  def create
    begin
      current_user.budgets.create! params[:budget]
      redirect_to budgets_path
    rescue Mongoid::Errors::Validations => e
      flash[:notice] = e.message
      redirect_to new_budget_path
    end
  end
  
  def show
    begin
      @budget = current_user.budgets.find params[:id]
    rescue Mongoid::Errors::DocumentNotFound => e
      flash[:notice] = 'unknown budget'
      redirect_to budgets_path
    end
  end
  
  def edit
    show
  end
  
end
