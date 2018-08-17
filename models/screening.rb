require_relative('../db/sql_runner.rb')

class Screening
  attr_reader :id
  attr_accessor :showtime, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @showtime = options['showtime']
    @film_id = options['film_id'].to_i if options['film_id']
  end

  def save()
    sql = "INSERT INTO screenings
    (showtime, film_id)
    VALUES
    ($1, $2)
    RETURNING id"
    values = [@showtime, @film_id]
    screenings = SqlRunner.run(sql, values).first
    return @id = screenings['id'].to_i
  end

  def update()
    sql = "UPDATE screenings
    SET (showtime, film_id) =
    ($1, $2)
    WHERE id = $3"
    values = [@showtime, @film_id, @id]
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

  def self.delete_all()
    sql = "DELETE FROM screenings"
    values = []
    SqlRunner.run(sql, values)
  end

end
