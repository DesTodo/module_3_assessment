class SearchController < ApplicationController

  def index
    zip = params[:q]
    @stores = Store.find_all(zip)
  end
end
