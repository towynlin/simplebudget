Given /^no user exists with an email of "(.*)"$/ do |email|
  User.find(:first, :conditions => { :email => email }).should be_nil
end

Given /^I am a user named "([^"]*)" with an email "([^"]*)" and password "([^"]*)"$/ do |name, email, password|
  User.new(:name => name,
            :email => email,
            :password => password,
            :password_confirmation => password).save!
end

Then /^I should be already signed in$/ do
  step %{I should see "logout"}
end

Given /^I am signed up as "(.*)\/(.*)"$/ do |email, password|
  step %{I am not logged in}
  step %{I go to the sign up page}
  step %{I fill in "Email" with "#{email}"}
  step %{I fill in "Password" with "#{password}"}
  step %{I fill in "Password confirmation" with "#{password}"}
  step %{I press "Sign up"}
  step %{I should see "You have signed up successfully. If enabled, a confirmation was sent to your e-mail."}
  step %{I am logout}
end

Then /^I sign out$/ do
  visit('/users/sign_out')
end

Given /^I am logout$/ do
  step %{I sign out}
end

Given /^I am not logged in$/ do
  step %{I sign out}
end

When /^I sign in as "(.*)\/(.*)"$/ do |email, password|
  step %{I am not logged in}
  step %{I go to the sign in page}
  step %{I fill in "Email" with "#{email}"}
  step %{I fill in "Password" with "#{password}"}
  step %{I press "Sign in"}
end

Then /^I should be signed in$/ do
  step %{I should see "Signed in successfully."}
end

When /^I return next time$/ do
  step %{I go to the home page}
end

Then /^I should be signed out$/ do
  step %{I should see "sign up"}
  step %{I should see "login"}
  step %{I should not see "logout"}
end

When /^I go to the sign in page$/ do
  visit new_user_session_path
end

Then /^I should see "([^"]*)"$/ do |arg1|
  page.should have_content(arg1)
end

When /^I go to the homepage$/ do
  visit '/'
end

Then /^I go to the home page$/ do
  visit '/'
end

Given /^I am on the home page$/ do
  step %{I go to the home page}
end

Given /^I go to the sign up page$/ do
  click_on 'sign up'
end

Given /^I fill in the following:$/ do |table|
  table.raw.each do |row|
    fill_in row[0], with: row[1]
  end
end

When /^I follow "([^"]*)"$/ do |arg1|
  click_on arg1
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |arg1, arg2|
  fill_in arg1, with: arg2
end

When /^I press "([^"]*)"$/ do |arg1|
  click_on arg1
end

Then /^I should not see "([^"]*)"$/ do |arg1|
  page.should_not have_content(arg1)
end

Then /^the "([^"]*)" field should contain "([^"]*)"$/ do |arg1, arg2|
  page.should have_xpath("//input[@name='user[#{arg1.downcase}]' and @value='#{arg2}']")
end
