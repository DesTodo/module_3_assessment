require "rails_helper"

describe "Items API" do
  it "can return all items" do
    item = create(:item, name: "Best Item", description: "Best Item Description", image_url: "Image URL")
    list = create_list(:item, 3)
    expect(Item.count).to eq(4)

    get "/api/v1/items"
    expect(response).to be_success
    expect(response.status).to eq(200)

    raw_items = JSON.parse(response.body, symbolize_names: true)
    raw_item = raw_items.first

    expect(raw_items.count).to eq(4)
    expect(raw_item[:name]).to eq("Best Item")
    expect(raw_item[:description]).to_not eq(nil)
    expect(raw_item[:created_at]).to eq(nil)
    expect(raw_item[:updated_at]).to eq(nil)
  end

  it "can return one specific item" do
    item = create(:item, name: "Expected Item")
    expect(item.id).to eq(1)
    id = item.id

    get "/api/v1/items/1"
    expect(response).to be_success
    expect(response.status).to eq(200)

    raw_item = JSON.parse(response.body, symbolize_names: true)

    expect(raw_item[:id]).to eq(1)
    expect(raw_item[:name]).to eq("Expected Item")
    expect(raw_item[:description]).to be_truthy
    expect(raw_item[:image_url]).to be_truthy
    expect(raw_item[:create_at]).to be(nil)
    expect(raw_item[:updated_at]).to be(nil)
  end

  it "can send a request to delete item" do
    item = create(:item)
    expect(Item.count).to eq(1)

    delete "/api/v1/items/1"
    expect(response).to be_success
    expect(response.status).to eq(204)

    expect(Item.count).to eq(0)
  end

  it "can send request to create item" do
    list = create_list(:item, 3)
    expect(Item.count).to eq(3)

    post "/api/v1/items?name=MyItem&description=NewDescription&image_url=NewImageUrl"
    expect(response).to be_success
    expect(response.status).to eq(201)

    new_item = JSON.parse(response.body, symbolize_names: true)[:item]

    expect(Item.count).to eq(4)
    expect(Item.last.name).to eq(new_item[:name])
    expect(Item.last.description).to eq(new_item[:description])
    expect(Item.last.image_url).to eq(new_item[:image_url])
    expect(new_item[:created_at]).to be_truthy
  end
end
