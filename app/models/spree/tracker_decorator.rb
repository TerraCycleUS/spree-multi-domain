module Spree
  module TrackerDecorator
    def self.prepended(base)
      base.belongs_to :store
      base.extend ClassMethods
    end

    module ClassMethods
      def find_current(domain, engine = Spree::Tracker::TRACKING_ENGINES)
        Spree::Tracker.where(engine: engine).active.joins(:store).where("spree_stores.url LIKE ?", "%#{domain}%").first
      end
    end
  end
end

::Spree::Tracker.prepend(Spree::TrackerDecorator) if defined?(Spree::Tracker)
