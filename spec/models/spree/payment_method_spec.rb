require 'spec_helper'

describe 'PaymentMethod' do
  describe '.available_on' do
    subject { Spree::PaymentMethod.available_on(:front_end, store) }

    let!(:check_payment_method) { create(:check_payment_method) }
    let(:payment_method_store)  { create(:store, payment_methods: [check_payment_method]) }

    context 'when store is not specified' do
      let(:store) { nil }

      it 'includes check_payment_method' do
        expect(subject).to include(check_payment_method)
      end
    end

    context 'when store is specified' do
      let(:store) { payment_method_store }

      context 'when store has payment methods' do
        let(:non_matching_check_payment_method) { create(:check_payment_method) }

        it 'includes check_payment_method and does not include non_matching_check_payment_method' do
          expect(subject).to include(check_payment_method)
          expect(subject).not_to include(non_matching_check_payment_method)
        end
      end

      context 'when store does not have payment_methods' do
        let(:payment_method_store) { create(:store) }

        it 'includes check_payment_method' do
          expect(subject).to include(check_payment_method)
        end
      end
    end
  end
end
