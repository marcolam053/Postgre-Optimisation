CREATE SCHEMA peercar_db;

-- Table: Car_Bay
CREATE TABLE peercar_db.Car_Bay (
    Name varchar(30)  NOT NULL PRIMARY KEY,
    Address varchar(50)  NOT NULL,
    Description text NULL,
    Longitude float  NOT NULL UNIQUE,
    Latitude float  NOT NULL UNIQUE
select *
from peercar_db.Member
    CONSTRAINT long_num CHECK (Longitude BETWEEN -180 AND 180),
    CONSTRAINT lat_num CHECK (Latitude BETWEEN -90 AND 90)
);

-- Table: Car_Model
CREATE TABLE peercar_db.Car_Model (
    Make varchar(30)  NOT NULL UNIQUE,
    Model varchar(30)  NOT NULL UNIQUE,
    Category varchar(30)  NOT NULL,
    Capacity smallint  NOT NULL,

	PRIMARY KEY (Make,Model)
);

-- Table: Car
CREATE TABLE peercar_db.Car (
    Reg_No varchar(20) NOT NULL UNIQUE,
    Name varchar(30)  NOT NULL UNIQUE,
    Year smallint NOT NULL,
    Transmission varchar(10)  NOT NULL, -- either manual or automatic
    Make varchar(30) NOT NULL,
    Model varchar(30) NOT NULL,
    Bay_Name varchar(30) NOT NULL,

    CONSTRAINT Make_Car FOREIGN KEY(Make) REFERENCES peercar_db.Car_Model(Make) ON UPDATE CASCADE ON DELETE CASCADE,  
    CONSTRAINT Model_Car FOREIGN KEY(Model) REFERENCES peercar_db.Car_Model(Model) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT Bay_Name_Car FOREIGN KEY(Bay_Name) REFERENCES peercar_db.Car_Bay(Name) ON UPDATE CASCADE ON DELETE CASCADE,   
    CONSTRAINT year_limit CHECK (year <=  2020)
    CONSTRAINT Transmission_Type CHECK (Transmission in ('manual', 'automatic'))
   
);

-- Table: Membership_Plan
CREATE TABLE peercar_db.Membership_Plan (
    Title varchar(30) PRIMARY KEY NOT NULL,
    Monthly_Fee decimal(10,10)  NOT NULL,
    Hourly_Rate decimal(10,10)  NOT NULL,
    Km_Rate decimal(10,10)  NOT NULL,
    Daily_Rate decimal(10,10)  NOT NULL,
    Daily_Km_Rate decimal(10,10)  NOT NULL,
    Daily_Km_Included int  NOT NULL
);


-- Table: Member
CREATE TABLE peercar_db.Member (
    Email varchar(50)  PRIMARY KEY,
    Password varchar(30)  NOT NULL,
    Title varchar(30)  NOT NULL,
    Family_Name varchar(30)  NOT NULL,
    Given_Name varchar(30)  NOT NULL,
    Nickname varchar(30) UNIQUE, -- nickname is optional
    Since date  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Birthdate date  NOT NULL,
    Address varchar(50)  NOT NULL,
    License_Number varchar(20)  NOT NULL,
    License_Expiry_date date  NOT NULL,
    Home_Bay varchar(30) REFERENCES peercar_db.Car_Bay (Name) ON UPDATE CASCADE ON DELETE CASCADE,
    Plan_Title varchar(30) NOT NULL REFERENCES peercar_db.Membership_Plan (Title) ON UPDATE CASCADE ON DELETE CASCADE ,
    Preferred_Payment_Method smallint NOT NULL , -- the preferred pmt method

    UNIQUE (Address, Family_Name, Given_Name)

);

-- Table: Bank_Account
CREATE TABLE peercar_db.Bank_Account (
    Name varchar(30)  NOT NULL UNIQUE,
    bsb varchar(30)  NOT NULL,
    account varchar(30)  NOT NULL,
    Num smallint NOT NULL DEFAULT 1,
	Member_email varchar(50),
	PRIMARY KEY(Num,Member_email)
);

-- Table: Credit_Card
CREATE TABLE peercar_db.Credit_Card (
    name varchar(30)  NOT NULL UNIQUE,
    brand varchar(30)  NOT NULL,
    expires date  NOT NULL,
	Num smallint NOT NULL DEFAULT 3 ,
	member_email varchar(50),
	PRIMARY KEY(num,member_email)
);

-- Table: PayPal
CREATE TABLE peercar_db.PayPal (
    email varchar(50)  NOT NULL,
    Num smallint  NOT NULL DEFAULT 2,
	Memeber_mail varchar(50),
	PRIMARY KEY (Num,Member_mail)
);

-- Table: Booking
CREATE TABLE peercar_db.Booking (
    Date date NOT NULL,
    Hour time NOT NULL,
    Email varchar(50)  NOT NULL,
    Duration smallint  NOT NULL,
    Car_Reg_No varchar(20) NOT NULL,
    whenBooked time NOT NULL,
        PRIMARY KEY (Date,Hour),
        -- Reference: Booking to Member
        FOREIGN KEY (Email) REFERENCES peercar_db.Member (Email) ON UPDATE CASCADE,
        -- Reference: Booking to Car
        FOREIGN KEY (Car_Reg_No) REFERENCES peercar_db.Car (Reg_No) ON UPDATE CASCADE ON DELETE CASCADE,

    CONSTRAINT Duration_check CHECK (Duration >= 1), -- minimum duration is one hour
    CONSTRAINT Hour_check CHECK (Hour BETWEEN '00:00:00' AND '23:59:59')
);

-- Table: Phone
CREATE TABLE peercar_db.Phone (
    Phone_Number varchar(10)  NOT NULL,
    Member_Email varchar(50)  NOT NULL REFERENCES peercar_db.Member (Email) ON UPDATE CASCADE ON DELETE CASCADE,
);

-- Trigger to deal with expired licenses
CREATE OR REPLACE FUNCTION License_Expired() RETURNS trigger AS $check_license_MOD$
  BEGIN 
	-- set license # to null and set license expiry to null 
  	IF (License_Expiry_date < CURRENT_DATE) THEN 
  	UPDATE peercar_db.Member SET (License_Expiry_date, Liscense_Number) = (NULL,NULL);
  	RAISE EXCEPTION 'Member driver license has expired. Update license number and expiry date immediately.';
	END IF;

	RETURN Liscense_Expiry_Date;
  END
$check_license_MOD$ LANGUAGE plpgsql;

CREATE TRIGGER check_license_mod
  BEFORE INSERT OR UPDATE
  ON peercar_db.member
  FOR EACH ROW
  WHEN ((new.license_expiry_date < ('now'::text)::date))
  EXECUTE PROCEDURE license_expired();


  ALTER TABLE peercar_db.PayPal ADD CONSTRAINT PayPal_Member
    FOREIGN KEY (Member_Email)
    REFERENCES Member (Email)  
   On update Cascade
   ON delete cascade;

 ALTER TABLE peercar_db.bank_account ADD CONSTRAINT bank_Member
    FOREIGN KEY (Member_Email)
    REFERENCES Member (Email)  
   On update Cascade
   ON delete cascade;

 ALTER TABLE peercar_db.Credit_Card ADD CONSTRAINT credit_Member
    FOREIGN KEY (Member_Email)
    REFERENCES Member (Email)  
   On update Cascad
   ON delete cascade;

