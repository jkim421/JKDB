# JKDB
## Summary
JKDB is an ORM library modeled on ActiveRecord from Ruby on Rails that provides a convenient interface to interact with databases in SQLite.

## Features
### Create and Update Rows
Users can create and insert new records for tables in their database or update existing records.

``` ruby
def initialize(params = {})
  params.each do |col, val|
    col_sym = col.to_sym

    raise "unknown attribute '#{col_sym}'" unless
      self.class.columns.include?(col_sym)

    self.send("#{col_sym}=", val)
  end
end
```

``` ruby
def insert
  cols = self.class.columns.drop(1)
  cols_str = cols.map { |col| col.to_s }.join(", ")

  marks = []
  cols.length.times { |n| marks << "?" }
  marks = marks.join(", ")

  row = DBConnection.execute(<<-SQL, *self.attribute_values.drop(1))
    INSERT INTO
      #{self.class.table_name} (#{cols_str})
    VALUES
      (#{marks})
  SQL

  self.id = DBConnection.last_insert_row_id
end
```

### Searching
Users can search for specific records in the database by `id` using the `.find(id)` method, or by specific column values using `.where(params)` and providing a hash of the desired parameters.

``` ruby
def where(params)
  cols = params.keys.map { |col| "#{col} = ?" }.join(" AND ")
  vals = params.values
  
  records = DBConnection.execute(<<-SQL, *vals)
    SELECT
      *
    FROM
      #{self.table_name}
    WHERE
      #{cols}
  SQL

  self.parse_all(records)
end
```

### Associations
JKDB allows users to define the `belongs_to`, `has_many`, and `has_one_through` associations of their relational database in their class definitions. For the first two associations, users must provide the name of the foreign key but default values are provided for the primary keys and class names if table names are standardized. Otherwise, users can provide a hash to define the primary key and class name for the association.

``` ruby
class Fighter < SQLObject
  attr_accessor :id, :name, :ranking, :division_id

  belongs_to :division
  has_one_through :promotion, :division, :promotion

  finalize!
end
```

``` ruby
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
```

## Using the Demo
1. Clone this repo
2. `cd JKDB/`
3. `bundle install`
4. `sqlite3 'mma.db' < 'mma.sql'`
5. Load `pry` or `irb`
6. Run `load 'jkdb.rb'`
6. Experiment with the methods below!

## Defined Methods
### Database
* `DBConnection.open(db_file)`
* `DBConnection.instance`

### Tables
* `::columns`
* `::all`
* `::find(id)`
* `::where(search_params)`
* `::table_name=`

### Records
* `#attributes`
* `#attribute_values`
* `#{attribute}`
* `#{attribute}=`
* `#save`
