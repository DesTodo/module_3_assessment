class SearchController < ApplicationController

  def index
    @stations = BestbuyService.find_all_stores(zip)
  end
end
