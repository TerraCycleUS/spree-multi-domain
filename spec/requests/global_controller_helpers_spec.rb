require 'spec_helper'

describe "Global controller helpers" do
  let!(:store)   { create :store }
  let!(:tracker) { create :tracker, store: store }

  before { get '/' }

  it 'should include the right tracker' do
    expect(response.body).to include(tracker.analytics_id)
  end

  it 'should create a store-aware order' do
    expect(controller.current_store).to eq(store)
  end

  it 'should instantiate the correct store-bound tracker' do
    expect(controller.current_tracker).to eq(tracker)
  end

  describe '.current_currency' do
    subject { controller.current_currency }

    context 'when store default_currency is not defined' do
      it 'equals USD' do
        expect(subject).to eq('USD')
      end
    end

    context 'when the current store default_currency is a currency' do
      let!(:store) { create(:store, default_currency: 'EUR') }

      it 'is equal EUR' do
        expect(subject).to eq('EUR')
      end
    end

    context 'when session[:currency] set by spree_multi_currency' do
      before { session[:currency] = 'AUD' }

      let!(:aud)   { ::Money::Currency.find('AUD') }
      let!(:eur)   { ::Money::Currency.find('EUR') }
      let!(:usd)   { ::Money::Currency.find('USD') }
      let!(:store) { create(:store, default_currency: 'EUR') }

      it 'returns supported currencies' do
        allow(controller).to receive(:supported_currencies).and_return([aud, eur, usd])

        expect(controller.current_currency).to eq('AUD')
      end

      it 'returns store currency if not supported' do
        allow(controller).to receive(:supported_currencies).and_return([eur, usd])

        expect(controller.current_currency).to eq('EUR')
      end
    end
  end

end
