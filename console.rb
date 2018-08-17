require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')
require_relative('models/screening.rb')

require('pry-byebug')

Customer.delete_all
Film.delete_all
Screening.delete_all
Ticket.delete_all

customer1 = Customer.new('name' => 'Jerry', 'funds' => '300')
customer1.save()
customer2 = Customer.new('name' => 'Tom', 'funds' => '10')
customer2.save()
customer3 = Customer.new('name' => 'Cheeser', 'funds' => '100')
customer3.save()

film1 = Film.new('title' => 'ACME', 'price' => '5')
film1.save()
film2 = Film.new('title' => 'Incredibles', 'price' => '10')
film2.save()

screening1 = Screening.new('showtime' => '10:00', 'film_id' => film1.id)
screening1.save()
screening2 = Screening.new('showtime' => '14:00', 'film_id' => film1.id)
screening2.save()
screening3 = Screening.new('showtime' => '16:00', 'film_id' => film1.id)
screening3.save()
screening4 = Screening.new('showtime' => '15:00', 'film_id' => film2.id)
screening4.save()
screening5 = Screening.new('showtime' => '17:00', 'film_id' => film2.id)
screening5.save()
screening6 = Screening.new('showtime' => '19:00', 'film_id' => film2.id)
screening6.save()

ticket1 = Ticket.new('customer_id' => customer1.id, 'screening_id' => screening1.id)
ticket1.save()
ticket2 = Ticket.new('customer_id' => customer2.id, 'screening_id' => screening2.id)
ticket2.save()
ticket3 = Ticket.new('customer_id' => customer3.id, 'screening_id' => screening3.id)
ticket3.save()
ticket4 = Ticket.new('customer_id' => customer1.id, 'screening_id' => screening4.id)
ticket4.save()
ticket5 = Ticket.new('customer_id' => customer2.id, 'screening_id' => screening5.id)
ticket5.save()
ticket6 = Ticket.new('customer_id' => customer3.id, 'screening_id' => screening6.id)
ticket6.save()
ticket7 = Ticket.new('customer_id' => customer3.id, 'screening_id' => screening6.id)
ticket7.save()
ticket8 = Ticket.new('customer_id' => customer3.id, 'screening_id' => screening2.id)
ticket8.save()
ticket9 = Ticket.new('customer_id' => customer1.id, 'screening_id' => screening1.id)
ticket9.save()
ticket10 = Ticket.new('customer_id' => customer2.id, 'screening_id' => screening3.id)
ticket10.save()
ticket11 = Ticket.new('customer_id' => customer2.id, 'screening_id' => screening4.id)
ticket11.save()
ticket12 = Ticket.new('customer_id' => customer2.id, 'screening_id' => screening1.id)
ticket12.save()

binding.pry
nil
