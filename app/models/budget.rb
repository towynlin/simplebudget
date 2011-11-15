class Budget
  include Mongoid::Document
  has_and_belongs_to_many :users
  embeds_many :transactions
  field :name, type: String
  field :daily_amount, type: Integer # cents
  validates_numericality_of :daily_amount, greater_than: 0, only_integer: true
  before_create :convert_dollars_to_cents

  def self.money_format(cents)
    cs = cents.to_s
    dollars = cs[0..-3]
    dollars = '0' if dollars.nil? or dollars == ''
    c = cs[-2..-1]
    c = "0#{cs}" if c.nil?
    "$#{dollars}.#{c}"
  end

  protected

  def convert_dollars_to_cents
    self.daily_amount = daily_amount * 100 unless daily_amount.nil?
  end

end
