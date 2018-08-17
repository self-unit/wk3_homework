DROP TABLE screenings;
DROP TABLE tickets;
DROP TABLE films;
DROP TABLE customers;
------------------------
CREATE TABLE customers (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  funds INT2
);

CREATE TABLE films (
  id SERIAL8 PRIMARY KEY,
  title VARCHAR(255),
  price INT2
);

CREATE TABLE tickets (
  id SERIAL8 PRIMARY KEY,
  customer_id INT8 REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT8 REFERENCES films(id) ON DELETE CASCADE
);

CREATE TABLE screenings (
  id SERIAL8 PRIMARY KEY,
  times VARCHAR(255),
  film_id INT8 REFERENCES films(id) ON DELETE CASCADE,
  ticket_id INT8 REFERENCES tickets(id) ON DELETE CASCADE
);
