# encoding: UTF-8

require 'spec_helper'

include Rosette::Preprocessors

describe NormalizationPreprocessor::Configurator do
  let(:configurator) { NormalizationPreprocessor::Configurator.new }

  describe '#applies_to?' do
    it 'sets applies_to_proc' do
      configurator.applies_to? { :applies_to }
      expect(configurator.applies_to_proc).to_not be_nil
      expect(configurator.applies_to_proc.call).to eq(:applies_to)
    end
  end

  describe '#set_normalization_form' do
    it 'sets the normalization form in the configurator' do
      configurator.set_normalization_form(:nfkd)
      expect(configurator.form).to eq(:nfkd)
    end

    it 'raises an error when given an invalid normalization from' do
      expect { configurator.set_normalization_form(:foobar) }.to(
        raise_error(ArgumentError)
      )
    end
  end
end
