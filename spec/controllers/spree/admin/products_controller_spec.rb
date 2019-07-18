require 'spec_helper'

describe Spree::Admin::ProductsController do
  stub_authorization!

  describe "on :index" do
    it "renders index" do
      spree_get :index
      response.should be_success
    end
  end

  describe "on a PUT to :update" do
    before(:each) do
      @product = FactoryBot.create(:product)
      @store = FactoryBot.create(:store)
    end

    describe "when no stores are selected" do
      it "clears stores if they previously existed" do
        @product.stores << @store
        spree_put :update,
          id: @product.to_param,
          product: {
            name: @product.name,
            store_ids: ''
          }

        expect(@product.reload.store_ids).to be_empty
      end
    end

    describe "when a store is selected" do
      it "clears stores" do
        spree_put :update,
          id: @product.to_param,
          product: {
            name: @product.name,
            store_ids: @store.id
          }

        expect(@product.reload.store_ids).to include(@store.id)
      end
    end

    describe "when multiple stores are selected" do
      it "clears stores" do
        stores = FactoryBot.create_list(:store, 3)
        store_ids = stores.map(&:id)
        spree_put :update,
          id: @product.to_param,
          product: {
            name: @product.name,
            store_ids: store_ids.join(",")
          }

        expect(@product.reload.store_ids).to eq(store_ids)
      end
    end
  end
end
