require_relative('../db/sql_runner.sql')

class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customer
    (id, name, funds)
    VALUES
    ($1, $2, $3)
    RETURNING id"
    values = [@id, @name, @funds]
    customer = SqlRunner.run(sql, values).first
    return @id = customer['id'].to_i
  end

  def update()
    sql = "UPDATE customers
    SET (name, funds, id) =
    ($1, $2)
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    returned_array = SqlRunner.run(sql, values)
    result = returned_array.map{|entry| Customer.new(entry)}
    return result
  end

  def self.delte_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

end
