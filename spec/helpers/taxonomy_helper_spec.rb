require 'spec_helper'

module Spree
  module Api
    describe TaxonomyHelper do
      let!(:store)     { create(:store) }
      let!(:taxonomy)  { create(:taxonomy, store: store) }
      let!(:taxonomy2) { create(:taxonomy) }

      before { allow(helper).to receive(:current_store).and_return(store) }

      describe "#get_taxonomies" do
        it "only show taxonomies on current_store" do
          taxonomies = helper.get_taxonomies

          expect(taxonomies).to include(taxonomy)
          expect(taxonomies).not_to include(taxonomy2)
        end
      end
    end
  end
end
