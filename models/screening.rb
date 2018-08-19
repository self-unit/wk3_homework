require_relative('../db/sql_runner.rb')

class Screening
  attr_reader :id
  attr_accessor :showtime, :capacity, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @showtime = options['showtime']
    @capacity = options['capacity'].to_i if options ['capacity']
    @film_id = options['film_id'].to_i if options['film_id']
  end

  def save()
    sql = "INSERT INTO screenings
    (showtime, capacity, film_id)
    VALUES
    ($1, $2, $3)
    RETURNING id"
    values = [@showtime, @capacity, @film_id]
    screenings = SqlRunner.run(sql, values).first
    return @id = screenings['id'].to_i
  end

  def update()
    sql = "UPDATE screenings
    SET (showtime, capacity, film_id) =
    ($1, $2, $3)
    WHERE id = $4"
    values = [@showtime, @capacity, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def popular_time()
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
