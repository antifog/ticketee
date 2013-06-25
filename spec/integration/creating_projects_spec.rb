require 'spec_helper'

feature 'Creating Projects' do

  before do
    user = Factory(:user, :email => "ticketee@example.com")
    user.confirm!

    visit '/'
    click_link 'New Project'
    message = "You need to sign in or sign up before continuing."
    page.should have_content(message)

    fill_in "Email", :with => "ticketee@example.com"
    fill_in "Password", :with => "password"
    click_button "Sign in"
    within("h2") { page.should have_content("New Project") }
  end

  scenario "can create a project" do
    fill_in 'Name', :with => 'TextMate 2'
    fill_in 'Description', :with => "A text-editor for OS X"
    click_button 'Create Project'
    page.should have_content('Project has been created.')
    project = Project.find_by_name("TextMate 2")
    page.current_url.should == project_url(project)
    title = "TextMate 2 - Projects - Ticketee"
    find("title").should have_content(title)
    within("#project #author") do
      page.should have_content("Created by ticketee@example.com")
    end
  end

  scenario "can not create a project without a name" do
    click_button 'Create Project'
    page.should have_content("Project has not been created.")
    page.should have_content("Name can't be blank")
  end

end
