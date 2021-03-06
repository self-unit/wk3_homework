require_relative('../db/sql_runner.rb')

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
    (title, price)
    VALUES
    ($1, $2)
    RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    return @id = film['id'].to_i
  end

  def update()
    sql = "UPDATE films
    SET (title, price) =
    ($1, $2)
    WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    INNER JOIN screenings
    ON screenings.id = tickets.screening_id
    WHERE screenings.film_id = $1"
    values = [@id]
    customer_data = SqlRunner.run(sql, values)
    return customer_data.map{|customer| Customer.new(customer)}
  end

  def count_customers()
    customer_data = self.customers
    return customer_data.count
  end

  def tickets()
    sql = "SELECT tickets.* FROM tickets
    INNER JOIN screenings
    ON tickets.screening_id = screenings.id
    WHERE screenings.film_id = $1"
    values = [@id]
    ticket_data = SqlRunner.run(sql, values)
    return ticket_data.map{|ticket| Ticket.new(ticket)}
  end

  def popular_time()
    ticket_data = self.tickets
    time_id = ticket_data.map{|ticket| ticket.screening_id}
    duplicate_count = Hash.new(0)
    time_id.each do |screening_id|
      duplicate_count[screening_id] += 1
    end
    sorted_duplicates = duplicate_count.sort_by {|key, value| value}
    popular_id = sorted_duplicates.last[0]
    sql = "SELECT * FROM screenings
    WHERE screenings.id = $1"
    values = [popular_id]
    most_popular_time = SqlRunner.run(sql, values)
    return most_popular_time.map{|time| Screening.new(time)}
  end

  def attendance()
    ticket_data = self.tickets
    return ticket_data.count()
  end

  def delete()
    sql = "DELETE FROM films
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM films"
    values = []
    returned_array = SqlRunner.run(sql, values)
    result = returned_array.map{|entry| Film.new(entry)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql, values)
  end

end
