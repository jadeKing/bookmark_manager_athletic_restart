feature 'User signs up' do
  scenario 'when they are a new visitor' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, test@testable.com')
    expect(User.first.email).to eq('test@testable.com')
  end

  scenario 'with a password that does not much' do
    expect { sign_up('a@a.com', 'pass', 'wrong') }.to change(User, :count).by(0)
    expect(current_path).to eq('/users')
    expect(page).to have_content('Sorry the passwords dont match')
  end

  scenario 'with an email that is already registered' do
    expect { sign_up }.to change(User, :count).by(1)
    expect { sign_up }.to change(User, :count).by(0)
    expect(page).to have_content('Email is already taken')
  end

  def sign_up(email = 'test@testable.com',
              password = 'oranges!',
              password_confirmation = 'oranges!')
    visit '/users/new'
    expect(page.status_code).to eq(200)
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password_confirmation
    click_button 'Sign up'
  end

end
