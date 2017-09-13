require "rails_helper"

describe Store do
  it "successfully initializes with valid attributes" do
    valid_attributes = {
      city: "Denver",
      longName: "Cherry Creek Shopping Center",
      distance: 0.96,
      phone: "303-270-9189",
      storeType: "Mobile SAS"
    }

    store = Store.new(valid_attributes)

    expect(store.city).to eq("Denver")
    expect(store.longName).to eq("Cherry Creek Shopping Center")
    expect(store.distance).to eq(0.96)
    expect(store.phone).to eq("303-270-9189")
    expect(store.storeType).to eq("Mobile SAS")
  end
end
