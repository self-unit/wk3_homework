require_relative('../db/sql_runner.rb')

class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers
    (name, funds)
    VALUES
    ($1, $2)
    RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    return @id = customer['id'].to_i
  end

  def screenings()
    sql = "SELECT screenings.* FROM screenings
    INNER JOIN tickets
    ON tickets.screening_id = screenings.id
    WHERE tickets.customer_id = $1"
    values = [@id]
    screenings_data = SqlRunner.run(sql, values)
    return screenings_data.map{|screening| Screening.new(screening)}
  end

  def films()
    screenings = self.screenings()
    film_ids = screenings.map{|showing| showing.film_id}
    sql = "SELECT films.* FROM films
    INNER JOIN screenings
    ON screenings.film_id = films.id
    WHERE screenings.id = $!"
    values = [film_ids]
    screenings_data = SqlRunner.run(sql, values)
    # film_ids = screenings.map{|screening| screening.film_id}
    # films = film_ids.each do |film_id|
    #   sql = "SELECT * FROM films
    #   WHERE films.id = $1"
    #   values = [film_id]
    #   SqlRunner.run(sql, values)
    # end
    # return films
  end

  def tickets()
  end

  def buy_ticket()
  end

  def update()
    sql = "UPDATE customers
    SET (name, funds) =
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

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

end
