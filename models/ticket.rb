require_relative('../db/sql_runner.sql')

class Ticket
  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i if options['customer_id']
    @film_id = options['film_id'].to_i if options['film_id']
  end

  def save()
    sql = "INSERT INTO tickets
    (id, customer_id, film_id)
    VALUES
    ($1, $2, $3)
    RETURNING id"
    values = [@id, @customer_id, @film_id]
    ticket = SqlRunner.run(sql, values).first
    return @id = ticket['id'].to_i
  end

  def update()
    sql = "UPDATE tickets
    SET (customer_id, film_id, id) =
    ($1, $2)
    WHERE id = $3"
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM ticket"
    values = []
    returned_array = SqlRunner.run(sql, values)
    result = returned_array.map{|entry| Ticket.new(entry)}
    return result
  end

  def self.delte_all()
    sql = "DELETE FROM tickets"
    values = []
    SqlRunner.run(sql, values)
  end

end
