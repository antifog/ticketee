require 'spec_helper'

feature "Editing tickets" do
  let!(:user) { Factory(:confirmed_user) }
  let!(:project) do
    project = Factory(:project)
    project.update_attribute(:user, user)
    project
  end
  let!(:ticket) { Factory(:ticket, :project => project) }

  before do
    sign_in_as!(user)
    visit '/'
    click_link project.name
    click_link ticket.title
    click_link "Edit Ticket"
  end

  scenario "Updating a ticket" do
    fill_in "Title", :with => "Make it really shiny!"
    select "Pending", :from => "State"
    click_button "Update Ticket"
    page.should have_content "Ticket has been updated."
    within("#ticket h2") do
      page.should have_content("Make it really shiny!")
    end
    page.should_not have_content ticket.title
  end

  scenario "Updating a ticket with invalid information" do
    fill_in "Title", :with => ""
    select "Pending", :from => "State"
    click_button "Update Ticket"
    page.should have_content("Ticket has not been updated.")
  end
end
