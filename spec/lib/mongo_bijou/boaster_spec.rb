describe MongoBijou::Boaster do
  let(:sample) do
    sample = Sample.new
    sample.some_attr = 0
    sample
  end
  let(:id) { sample.mongo_store }

  it { subject.respond_to? :find }

  it { expect(Sample.find(id)).eql? sample }
  it { expect(Sample.all).is_a? Array }
end
