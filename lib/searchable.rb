require_relative 'db_connection'

module Searchable
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
end
