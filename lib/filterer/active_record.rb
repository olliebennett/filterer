module Filterer
  module ActiveRecord
    extend ActiveSupport::Concern

    included do
      def self.filterer(params)
        filterer_class.new(params, starting_query: all)
      end

      def self.filterer_class
        const_get("#{self.name}Filterer")
      rescue
        fail "Looked for #{self.name}Filterer and couldn't find one!"
      end
    end
  end
end

ActiveRecord::Base.send(:include, Filterer::ActiveRecord)
