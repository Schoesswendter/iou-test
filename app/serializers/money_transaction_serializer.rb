# frozen_string_literal: true

class MoneyTransactionSerializer
    include FastJsonapi::ObjectSerializer
    attributes :amount, :paid_at
    belongs_to :creditor, redord_type: :user
    belongs_to :debitor, redord_type: :user
  end
  