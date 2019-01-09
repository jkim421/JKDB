require_relative 'assoc_options'
require 'active_support/inflector'

class BelongsToOptions < AssocOptions
  def initialize(other_class_name, options = {})
    belongs = {
      foreign_key: "#{other_class_name}_id".to_sym,
      primary_key: :id,
      class_name: other_class_name.to_s.singularize.camelcase
    }

    belongs.keys.each do |assoc|
      self.send("#{assoc}=", options[assoc] || belongs[assoc])
    end
  end
end
