GO
CREATE DATABASE frizerski_salon
GO
USE frizerski_salon
GO

GO
CREATE TABLE Korisnik(
id INT PRIMARY KEY IDENTITY(1,1),
ime NVARCHAR(100) NOT NULL,
prezime NVARCHAR(100) NOT NULL,
email NVARCHAR(50) NOT NULL,
password NVARCHAR(30) NOT NULL,
)
GO

GO
CREATE TABLE Frizer(
id INT PRIMARY KEY IDENTITY(1,1),
ime NVARCHAR(50) NOT NULL,
prezime NVARCHAR(50) NOT NULL,
)
GO

GO
CREATE TABLE FrizerRadniDan(
id INT PRIMARY KEY IDENTITY(1,1),
frizer_id INT FOREIGN KEY REFERENCES Frizer(id) NOT NULL,
dan INT NOT NULL,
)
GO

GO
CREATE TABLE FrizerskiSalon(
id INT PRIMARY KEY IDENTITY(1,1),
adresa NVARCHAR(100) NOT NULL,
)
GO

GO
CREATE TABLE Rezervacija(
id INT PRIMARY KEY IDENTITY(1,1),
korisnik_id INT FOREIGN KEY REFERENCES Korisnik(id) NOT NULL,
frizerskisalon_id INT FOREIGN KEY REFERENCES FrizerskiSalon(id) NOT NULL,
frizer_id INT FOREIGN KEY REFERENCES Frizer(id),
datum DATE NOT NULL,
vreme TIME NOT NULL,
)
GO

/*
Procedure
*/
GO
CREATE PROCEDURE Dodaj_Korisnik @ime NVARCHAR(50), @prezime NVARCHAR(50), @email NVARCHAR(50), @password NVARCHAR(50)
AS
BEGIN
INSERT INTO Korisnik(ime, prezime, email, password)
VALUES(@ime, @prezime, @email, @password)
END
GO

GO
CREATE PROCEDURE Obrisi_Korinsik @id INT
AS
BEGIN
DELETE FROM Korisnik
WHERE id = @id
END
GO

GO
CREATE PROCEDURE Izmeni_Korisnik @id INT, @ime NVARCHAR(50), @prezime NVARCHAR(50), @email NVARCHAR(50), @password NVARCHAR(50)
AS
BEGIN
UPDATE Korisnik
SET ime = @ime, prezime = @prezime, email = @email, password = @password
WHERE id = @id
END
GO

GO
CREATE PROCEDURE Dodaj_FrizerskiSalon @adresa NVARCHAR(100)
AS
BEGIN
INSERT INTO FrizerskiSalon(adresa)
VALUES (@adresa)
END
GO

GO
CREATE PROCEDURE Obrisi_FrizerskiSalon @id INT
AS
BEGIN
DELETE FROM FrizerskiSalon
WHERE id = @id
END
GO

GO
CREATE PROCEDURE Izmeni_FrizerskiSalon @id INT, @adresa NVARCHAR(100)
AS
BEGIN
UPDATE FrizerskiSalon
SET adresa = @adresa
WHERE id = @id
END 
GO

GO
CREATE PROCEDURE Dodaj_Frizer @ime NVARCHAR(50), @prezime NVARCHAR(50)
AS
BEGIN
INSERT INTO Frizer(ime, prezime)
VALUES(@ime, @prezime)
END
GO

GO
CREATE PROCEDURE Obrisi_Frizer @id INT
AS
BEGIN
DELETE FROM Frizer
WHERE id = @id
END
GO

GO
CREATE PROCEDURE Izmeni_Frizer @id INT, @ime NVARCHAR(50), @prezime NVARCHAR(50)
AS
BEGIN
UPDATE Frizer
SET ime = @ime, prezime = @prezime
WHERE id = @id
END
GO

GO
CREATE PROCEDURE Dodaj_FrizerRadniDan @frizer_id INT, @dan INT
AS
BEGIN
INSERT INTO FrizerRadniDan(frizer_id, dan)
VALUES(@frizer_id, @dan)
END
GO

GO
CREATE PROCEDURE Obrisi_FrizerRadniDan @id INT
AS
BEGIN
DELETE FROM FrizerRadniDan
WHERE id = @id
END
GO

GO
CREATE PROCEDURE Izmeni_FrizerRadniDan @id INT, @frizer_id INT, @dan INT
AS
BEGIN
UPDATE FrizerRadniDan
SET frizer_id = @frizer_id, dan = @dan
WHERE id = @id
END
GO

GO
CREATE PROCEDURE Dodaj_Rezervacija @korisnik_id INT, @frizerskisalon_id INT, @frizer_id INT, @datum DATE, @vreme TIME
AS
BEGIN
INSERT INTO Rezervacija(korisnik_id, frizerskisalon_id, frizer_id, datum, vreme)
VALUES(@korisnik_id, @frizerskisalon_id, @frizer_id, @datum, @vreme)
END
GO

GO
CREATE PROCEDURE Obrisi_Rezervacija @id INT
AS
BEGIN
DELETE FROM Rezervacija
WHERE id = @id
END
GO

GO
CREATE PROCEDURE Izmeni_Rezervacija @id INT, @korisnik_id INT, @frizerskisalon_id INT, @frizer_id INT, @datum DATE, @vreme TIME
AS
BEGIN
UPDATE Rezervacija
SET korisnik_id = @korisnik_id, frizerskisalon_id = @frizerskisalon_id, frizer_id = @frizer_id, datum = @datum, vreme = @vreme
WHERE id = @id
END
GO

GO
CREATE FUNCTION Proveri_Vreme (@frizerskisalon_id INT, @datum DATE, @vreme TIME)
RETURNS INT AS
BEGIN
DECLARE @return INT;
IF EXISTS(SELECT * FROM Rezervacija WHERE frizerskisalon_id = @frizerskisalon_id AND datum = @datum AND vreme = @vreme)
	SET @return = 1;
ELSE
	SET @return = 0;
RETURN @return;
END
GO
SELECT dbo.Proveri_Vreme(1, '2022-05-16', '13:30')

GO
EXEC Dodaj_Korisnik "Dobrica", "Katic", "dobrica@gmail.com", "123"
EXEC Dodaj_Korisnik "Ugljesa", "Keljic", "admin@gmail.com", "123"

EXEC Dodaj_FrizerskiSalon "Djuke Didic 28"
EXEC Dodaj_FrizerskiSalon "Kraljice Natalije 8"
EXEC Dodaj_FrizerskiSalon "Cara Dusana 10"

EXEC Dodaj_Frizer "Marija", "Maksimovic"
EXEC Dodaj_Frizer "Karlo", "Radic"

EXEC Dodaj_FrizerRadniDan 1, 1
EXEC Dodaj_FrizerRadniDan 1, 2
EXEC Dodaj_FrizerRadniDan 1, 3
EXEC Dodaj_FrizerRadniDan 2, 4
EXEC Dodaj_FrizerRadniDan 2, 5
EXEC Dodaj_FrizerRadniDan 2, 6
EXEC Dodaj_FrizerRadniDan 2, 0

EXEC Dodaj_Rezervacija 1, 1, 1, '2022-05-25', '13:00'
