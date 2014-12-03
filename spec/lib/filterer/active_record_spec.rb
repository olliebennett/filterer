require 'spec_helper'

describe 'ActiveRecord' do
  it 'finds for a model' do
    included = Person.create(name: 'b')
    excluded = Person.create(name: 'c')

    params = { name: 'b' }
    expect(PersonFilterer).to receive(:new).with(params, anything).and_call_original
    filterer = Person.filterer(params)

    expect(filterer.results).to eq [included]
  end

  it 'finds for a relation' do
    company = Company.create(name: 'foo')
    included = Person.create(company: company)
    excluded = Person.create

    filterer = Company.first.people.filterer({})
    expect(filterer.results).to eq [included]
  end

  it 'throws the correct error when not found' do
    expect do
      Company.all.filterer({})
    end.to raise_error(/CompanyFilterer/)
  end
end
