require "rails_helper"

describe "Items API" do
  it "can return all items" do
    item = create(:item, name: "Best Item", description: "Best Item Description", image_url: "Image URL")
    list = create_list(:item, 3) #model objects
    expect(Item.count).to eq(4)

    get "/api/v1/items"
    expect(response).to be_success
    expect(response.status).to eq(200)
    # I receive a 200 JSON response containing all items

    raw_items = JSON.parse(response.body, symbolize_names: true)
    raw_item = raw_items.first

    expect(raw_items.count).to eq(4)
    # And each item has an id, name, description, and image_url but not the created_at or updated_at
    expect(raw_item[:name]).to eq("Best Item")
    expect(raw_item[:description]).to_not eq(nil)
    expect(raw_item[:created_at]).to eq(nil)
    expect(raw_item[:updated_at]).to eq(nil)
  end

  it "can return one specific item" do
    item = create(:item, name: "Expected Item")
    expect(item.id).to eq(1)
    id = item.id
    # When I send a GET request to `/api/v1/items/1`
    get "/api/v1/items/1"
    # I receive a 200 JSON response containing the id, name, description, and image_url but not the created_at or updated_at
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
    #When I send a DELETE request to `/api/v1/items/1`
    delete "/api/v1/items/1"
    expect(response).to be_success
    expect(response.status).to eq(204)
    ## I receive a 204 JSON response if the record is successfully deleted
    # pass in method
    raw_item = JSON.parse(response.body, symbolize_names: true)

    expect(Item.count).to eq(0)
  end

  it "can send request to create item" do
    list = create_list(:item, 3)
    expect(Item.count).to eq(3)
    # When I send a POST request to `/api/v1/items`
    # item_params in controller : with a name, description, and image_url
    post "/api/v1/items?name=NewItem&description=NewDescription&image_url=NewImageUrl"
    expect(response).to be_success
    # I receive a 201 JSON  response if the record is successfully created
    expect(response.status).to eq(201)

    new_item = JSON.parse(response.body, sumbolize_names: true)

    expect(Item.count).to eq(4)
    expect(Item.last.name).to eq(new_item[:name])
    expect(page).to have_content('NewItem')
    expect(Item.last.description).to eq(new_item[:description])
    expect(page).to have_content('NewDescription')
    expect(Item.last.image_url).to eq(new_item[:image_url])
    expect(page).to have_content('NewImageUrl')
    expect(new_item[:created_at]).to be(nil)
    expect(new_item[:name]).to be_truthy
  end
end
# * Verify that your non-GET requests work using Postman or curl. (Hint: `ActionController::API`). Why doesn't the default `ApplicationController` support POST and PUT requests?
