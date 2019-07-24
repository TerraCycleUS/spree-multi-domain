Deface::Override.new(
  virtual_path: 'spree/shared/_search',
  name: 'filter current store taxons',
  replace: "erb[silent]:contains('@taxons = @taxon && @taxon.parent ? @taxon.parent.children : Spree::Taxon.roots')",
  text: "<% @taxons = taxons_for_search %>"
)
