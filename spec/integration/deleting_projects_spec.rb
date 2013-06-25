require 'spec_helper'

feature "Deleting projects" do

  let!(:user) { Factory(:confirmed_user) }
  let!(:project) do
    project = Factory(:project, :name => "TextMate 2")
    project.update_attribute(:user, user)
    project
  end

  before do
    sign_in_as!(user)
  end

  scenario "Deleting a project" do
    visit "/"
    click_link "TextMate 2"
    click_link "Delete Project"
    page.should have_content("Project has been deleted.")
    
    visit "/"
    page.should_not have_content("TextMate 2")
  end
end
