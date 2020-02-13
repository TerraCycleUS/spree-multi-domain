Spree::Admin::ProductsController.class_eval do
  before_action :find_stores, only: [:update]

  private

  def find_stores
    store_ids = params[:product][:store_ids]
    if store_ids.present?
      params[:product][:store_ids] = store_ids.split(',')
    end
  end

end
