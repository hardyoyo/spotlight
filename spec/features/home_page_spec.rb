require "spec_helper"
describe "Home page" do
  let(:exhibit_curator) { FactoryGirl.create(:exhibit_curator) }
  let(:exhibit) { Spotlight::Exhibit.default }
  before {login_as exhibit_curator}
  it "should exist by default on exhibits" do
    visit '/'
    within '.dropdown-menu' do
      click_link 'Dashboard'
    end
    click_link "Feature pages"
    expect(page).to have_selector "h3", text: "Homepage"
    expect(page).to have_selector "h3.panel-title", text: "Exhibit Home"
  end
  it "should allow users to edit the home page title" do
    visit '/'
    within '.dropdown-menu' do
      click_link 'Dashboard'
    end
    click_link "Feature pages"
    within(".home_page") do
      click_link "Edit"
    end
    fill_in "home_page_title", with: "New Home Page Title"
    click_button "Save changes"
    expect(page).to have_content("Page was successfully updated.")

    within '.dropdown-menu' do
      click_link 'Dashboard'
    end
    click_link "Feature pages"
    expect(page).to have_content "New Home Page Title"
    expect(page).to have_selector ".panel-title a", text: "New Home Page Title"
  end
  it "should allow users to edit the display_title attribute" do
    visit '/'
    within '.dropdown-menu' do
      click_link 'Dashboard'
    end

    click_link "Feature pages"

    # Choose to display the home page title
    within(".home_page") do
      check "Show title"
    end
    click_button "Save changes"

    visit spotlight.exhibit_home_page_path(exhibit, exhibit.home_page)

    # Verify the home page title is being displayed
    expect(page).to have_css("h1.page-title", text: exhibit.home_page.title)

    within '.dropdown-menu' do
      click_link 'Dashboard'
    end

    click_link "Feature pages"

    # Choose to not display the home page title
    within(".home_page") do
      uncheck "Show title"
    end
    click_button "Save changes"

    visit spotlight.exhibit_home_page_path(exhibit, exhibit.home_page)

    # Verify the home page title is not being displayed
    expect(page).not_to have_css("h1.page-title", text: exhibit.home_page.title)
  end

  describe "page options on edit form" do
    describe "show title" do
      let(:new_exhibit) { Spotlight::Exhibit.default }
      let(:home_page) { FactoryGirl.create(:home_page, display_title: false) }
      it "should be updatable from the edit page" do
        expect(home_page.display_title).to be_false

        visit spotlight.edit_exhibit_home_page_path(home_page.exhibit, home_page)
        expect(find("#home_page_display_title")).not_to be_checked

        check "Show title"
        click_button "Save changes"

        visit spotlight.edit_exhibit_home_page_path(home_page.exhibit, home_page)
        expect(find("#home_page_display_title")).to be_checked
      end
    end
  end
end
