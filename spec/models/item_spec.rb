require "rails_helper"

RSpec.describe Item, type: :model do
  describe "assocaitions" do
    it {is_expected.to have_many(:orders)}
    it {is_expected.to have_many(:order_items)}
  end
end
