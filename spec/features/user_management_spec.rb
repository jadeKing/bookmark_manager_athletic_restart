feature 'User signs up' do
  scenario 'when they are a new visitor' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, test@testable.com')
    expect(User.first.email).to eq('test@testable.com')
  end

  def sign_up(email = 'test@testable.com',
              password = 'oranges!')
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email, with: email
    fill_in :password, with: password
    click_button 'Sign up'
  end

end
