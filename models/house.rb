require_relative '../db/sql_runner'


class House

  attr_reader :id
  attr_accessor :name

  def initialize(options)
      @id = options['id'].to_i()
      @name = options['name']
  end

  def save
    sql = "INSERT INTO houses(name)
    VALUES($1) RETURNING id;"
    values = [@name]
    house = SqlRunner.run(sql, values).first
    @id = house['id'].to_i()
  end

  def self.delete_all
    sql = "DELETE FROM houses"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM houses;"
    values = []
    houses = SqlRunner.run(sql, values)
    result = houses.map { |house| House.new(house)  }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM houses WHERE id = $1;"
    values = [id]
    houses = SqlRunner.run(sql, values)
    result = houses.map { |house| House.new(house) }
    return result
  end

end
