module Spree
  module StoreDecorator
    def self.prepended(base)
      base.has_and_belongs_to_many :products, join_table: 'spree_products_stores'
      base.has_many :taxonomies
      base.has_many :orders
      base.has_many :store_payment_methods
      base.has_many :payment_methods, through: :store_payment_methods
      base.has_many :store_shipping_methods
      base.has_many :shipping_methods, through: :store_shipping_methods
      base.has_and_belongs_to_many :promotion_rules, class_name: 'Spree::Promotion::Rules::Store', join_table: 'spree_promotion_rules_stores', association_foreign_key: 'promotion_rule_id'

      if Spree.version.to_f < 3.7
        base.has_attached_file :logo,
                                styles: { mini: '48x48>', small: '100x100>', medium: '250x250>' },
                                default_style: :medium,
                                url:  '/stores/:id/:style/:filename',
                                path: ':rails_root/public/stores/:id/:style/:filename',
                                convert_options: { all: '-strip -auto-orient' }

        base.validates_attachment_file_name :logo, matches: [/png\Z/i, /jpe?g\Z/i], if: -> { logo.present? }
      else
        base.has_one_attached :logo
        base.validates :logo, content_type: ['image/jpeg', 'image/jpg', 'image/png']
      end
    end
  end
end

::Spree::Store.prepend(Spree::StoreDecorator)
