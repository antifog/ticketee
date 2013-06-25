require 'spec_helper'

feature "Creating Tickets" do
  let!(:user) { Factory(:confirmed_user) }
  let!(:project) do
    project = Factory(:project, :name => "Internet Explorer")
    project.update_attribute(:user, user)
    project
  end

  before do
    sign_in_as!(user)
    visit '/'
    click_link "Internet Explorer"
    click_link "New Ticket"
  end
  
  scenario "Creating a ticket" do
    fill_in "Title", :with => "Non-standards compliance"
    fill_in "Description", :with => "My pages are ugly!"
    click_button "Create Ticket"
    page.should have_content("Ticket has been created.")
  end
  
  scenario "Creating a ticket without valid attributes fails" do
    click_button "Create Ticket"
    page.should have_content("Ticket has not been created.")
    page.should have_content("Title can't be blank")
    page.should have_content("Description can't be blank")
  end

  scenario "Description must be longer than 10 characters" do
    fill_in "Title", :with => "Non-standards compliance"
    fill_in "Description", :with => "it sucks"
    click_button "Create Ticket"
    page.should have_content("Ticket has not been created.")
    page.should have_content("Description is too short")
  end

end
