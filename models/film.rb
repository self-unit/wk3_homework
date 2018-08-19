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
    return ticket_data['screening_id'].sort
    # return ticket_data.sort{|x,y| y <=> x}
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
