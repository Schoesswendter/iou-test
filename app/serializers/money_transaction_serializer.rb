class MoneyTransactionSerializer
    include FastJsonapi::ObjectSerializer
    attributes :creditor_id, :debitor_id, :amount, :paid_at
end
  