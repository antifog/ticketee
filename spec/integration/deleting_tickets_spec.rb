require 'spec_helper'

feature 'Deleting tickets' do
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
  end

  scenario "Deleting a ticket" do
    click_link "Delete Ticket"
    page.should have_content("Ticket has been deleted.")
    page.current_url.should == project_url(project)
  end
end
