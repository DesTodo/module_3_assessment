require "rails_helper"

describe "User can search for local stores" do
  it "searches by zip" do
    visit "/"
    expect(page).to have_css(".store-search")
# And I fill in a search box with "80202" and click "search"
    fill_in 'q', with: "80202"
    click_on "Search"
# Then my current path should be "/search" (ignoring params)
    expect(current_path).to eq("/search")
# And I should see exactly 10 results
    expect(page).to have_css(".store", count: 10)
# And I should see a message that says "17 Total Stores"
    expect(page).to have_content("17 Total Stores")
  # And I should see the long name, city, distance, phone number and store type for each of the 10 results
    within first(".store") do
      expect(page).to have_css(".longName")
      expect(page).to have_css(".city")
      expect(page).to have_css(".distance")
      expect(page).to have_css(".number")
      expect(page).to have_css(".storeType")
    end
  end
end
#We want to display 10 on this page and 7 on the next. Get the first page to work first from start to finish and worry about pagination later.)
