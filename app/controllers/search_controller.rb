class SearchController < ApplicationController

  def index
    zip = params[:zip]
    @stations = BestbuyService.find_all_stores(zip)
  end
end
