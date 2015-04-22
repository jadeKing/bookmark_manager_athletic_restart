feature 'User adds a new link' do
  scenario 'when on the homepage' do
    # check db empty
    expect(Link.count).to eq(0)
    visit '/'
    # add link for testing
    add_link('http://www.makersacademy.com/', 'Makers')
    # check link added
    expect(Link.count).to eq(1)
    link = Link.first
    # check attribute values
    expect(link.url).to eq('http://www.makersacademy.com/')
    expect(link.title).to eq('Makers')
  end

  scenario 'with tags' do
    visit '/'
    add_link('http://www.makersacademy.com/',
             'Makers',
             %w(education ruby))
    link = Link.first
    # checkingfor instanceoftag not string
    expect(link.tags.map(&:text)).to include('education', 'ruby')
  end

  # mock adding link
  # tag default so that it still passes forst test
  def add_link(url, title, tags = [])
    within('#new-link') do
      fill_in 'url', with: url
      fill_in 'title', with: title
      fill_in 'tags', with: tags.join(' ')
      click_button 'Add link'
    end
  end

end
