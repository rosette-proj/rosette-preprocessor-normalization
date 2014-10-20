# encoding: UTF-8

require 'twitter_cldr'
require 'rosette/preprocessors'

module Rosette
  module Preprocessors

    class NormalizationPreprocessor < Preprocessor
      autoload :Configurator, 'rosette/preprocessors/normalization-preprocessor/configurator'

      def self.configure
        config = Configurator.new
        yield config if block_given?
        new(config)
      end

      def process_translation(translation)
        new_trans = process_string(translation.translation)

        translation.class.from_h(
          translation.to_h.merge(translation: new_trans)
        )
      end

      def process_string(string)
        TwitterCldr::Normalization.normalize(
          string, using: configuration.form
        )
      end

      private

      def method_for(object)
        # determine if the object implements the translation interface
        is_trans = object.respond_to?(:translation) &&
          object.class.respond_to?(:from_h) &&
          object.respond_to?(:to_h)

        if is_trans
          :process_translation
        elsif object.is_a?(String)
          :process_string
        end
      end
    end

  end
end
