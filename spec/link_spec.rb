require 'link'
describe Link do

  context 'Demonstration of how datamapper works' do
    it 'is created and then retrieved from DB' do
      # db should be empty
      expect(described_class.count).to eq(0)

      # creates link in the db
      described_class.create(title: 'Makers',
                             url: 'http://www.makersacademy.com/')

      # check how many links are in db
      expect(described_class.count).to eq(1)
      # get first link
      link = described_class.first

      # check correct info
      expect(link.url).to eq('http://www.makersacademy.com/')
      expect(link.title).to eq('Makers')
      # Get rid of link
      link.destroy

      expect(described_class.count).to eq(0)
    end
  end
end
