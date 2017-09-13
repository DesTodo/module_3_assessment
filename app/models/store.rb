class Store
  attr_reader :city, :longName, :distance, :phone, :storeType

  def initialize(raw_store)
    @city      = raw_store[:city]
    @longName  = raw_store[:longName]
    @distance  = raw_store[:distance]
    @phone     = raw_store[:phone]
    @storeType = raw_store[:storeType]
  end

  def self.find_all(zip)
   raw_stores = BestbuyService.find_all_stores(zip)

   raw_stores.map do |store|
     new(store)
   end
  end

end
