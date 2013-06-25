require 'spec_helper'

feature "Editing Projects" do
  let!(:user) { Factory(:confirmed_user) }
  let!(:project) do
    project = Factory(:project, :name => "TextMate 2")
    project.update_attribute(:user, user)
    project
  end

  before do
    sign_in_as!(user)
    visit "/"
    click_link "TextMate 2"
    click_link "Edit Project"
  end
  
  scenario "Updating a project" do
    fill_in "Name", :with => "TextMate 2 beta"
    click_button "Update Project"
    page.should have_content("Project has been updated.")
  end

  scenario "Updating a project with invalid attributes is bad" do
    fill_in "Name", :with => ""
    click_button "Update Project"
    page.should have_content("Project has not been updated.")
  end
end
