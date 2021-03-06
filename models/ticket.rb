require_relative('../db/sql_runner.rb')

class Ticket
  attr_reader :id
  attr_accessor :customer_id, :screening_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i if options['customer_id']
    @screening_id = options['screening_id'].to_i if options['screening_id']
  end

  def save()
    sql = "INSERT INTO tickets
    (customer_id, screening_id)
    VALUES
    ($1, $2)
    RETURNING id"
    values = [@customer_id, @screening_id]
    ticket = SqlRunner.run(sql, values).first
    return @id = ticket['id'].to_i
  end

  def update()
    sql = "UPDATE tickets
    SET (customer_id, screening_id) =
    ($1, $2)
    WHERE id = $3"
    values = [@customer_id, @screening_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    values = []
    returned_array = SqlRunner.run(sql, values)
    result = returned_array.map{|entry| Ticket.new(entry)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    values = []
    SqlRunner.run(sql, values)
  end

end
