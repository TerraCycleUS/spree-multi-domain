require 'spec_helper'

describe Spree::Tracker do
  let!(:store)         { create(:store) }
  let!(:tracker)       { create(:tracker, store: store, analytics_id: 'test-analytic-id-1') }
  let!(:another_store) { create(:store, url: 'completely-different-store.com') }
  let!(:tracker2)      { create(:tracker, store: another_store, analytics_id: 'test-analytic-id-2') }

  it "should pull out the current tracker" do
    expect(Spree::Tracker.find_current('www.example.com')).to eq(tracker)
  end
end
