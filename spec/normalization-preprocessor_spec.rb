# encoding: UTF-8

require 'spec_helper'

include Rosette::Core
include Rosette::Preprocessors

describe NormalizationPreprocessor do
  describe 'self#configure' do
    it 'yields a configurator and returns a preprocessor' do
      preprocessor = NormalizationPreprocessor.configure do |config|
        expect(config).to be_a(NormalizationPreprocessor::Configurator)
      end

      expect(preprocessor).to be_a(NormalizationPreprocessor)
    end
  end

  describe '#process_translation' do
    let(:config) { NormalizationPreprocessor::Configurator.new }
    let(:preprocessor) { NormalizationPreprocessor.new(config) }
    let(:es_phrase) { 'español' }
    let(:es_nfd_phrase) do
      [101, 115, 112, 97, 110, 204, 131, 111, 108].map(&:chr).join.force_encoding(
        Encoding::UTF_8
      )
    end
    let(:es_translation) { Translation.new(nil, :es, es_phrase) }
    let(:es_nfd_translation) { Translation.new(nil, :es, es_nfd_phrase) }

    it 'creates a new translation object' do
      preprocessor.process_translation(es_translation).tap do |new_trans|
        expect(new_trans.object_id).to_not eq(es_translation.object_id)
      end
    end

    it 'normalizes the translation using the default form' do
      expect(es_phrase.bytes.to_a).to eq(
        [101, 115, 112, 97, 195, 177, 111, 108]
      )

      preprocessor.process_translation(es_translation).tap do |new_trans|
        expect(new_trans.translation.bytes.to_a).to eq(
          [101, 115, 112, 97, 110, 204, 131, 111, 108]
        )
      end
    end

    it 'normalizes the translation using the given form' do
      config.set_normalization_form(:nfc)

      expect(es_nfd_phrase.bytes.to_a).to eq(
        [101, 115, 112, 97, 110, 204, 131, 111, 108]
      )

      preprocessor.process_translation(es_nfd_translation).tap do |new_trans|
        expect(new_trans.translation.bytes.to_a).to eq(
          [101, 115, 112, 97, 195, 177, 111, 108]
        )
      end
    end
  end
end
