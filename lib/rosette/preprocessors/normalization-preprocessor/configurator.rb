# encoding: UTF-8

require 'twitter_cldr'

module Rosette
  module Preprocessors
    class NormalizationPreprocessor

      class Configurator
        attr_reader :applies_to_proc, :form

        def initialize
          @form = TwitterCldr::Normalization::DEFAULT_NORMALIZER
        end

        # Does the object passed to this block
        # qualify for pre-processing? You decide.
        def applies_to?(&block)
          @applies_to_proc = block
        end

        def set_normalization_form(form)
          if TwitterCldr::Normalization::VALID_NORMALIZERS.include?(form)
            @form = form
          else
            raise ArgumentError,
              "Unrecognized normalization form '#{form}'"
          end
        end
      end

    end
  end
end
