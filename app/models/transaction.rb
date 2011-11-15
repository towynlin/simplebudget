class Transaction
  include Mongoid::Document
  embedded_in :budget
  field :amount, type: Integer # cents
  field :description, type: String
  field :when, type: DateTime
end
