require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')

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

screening1 = Screening.new('times' => '10:00, 14:00, 16:00, 18:00', 'film_id' => film1.id)
screening1.save()
screening2 = Screening.new('times' => '15:00, 17:00, 19:00', 'film_id' => film2.id)
screening2.save()

ticket1 = Ticket.new('customer_id' => customer1.id, 'film_id' => film1.id)
ticket1.save()
ticket2 = Ticket.new('customer_id' => customer2.id, 'film_id' => film1.id)
ticket2.save()
ticket3 = Ticket.new('customer_id' => customer3.id, 'film_id' => film2.id)
ticket3.save()
ticket4 = Ticket.new('customer_id' => customer1.id, 'film_id' => film2.id)
ticket4.save()

binding.pry
nil
