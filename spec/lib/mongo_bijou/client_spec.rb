describe MongoBijou::Client do
  let(:mongo_client) { MongoBijou::Client.instance }

  it { mongo_client.respond_to? :client }
  it { mongo_client.respond_to? :db_name }
  it { mongo_client.respond_to? :db_name= }
  it { expect(mongo_client.client).is_a? Mongo::Client }
  it { expect(mongo_client.db_name).to eq 'default' }
end
