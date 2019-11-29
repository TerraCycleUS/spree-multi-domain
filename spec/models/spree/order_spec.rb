require 'spec_helper'

describe Spree::Order do
  let!(:store)  { create(:store) }
  let!(:order)  { create(:order, store: store) }
  let!(:order2) { create(:order) }

  it 'should correctly find order by store' do
    order_by_store = Spree::Order.by_store(store)

    expect(order_by_store).to include(order)
    expect(order_by_store).not_to include(order2)
  end
end
