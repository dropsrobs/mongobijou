describe MongoBijou::Murderer do
  let(:sample) do
    sample = Sample.new
    sample.some_attr = 0
    sample
  end
  let(:id) { sample.mongo_store }

  before { sample.mongo_store }

  it { subject.respond_to? :remove }
  it { expect { Sample.remove(id) }.to change { Sample.all.length }.by 1 }
  it { expect { Sample.drop }.to change { Sample.all.length } }
end
