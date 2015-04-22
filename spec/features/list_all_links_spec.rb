feature 'User browses the list of links' do

  before(:each) do
    Link.create(url: 'http://www.makersacademy.com',
                title: 'Makers',
                tags: [Tag.first_or_create(text: 'education')])
    Link.create(url: 'http://www.google.com',
                title: 'Google',
                tags: [Tag.first_or_create(text: 'search')])
    Link.create(url: 'http://www.bing.com',
                title: 'Bing',
                tags: [Tag.first_or_create(text: 'search')])
    Link.create(url: 'http://www.code.org',
                title: 'Code.org',
                tags: [Tag.first_or_create(text: 'education')])
  end

  scenario 'when on the homepage' do
    visit '/'
    expect(page).to have_content('Makers')
  end

  scenario 'filtered by a tag' do
    visit 'tags/search'
    expect(page).not_to have_content('Makers')
    expect(page).not_to have_content('Code.org')
    expect(page).to have_content('Google')
    expect(page).to have_content('Bing')
  end

end
