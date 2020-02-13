module Spree
  module TaxonomyDecorator
    def self.prepended(base)
      base.belongs_to :store

      base.scope :by_store, -> (store) { where(store_id: store) }
    end
  end
end

::Spree::Taxonomy.prepend(Spree::TaxonomyDecorator)
