describe MongoBijou do
  let(:sample) { Sample.new }
  let(:id) { sample.mongo_store }

  before { sample.some_attr = 0 }

  it { subject.respond_to? :config_attr }
  it { subject.respond_to? :config_attr= }
  it { subject.respond_to? :default_config }
  it { subject.respond_to? :mongo_store }

  it { expect(sample.attr_defaults).to eq some_attr: 0 }

  it { expect(id).is_a? String }
end
