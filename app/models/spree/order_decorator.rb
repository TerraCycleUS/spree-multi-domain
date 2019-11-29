module Spree
  module OrderDecorator
    def self.prepended(base)
      base.belongs_to :store
      base.scope :by_store, -> (store) { where(store_id: store) }
      base.extend ClassMethods
    end

    module ClassMethods
      def available_payment_methods
        @available_payment_methods ||= Spree::PaymentMethod.available_on(:front_end, store)
      end
    end
  end
end

::Spree::Order.prepend(Spree::OrderDecorator)
