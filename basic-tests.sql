-- Basic Test Cases that test inserting basic instances of each relation

INSERT INTO peercar_db.Car_Model
VALUES (
	'Toyota',
	'Prius',
	'sedan',
	'5'
);

INSERT INTO peercar_db.Car_Bay
VALUES (
	'Chippendale Bay',
	'1 Mikey St, Chippendale, Syd, 2008',
	'A small sized car bay',
	'151.1973',
	'-33.8845'
);

INSERT INTO peercar_db.Membership_Plan
VALUES (
	'Premium',
	'50',
	'5',
	'1',
	'100',
	'0.5',
	'50'
);



INSERT INTO peercar_db.Car
VALUES(
	'123456789',
	'Name',
	'2016',
	'automatic',
	'Toyota',
	'Prius',
	'Chippendale Bay'
);

INSERT INTO peercar_db.PayPal VALUES(
	'abc123@abc.co',
	'2',
	'abc123@abc.co'
);

INSERT INTO peercar_db.Credit_Card VALUES(
	'John Doe',
	'Master Card',
	'2020/10/05',
	'5617294726450890',
	'3'
);

INSERT INTO peercar_db.Bank_Account VALUES
(
	'John Doe',
	'012345',
	'87698767',
	'1',
	'abc123@abc.co'
);

INSERT INTO peercar_db.Phone VALUES (
	'0123456789',
	'abc123@abc.co'
);

INSERT INTO peercar_db.member VALUES(
	'abc123@abc.co',
	'password',
	'Mr',
	'Doe',
	'John',
	'SMART',
	'2016-03-12',
	'1986-05-03',
	'6 Central Pak Ave, Chippendale ,Syd , 2008',
	'BC9000',
	'2017-01-02',
	'Chippendale Bay',
	'Premium',
	'2'
);

INSERT INTO peercar_db.Booking VALUES(
	'2016/05/30',
	'12:00:00',
	'abc123@abc.co',
	'3',
	'12354689',
	'12:00:00'
);