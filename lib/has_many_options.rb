require_relative 'assoc_options'
require 'active_support/inflector'

class HasManyOptions < AssocOptions
  def initialize(other_class_name, self_class_name, options = {})
    has_many = {
      foreign_key: "#{self_class_name.underscore.singularize}_id".to_sym,
      primary_key: :id,
      class_name: other_class_name.to_s.singularize.camelcase
    }

    has_many.keys.each do |assoc|
      self.send("#{assoc}=", options[assoc] || has_many[assoc])
    end
  end
end
