module Associatable
  def belongs_to(other_class_name, options = {})
    self.assoc_options[other_class_name] = BelongsToOptions.new(other_class_name, options)
    define_method(other_class_name) do
      assoc = self.class.assoc_options[other_class_name]
      fkey = self.send(assoc.foreign_key)
      model = assoc.model_class
      model.where(assoc.primary_key => fkey).first
    end
  end

  def has_many(other_class_name, options = {})
    self.assoc_options[other_class_name] = HasManyOptions.new(other_class_name, self.table_name, options)
    define_method(other_class_name) do
      assoc = self.class.assoc_options[other_class_name]
      fkey = self.send(assoc.primary_key)
      model = assoc.model_class
      model.where(assoc.foreign_key => fkey)
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end

  def has_one_through(name, through_name, source_name)
    through_options = @assoc_options[through_name]
    define_method(name) do
      source_options = through_options.model_class.assoc_options[source_name]
      record = DBConnection.execute(<<-SQL, self.send(through_options.foreign_key))
        SELECT
          #{source_options.table_name}.*
        FROM
          #{through_options.table_name}
        JOIN
          #{source_options.table_name} ON #{through_options.table_name}.#{source_options.foreign_key} = #{source_options.table_name}.#{source_options.primary_key}
        WHERE
          #{through_options.table_name}.#{through_options.primary_key} = ?
      SQL
      return source_options.model_class.parse_all(record).first
    end
  end
end
