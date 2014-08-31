require_relative '../spec_helper'

feature "Users" do
	scenario "Signing up a user" do
		visit '/users/sign_up'

		fill_in 'user[username]', with: 'iphilippas'
		fill_in 'user[email]', with: 'iphilippas@gmail.com'
		fill_in 'user[password]', with: 'q1w2e3r4'
		fill_in 'user[password_confirmation]', with: 'q1w2e3r4'
		
		expect(page).to have_content('Log Out');
		expect(page).to have_content('iphilippas');

	end
end
