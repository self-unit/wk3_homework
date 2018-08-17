require_relative('../db/sql_runner.sql')

class Film
  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films
    (id, title, price)
    VALUES
    ($1, $2, $3)
    RETURNING id"
    values = [@id, @title, @price]
    film = SqlRunner.run(sql, values).first
    return @id = film['id'].to_i
  end

  def update()
  end

  def delete()
  end

  def self.all()
    sql = "SELECT * FROM films"
    values = []
    returned_array = SqlRunner.run(sql, values)
    result = returned_array.map{|entry| Film.new(entry)}
    return result
  end

  def self.delte_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql, values)
  end

end
