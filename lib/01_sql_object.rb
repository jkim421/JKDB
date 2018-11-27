require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns

    table_vals = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
      end
    SQL

    columns = table_vals.first
    @columns = columns.map! { |col| col.to_sym }
  end

  def self.finalize!
    self.columns.each do |col|
      define_method(col) { self.attributes[col] }
      define_method("#{col}=") do |val|
        self.attributes[col] = val
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name  || self.name.tableize
  end

  def self.all
    records = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    self.parse_all(records)
  end

  def self.parse_all(results)
    results.map { |result| self.new(result) }
  end

  def self.find(id)
    record = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        id = ?
    SQL
    self.parse_all(record).first
  end

  def initialize(params = {})
    params.each do |key, val|
      key_sym = key.to_sym
      raise "unknown attribute '#{key_sym}'" unless self.class.columns.include?(key_sym)
      self.send("#{key_sym}=", val)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |col| self.attributes[col] }
  end

  def insert
    cols = self.class.columns.drop(1)
    cols_str = cols.map { |col| col.to_s }.join(", ")

    marks = []
    cols.length.times { |n| marks << "?" }
    marks = marks.join(", ")

    record = DBConnection.execute(<<-SQL, *self.attribute_values.drop(1))
      INSERT INTO
        #{self.class.table_name} (#{cols_str})
      VALUES
        (#{marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    cols = self.class.columns.map { |col| "#{col} = ?" }
    cols = cols.join(", ")

    DBConnection.execute(<<-SQL, *self.attribute_values, self.id)
      UPDATE
        #{self.class.table_name}
      SET
        #{cols}
      WHERE
        id = ?
    SQL
  end

  def save
    self.id.nil? ? self.insert : self.update
  end
end
