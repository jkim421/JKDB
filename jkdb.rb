require 'sqlite3'
require_relative 'lib/sql_object'
require_relative 'lib/searchable'
require_relative 'lib/associatable'
require_relative 'lib/assoc_options'
require_relative 'lib/belongs_to_options'
require_relative 'lib/has_many_options'

DBConnection.open('ufc.db')

class Fighter < SQLObject
  attr_accessor :id, :name, :ranking, :division_id

  belongs_to :division
  has_one_through :promotion, :division, :promotion
end

class Division < SQLObject
  attr_accessor :id, :name, :weight_limit, :promotion_id

  has_many :fighters
  belongs_to :promotion
end

class Promotion < SQLObject
  attr_accessor :id, :name, :country

  has_many :divisions
end
