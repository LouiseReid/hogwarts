require_relative '../db/sql_runner'
require_relative 'house'


class Student

  attr_reader :id
  attr_accessor :first_name, :last_name, :house_id, :age

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @house_id = options['house_id'].to_i
    @age = options['age'].to_i()
  end

  def save()
    sql = "INSERT INTO students(first_name, last_name, house_id, age)
    VALUES($1, $2, $3, $4) RETURNING id;"
    values = [@first_name, @last_name, @house_id, @age]
    student = SqlRunner.run(sql, values).first
    @id = student['id'].to_i()
  end

  def self.all()
    sql = "SELECT * FROM students;"
    values = []
    students = SqlRunner.run(sql, values)
    result = students.map { |student| Student.new(student)  }
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM students WHERE id = $1;"
    values = [id]
    students = SqlRunner.run(sql, values)
    result = students.map { |student| Student.new(student) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM students;"
    values = []
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM students where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def house_of_student()
    sql = "SELECT * FROM houses WHERE id = $1;"
    values = [@house_id]
    results = SqlRunner.run(sql, values)
    house = results[0]
    return House.new(house)
  end
end
