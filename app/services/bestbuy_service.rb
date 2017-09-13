class BestbuyService
  attr_reader :zip, :key, :base

  def initialize(zip)
    @zip  = zip
    @key  = ENV["api_key"]
    @base = "https://api.bestbuy.com/v1/stores(area(#{zip},25))?format=json&show=storeType,longName,phone,city,distance&pageSize=60&apiKey=#{key})"
  end

  def self.find_all_stores(zip)
    new(zip).find_all_stores
  end

  def find_all_stores
    get_url(base)
  end

  def get_url(url_details)
    response = Faraday.get(base)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    parsed_response[:stores]
  end
end
