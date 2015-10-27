describe MongoBijou::Crusher do
  let(:sample) do
    sample = Sample.new
    sample.some_attr = 0
    sample
  end
  let(:crusher) { MongoBijou::Crusher.new(sample) }
  let(:hash_to_crush) { { key: 'data' } }
  let(:crush_result) { { Sample_class_name: { key: 'data' } } }
  let(:to_hash_result) { { some_attr: 0 } }

  it { expect(crusher.crush(hash_to_crush)).to eq crush_result }
  it { expect(crusher.to_hash(sample)).to eq to_hash_result }
end
