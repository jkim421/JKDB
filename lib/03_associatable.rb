require_relative '02_searchable'
require 'active_support/inflector'
require 'byebug'

class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    self.model_class.table_name
  end
end

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

class HasManyOptions < AssocOptions
  def initialize(other_class_name, self_class_name, options = {})
    has_many = {
      foreign_key: "#{self_class_name.underscore}_id".to_sym,
      primary_key: :id,
      class_name: other_class_name.to_s.singularize.camelcase
    }

    has_many.keys.each do |assoc|
      self.send("#{assoc}=", options[assoc] || has_many[assoc])
    end
  end
end

module Associatable
  def belongs_to(other_class_name, options = {})
    options = BelongsToOptions.new(other_class_name, options)

    define_method(other_class_name) do
      fkey = self.send(options.foreign_key)
      model = options.model_class
      debugger
      model.where(options.primary_key => fkey).first
    end
  end

  def has_many(name, options = {})
    # ...
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  extend Associatable
end
