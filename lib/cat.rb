require_relative '01_sql_object'

class Cat < SQLObject
  self.finalize!
end
