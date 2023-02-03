CREATE TABLE "Customer" (
	"customer_id" SERIAL PRIMARY KEY,
	"first_name" VARCHAR(100),
	"last_name" VARCHAR(100),
	"phone" VARCHAR(15)
);

CREATE TABLE "Car" (
	"car_id" SERIAL PRIMARY KEY,
	"make" VARCHAR(100),
	"model" VARCHAR(100),
	"price" NUMERIC(9,2),
	"was_purchased" BOOLEAN,
	"customer_id" INTEGER,
	FOREIGN KEY ("customer_id") REFERENCES "Customer"("customer_id")
);

CREATE TABLE "Salesperson" (
	"salesperson_id" SERIAL PRIMARY KEY,
	"first_name" VARCHAR(100),
	"last_name" VARCHAR(100)
);

CREATE TABLE "Invoice" (
	"invoice_id" SERIAL PRIMARY KEY,
	"car_id" INTEGER,
	"salesperson_id" INTEGER,
	"date" DATE,
	FOREIGN KEY ("car_id") REFERENCES "Car"("car_id"),
	FOREIGN KEY ("salesperson_id") REFERENCES "Salesperson"("salesperson_id")
);

CREATE TABLE "Service_History" (
	"service_id" SERIAL PRIMARY KEY,
	"car_id" INTEGER,
	"date" DATE,
	FOREIGN KEY ("car_id") REFERENCES "Car"("car_id")
);

CREATE TABLE "Service_Ticket" (
	"ticket_id" SERIAL PRIMARY KEY,
	"service_id" INTEGER,
	"cost" NUMERIC(9,2),
	"task" VARCHAR(200),
	FOREIGN KEY ("service_id") REFERENCES "Service_History"("service_id")
);

CREATE TABLE "Mechanic" (
	"mechanic_id" SERIAL PRIMARY KEY,
	"first_name" VARCHAR(100),
	"last_name" VARCHAR(100)
);

CREATE TABLE "Maintenance_History" (
	"maint_id" SERIAL PRIMARY KEY,
	"ticket_id" INTEGER,
	"mechanic_id" INTEGER,
	FOREIGN KEY ("ticket_id") REFERENCES "Service_Ticket"("ticket_id"),
	FOREIGN KEY ("mechanic_id") REFERENCES "Mechanic"("mechanic_id")
);


CREATE OR REPLACE PROCEDURE add_customer(
	cust_id INTEGER,
	fir_name VARCHAR(100),
	las_name VARCHAR(100),
	phon VARCHAR(15)
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO "Customer" (
		"customer_id",
		"first_name",
		"last_name",
		"phone"
) VALUES (cust_id, fir_name, las_name, phon);
END;
$$

CREATE OR REPLACE PROCEDURE add_salesperson(salesp_id INTEGER, fir_name VARCHAR(100), las_name VARCHAR(100))
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO "Salesperson" ("salesperson_id", "first_name", "last_name") VALUES (salesp_id, fir_name, las_name);
END;
$$

CREATE OR REPLACE PROCEDURE add_car(carr_id INTEGER, makey VARCHAR(100), modely VARCHAR(100), pricey NUMERIC(9,2), was_purchase BOOLEAN, cust_id INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO "Car" ("car_id", "make", "model", "price", "was_purchased", "customer_id") VALUES (carr_id, makey, modely, pricey, was_purchase, cust_id);
END;
$$

CREATE OR REPLACE PROCEDURE add_invoice(inv_id INTEGER, carr_id INTEGER, sales_id INTEGER, datee DATE)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO "Invoice" ("invoice_id", "car_id", "salesperson_id", "date") VALUES (inv_id, carr_id, sales_id, datee);
END;
$$

CREATE OR REPLACE PROCEDURE add_mechanic(mechanic_id INTEGER, first_name VARCHAR(100), last_name VARCHAR(100))
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO "Mechanic" ("mechanic_id", "first_name", "last_name") VALUES ("mechanic_id", "first_name", "last_name");
END;
$$

CREATE OR REPLACE PROCEDURE add_service(service_id INTEGER, car_id INTEGER, date DATE)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO "Service_History" ("service_id", "car_id", "date") VALUES ("service_id", "car_id", "date");
END;
$$

CREATE OR REPLACE PROCEDURE add_ticket(ticket_id INTEGER, service_id INTEGER, costs NUMERIC(9,2), task VARCHAR(200))
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO "Service_Ticket" ("ticket_id", "service_id", "cost", "task") VALUES ("ticket_id", "service_id", "costs", "task");
END;
$$

CREATE OR REPLACE PROCEDURE add_maint(maint_id INTEGER, ticket_id INTEGER, mechanic_id INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO "Maintenance_History" ("maint_id", "ticket_id", "mechanic_id") VALUES ("maint_id", "ticket_id", "mechanic_id");
END;
$$


CALL add_customer(1, 'Jeff', 'Bezos', '702-661-3564');
CALL add_customer(2, 'Bob', 'The-Builder', '709-760-6446');
CALL add_customer(3, 'O', 'Bama', '881-334-1234');
CALL add_customer(4, 'Jeff', 'rey', '012-345-6789');
SELECT * FROM "Customer";

CALL add_salesperson(1, 'Thing', 'One');
CALL add_salesperson(2, 'Thing', 'Two');
CALL add_salesperson(3, 'Jim', 'Carrey');
CALL add_salesperson(4, 'Freddy', 'Fazbear');
SELECT * FROM "Salesperson";

CALL add_car(1, 'Chevy', 'Impala', 8799.99, False, NULL);
CALL add_car(2, 'Tesla', 'X', 120000.99, True, 1);
CALL add_car(3, 'Ferrari', 'Explorer', 79999.99, True, 1);
CALL add_car(4, 'Ford', 'Focus', 4.99, False, NULL);
CALL add_car(5, 'Honda', 'Civic', 20000.00, True, 4);
CALL add_car(6, 'John-Deere', 'Tractor', 9899.99, True, 2);
CALL add_car(7, 'Mustang', 'Mustang', 30000.00, False, NULL);
CALL add_car(8, 'Punch', 'Buggy', 100.00, True, 4);
SELECT * FROM "Car";

CALL add_invoice(1, 2, 3, '03/27/2015');
CALL add_invoice(2, 3, 2, '02/29/2016');
CALL add_invoice(3, 5, 4, '11/07/2003');
CALL add_invoice(4, 6, 1, '01/01/0001');
CALL add_invoice(5, 8, 1, '10/14/2008');
SELECT * FROM "Invoice";

CALL add_mechanic(1, 'Joe', 'Swift');
CALL add_mechanic(2, 'Taylor', 'Quick');
CALL add_mechanic(3, 'Gottago', 'Fast');
SELECT * FROM "Mechanic";

CALL add_service(1, 6, '2023-01-29');
CALL add_service(2, 6, '01/22/2023');
CALL add_service(3, 6, '01/15/2023');
CALL add_service(4, 5, '10/09/2019');
SELECT * FROM "Service_History";

CALL add_ticket(1, 1, 159.99, 'Front Tire Replacement');
CALL add_ticket(2, 2, 3499.99, 'Oil Change');
CALL add_ticket(3, 3, 20.00, 'Engine Replacement');
CALL add_ticket(4, 4, 89499.99, 'Labor fee for having to look at your car');
SELECT * FROM "Service_Ticket";

CALL add_maint(1, 1, 1);
CALL add_maint(2, 1, 2);
CALL add_maint(3, 1, 3);
CALL add_maint(4, 2, 2);
CALL add_maint(5, 2, 3);
CALL add_maint(6, 3, 1);
CALL add_maint(7, 4, 1);
CALL add_maint(8, 4, 3);
SELECT * FROM "Maintenance_History";

ALTER TABLE "Car"
ADD COLUMN "is_serviced" BOOLEAN DEFAULT False;

CREATE OR REPLACE PROCEDURE receive_service(
	carr_id INTEGER,
	service VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE "Car" 
	SET "is_serviced" = True
	WHERE is_serviced = False AND "carr_id" = "car_id" AND service = 'Oil Change';
END;
$$

CALL receive_service(3, 'Oil Change')

SELECT * FROM "Car"
ORDER BY "car_id";
