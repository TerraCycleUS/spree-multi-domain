require 'spec_helper'

describe Spree::ShippingMethod do
  let(:shipping_method) { create(:shipping_method) }
  let(:order)           { create(:order, store: store) }
  let(:store)           { create(:store) }
  let(:subject)         { shipping_method.store_match?(order) }

  describe '.store_match?' do
    context 'when store contains this shipping method' do
      before { store.shipping_methods << shipping_method }

      it 'returns true' do
        expect(subject).to eq(true)
      end
    end

    context 'when the store does not contain this shipping method' do
      context 'when the store has no shipping methods' do
        it 'returns true' do
          expect(subject).to eq(true)
        end
      end

      context 'when the store has at least on shipping method' do
        before { store.shipping_methods << create(:shipping_method) }

        it 'returns false' do
          expect(subject).to eq(false)
        end
      end
    end
  end
end
