
-- More Advanced DML Test Cases that test constraints and trigger

-- Test for duplicated entry in Car_Model
INSERT INTO peercar_db.Car_Model
VALUES (
	'Toyota',
	'Prius',
	'sedan',
	'5'
);

-- test for duplication of location
INSERT INTO peercar_db.Car_Bay
VALUES (
	'Chippendale Bay',
	'1 Mikey St, Chippendale, Syd, 2008',
	'A small sized car bay',
	'151.1973',
	'-33.8845'
);


-- test violation of gps coordinate
INSERT INTO peercar_db.Car_Bay
VALUES (
	'Syd',
	'1 Mue St, Chi, Syd, 2008',
	'A  car bay',
	'1908.345',
	'-99.00'
);

-- test for duplicated key entry
INSERT INTO peercar_db.Membership_Plan
VALUES (
	'Premium',
	'0.5',
	'5',
	'1',
	'100.1',
	'0.5',
	'50'
);

--Testing for booking error
	-- Test for duration constraint
INSERT INTO peercar_db.Booking VALUES(
	'2016/05/30',
	'12:00:00',
	'abc123@abc.co',
	'-1',
	'12354689',
	'12:00:00'
);

	--Test for HOUR
INSERT INTO peercar_db.Booking VALUES(
	'2016/05/30',
	'2300',
	'abc123@abc.co',
	'3',
	'12354689',
	'12:00:00'
);

--TEST for car
	-- test for transmission entry
INSERT INTO peercar_db.Car
VALUES(
	'133456879',
	'Nam',
	'2016',
	'SEMIAUTO',
	'Toyota',
	'Prius',
	'Chippendale Bay'
);

	-- test for Year
INSERT INTO peercar_db.Car
VALUES(
	'133456870',
	'NamY',
	'2048',
	'MANUAL',
	'Toyota',
	'Prius',
	'Chippendale Bay'
);

-- TEST MEMBER BIRTHDAY
-- test if member is less than 18
INSERT INTO peercar_db.member VALUES(
	'ab3@abc.co',
	'password',
	'Mr',
	'Doe',
	'John',
	'SM',
	'2016-03-12',
	'2018-05-03', -- <-- BIRTHDAY
	'6 Central P Ave, Chippendale ,Syd , 2008',
	'BC00',
	'2017-01-02',
	'Chipendale Bay',
	'Premium',
	'2'
);


-- TEST TRIGGER

INSERT INTO peercar_db.member VALUES(
	'ab3@abc.co',
	'password',
	'Mr',
	'Lai',
	'Mar',
	'Kiddy',
	'2016-03-12',
	'2018-05-03', -- <-- BIRTHDAY
	'6 HK building , 1/f,sydney',
	'AC20003',
	'2015-03-02',
	'Chipendale Bay',
	'Premium',
	'1'
);

-- Update Tests 

-- update operation for car
UPDATE peercar_db.Car_Model SET Make = 'Honda' WHERE Model = 'Prius';

-- update column name
update peercar_db.Car_Bay SET Home_Bay = 'Chip' Where Home_Bay = ' Chippendale Bay';

-- update operation
UPDATE peercar_db.Car_Bay SET name = ' Chipmunkdell Bae' Where address = '1 Mikey St, Chippendale, Syd, 2008';

-- test if we can insert a new table if the member does not exsit anymore
delete from peercar_db.member where Given_name = 'John' and Family_name = 'Doe';
INSERT INTO peercar_db.Booking VALUES(
	'2016/05/30',
	'12:00:00',
	'abc123@abc.co',
	'-1',
	'12354689',
	'12:00:00'
);
