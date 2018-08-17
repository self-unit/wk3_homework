require_relative('../db/sql_runner.sql')

class Screening
  attr_reader :id
  attr_accessor :times, :film_id, :ticket_id

  def initialize(options)
    @id = options['id']
    @times = options['times']
    @film_id = options['film_id']
    @ticket_id = options['ticket_id']
  end

  def save()
    sql = "INSERT INTO screenings
    (id, times, film_id, ticket_id)
    VALUES
    ($1, $2, $3, $4)
    RETURNING id"
    values = [@id, @times, @film_id, @ticket_id]
    screenings = SqlRunner.run(sql, values).first
    return @id = screenings['id'].to_i
  end

  def update()
    sql = "UPDATE screenings
    SET (times, film_id, ticket_id, id) =
    ($1, $2, $3)
    WHERE id = $4"
    values = [@times, @film_id, @ticket_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screenings
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    values = []
    returned_array = SqlRunner.run(sql, values)
    result = returned_array.map{|entry| Screening.new(entry)}
    return result
  end

  def self.delte_all()
    sql = "DELETE FROM screenings"
    values = []
    SqlRunner.run(sql, values)
  end


end
