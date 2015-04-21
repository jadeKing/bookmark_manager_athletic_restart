feature 'User browses the list of links' do

  before(:each) do
    Link.create(url: 'http://www.makersacademy.com',
                title: 'Makers')
  end

  scenario 'when on the homepage' do
    visit '/'
    expect(page).to have_content('Makers')
  end

end
