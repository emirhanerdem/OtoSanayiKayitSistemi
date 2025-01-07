CREATE TABLE MusteriTipleri(
    MusteriTipiID INT IDENTITY(1,1) PRIMARY KEY,
    TipAdi VARCHAR(50)
);

--MÜŞTERİLER TABLOSU
CREATE TABLE Musteriler(
    MusteriID INT IDENTITY(1,1) PRIMARY KEY,
    Ad VARCHAR(20) NOT NULL,
    Soyad VARCHAR(20) NOT NULL,
    Adres VARCHAR(100),
    MusteriTipiID INT NOT NULL,
    MusteriBakiye DECIMAL(10,2),
    FOREIGN KEY(MusteriTipiID) REFERENCES MusteriTipleri(MusteriTipiID)
);

CREATE TABLE Telefonlar(
    TelefonID INT IDENTITY(1,1) PRIMARY KEY,
    MusteriID INT,
    TelefonNo VARCHAR(15),
    TelefonTipi VARCHAR(20),  -- Örneğin, 'Ev', 'İş', 'Cep'
    FOREIGN KEY (MusteriID) REFERENCES Musteriler(MusteriID)
);

CREATE TABLE EmailAdresleri(
    EmailID INT IDENTITY(1,1) PRIMARY KEY,
    MusteriID INT,
    EmailAdres VARCHAR(50),
    EmailTipi VARCHAR(20),  -- Örneğin, 'Kişisel', 'İş'
    FOREIGN KEY (MusteriID) REFERENCES Musteriler(MusteriID)
);

CREATE TABLE Markalar (
    MarkaID INT IDENTITY(1,1) PRIMARY KEY,
    MarkaAdi VARCHAR(50) NOT NULL
);

CREATE TABLE Modeller (
    ModelID INT IDENTITY(1,1) PRIMARY KEY,
    MarkaID INT NOT NULL,
    ModelAdi VARCHAR(50) NOT NULL,
    FOREIGN KEY(MarkaID) REFERENCES Markalar(MarkaID)
);

CREATE TABLE Renkler (
    RenkID INT IDENTITY(1,1) PRIMARY KEY,
    RenkAdi VARCHAR(20) NOT NULL
);

CREATE TABLE AracTipleri(
    TipID INT IDENTITY(1,1) PRIMARY KEY,
    TipAdi VARCHAR(50)
);

CREATE TABLE VitesTipleri(
    VitesTipiID INT IDENTITY(1,1) PRIMARY KEY,
    VitesTipiAdi VARCHAR(20)
);

CREATE TABLE YakitTipleri(
    YakitTipiID INT IDENTITY(1,1) PRIMARY KEY,
    YakitTipiAdi VARCHAR(20)
);

--ARACLAR TABLOSU
CREATE TABLE Araclar(
    AracID INT IDENTITY(1,1) PRIMARY KEY,
    MusteriID INT NOT NULL,
    Plaka VARCHAR(10) NOT NULL,
    MarkaID INT,
    ModelID INT,
    Yil INT,
    Kilometre INT,
    RenkID INT,
    MotorNo VARCHAR(30),
    TipID INT,
    VitesTipiID INT,
    YakitTipiID INT,
    SaseNo VARCHAR(30),
    FOREIGN KEY(MusteriID) REFERENCES Musteriler(MusteriID),
    FOREIGN KEY(MarkaID) REFERENCES Markalar(MarkaID),
    FOREIGN KEY(ModelID) REFERENCES Modeller(ModelID),
    FOREIGN KEY(RenkID) REFERENCES Renkler(RenkID),
    FOREIGN KEY(TipID) REFERENCES AracTipleri(TipID),
    FOREIGN KEY(VitesTipiID) REFERENCES VitesTipleri(VitesTipiID),
    FOREIGN KEY(YakitTipiID) REFERENCES YakitTipleri(YakitTipiID)
);

CREATE TABLE Pozisyonlar(
    PozisyonID INT IDENTITY(1,1) PRIMARY KEY,
    PozisyonAdi VARCHAR(50)
);

--PERSONEL TABLOSU
CREATE TABLE Personel (
    PersonelID INT IDENTITY(1,1) PRIMARY KEY,
    Ad VARCHAR(100),
    Soyad VARCHAR(100),
    TelNo VARCHAR(15),
    Maas INT,
    PozisyonID INT,
    FOREIGN KEY(PozisyonID) REFERENCES Pozisyonlar(PozisyonID)
);

--TAMİR İŞLEMLERİ TABLOSU
CREATE TABLE TamirIslemleri(
    TamirID INT IDENTITY(1,1) PRIMARY KEY,
    AracID INT NOT NULL,
    Tarih DATE NOT NULL,
    SorunAciklama VARCHAR(150),
    YapilanIslem VARCHAR(150),
    Maliyet DECIMAL(10,2),
    FOREIGN KEY(AracID) REFERENCES Araclar(AracID)
);

--YEDEK PARÇALAR TABLOSU
CREATE TABLE YedekParcalar (
    ParcaID INT IDENTITY(1,1) PRIMARY KEY,
    Ad VARCHAR(100) NOT NULL,
    Tur VARCHAR(50),
    Fiyat DECIMAL(10,2),
    StokMiktari INT,
);


CREATE TABLE OdemeYontemleri (
    OdemeYontemiID INT IDENTITY(1,1) PRIMARY KEY,
    YontemAdi VARCHAR(50) NOT NULL  -- Ödeme yönteminin adı (örneğin, "Kredi Kartı", "Nakit", "Banka Havalesi")
);

--ÖDEMELER TABLOSU
CREATE TABLE Odemeler (
    OdemeID INT IDENTITY(1,1) PRIMARY KEY,
    TamirID INT NOT NULL,
    Tarih DATE NOT NULL,
    Tutar DECIMAL(10,2) NOT NULL,
    OdemeYontemiID INT,
    FOREIGN KEY (TamirID) REFERENCES TamirIslemleri(TamirID),
    FOREIGN KEY (OdemeYontemiID) REFERENCES OdemeYontemleri(OdemeYontemiID)

);

CREATE TABLE RandevuDurumlari(
    DurumID INT IDENTITY(1,1) PRIMARY KEY,
    DurumAdi VARCHAR(50)
);

--RANDEVULAR TABLOSU
CREATE TABLE Randevular (
    RandevuID INT IDENTITY(1,1) PRIMARY KEY,
    MusteriID INT NOT NULL,
    AracID INT NOT NULL,
    RandevuTarihi DATETIME NOT NULL,
    DurumID INT,
    FOREIGN KEY (MusteriID) REFERENCES Musteriler(MusteriID),
    FOREIGN KEY (AracID) REFERENCES Araclar(AracID),
    FOREIGN KEY (DurumID) REFERENCES RandevuDurumlari(DurumID)

);

--PERSONEL-TAMİR İLİŞKİSİ (N:M)
CREATE TABLE Tamir_Personel (
    TamirID INT NOT NULL,
    PersonelID INT NOT NULL,
    PRIMARY KEY (TamirID, PersonelID),
    FOREIGN KEY (TamirID) REFERENCES TamirIslemleri(TamirID),
    FOREIGN KEY (PersonelID) REFERENCES Personel(PersonelID)
);

--PERSONEL-RANDEVU İLİKİSİ (N:M)
CREATE TABLE PersonelRandevu (
   PersonelID INT,
    RandevuID INT,
    PRIMARY KEY (PersonelID, RandevuID),
    FOREIGN KEY (PersonelID) REFERENCES Personel(PersonelID),
    FOREIGN KEY (RandevuID) REFERENCES Randevular(RandevuID)
);
--PERSONEL-YEDEPARÇA (N:M)
CREATE TABLE Personel_YedekParca (
    PersonelID INT,
    ParcaID INT,
    Adet INT,
    PRIMARY KEY (PersonelID, ParcaID),
    FOREIGN KEY (PersonelID) REFERENCES Personel(PersonelID),
    FOREIGN KEY (ParcaID) REFERENCES YedekParcalar(ParcaID)
);

--TAMİR-ÖDEME İLİŞKİSİ (N:M)
CREATE TABLE Odeme_Tamir (
    OdemeID INT,
    TamirID INT,
    PRIMARY KEY (OdemeID,TamirID),
    FOREIGN KEY (OdemeID) REFERENCES Odemeler(OdemeID),
    FOREIGN KEY (TamirID) REFERENCES TamirIslemleri(TamirID)
    
);
--TAMİR_YEDEKPARÇA İLİŞKİSİ (N:M)
CREATE TABLE Tamir_YedekParca(
    TamirID INT,
    ParcaID INT,
    Miktar INT,
    PRIMARY KEY (TamirID, ParcaID),
    FOREIGN KEY (TamirID) REFERENCES TamirIslemleri(TamirID),
    FOREIGN KEY (ParcaID) REFERENCES YedekParcalar(ParcaID)
);

--MÜŞTERİ TİPLERİ
INSERT INTO MusteriTipleri (TipAdi)
VALUES ('Bireysel'), ('Kurumsal');

--POZİSYONLAR
INSERT INTO Pozisyonlar (PozisyonAdi)
VALUES ('Teknik Personel'), ('Satış Temsilcisi'), ('Yönetici');

 --MARKALAR
INSERT INTO Markalar (MarkaAdi)
VALUES ('Ford'), ('Toyota'), ('BMW'),('Mercedes'),('Peugeot');

--MODELLER
INSERT INTO Modeller (MarkaID, ModelAdi)
VALUES (1, 'Focus'), (2, 'Corolla'), (3, 'X5'),(4,'Benz'),(5,'308');

--RENKLER
INSERT INTO Renkler (RenkAdi)
VALUES ('Kırmızı'), ('Mavi'), ('Beyaz'),('Gri'),('Siyah');

--ARAÇ TİPLERİ
INSERT INTO AracTipleri (TipAdi)
VALUES ('Sedan'), ('Hatchback'), ('SUV');

--VİTES TİPLERİ
INSERT INTO VitesTipleri (VitesTipiAdi)
VALUES ('Manuel'), ('Otomatik'),('Yarı Otomatik');

--YAKIT TİPLERİ
INSERT INTO YakitTipleri (YakitTipiAdi)
VALUES ('Benzin'), ('Dizel'), ('Elektrik');

--MÜŞTERİLER
INSERT INTO Musteriler (Ad, Soyad, Adres, MusteriTipiID, MusteriBakiye)
VALUES ('Emirhan', 'Erdem', 'Kadıköy, İstanbul, Türkiye', 1, 10000.00),
       ('Emrecan', 'Tokmak', 'Sultanbeyli, İstanbul, Türkiye', 1, 15000.00),
	   ('Halil','Erdem','Pendik, İstanbul, Türkiye',2,50000.00);

--TELEFONLAR
INSERT INTO Telefonlar (MusteriID, TelefonNo, TelefonTipi)
VALUES (1, '05511357299', 'Cep'),
	   (1, '17373414199','İş'),
       (2, '05526479918', 'Cep'),
	   (3, '43764598543','İş');

--E-MAIL ADRESLERİ
INSERT INTO EmailAdresleri (MusteriID, EmailAdres, EmailTipi)
VALUES (1, 'emirhanerdem759@gmail.com', 'Kişisel'),
       (1, 'emirhanerdem03@gmail.com', 'İş'),
	   (2,'emrecantokmak58@gmail.com','Kişisel'),
	   (3,'halilerdem52@gmail.com','İş');


--ARAÇLAR
INSERT INTO Araclar (MusteriID, Plaka, MarkaID, ModelID, Yil, Kilometre, RenkID, MotorNo, TipID, VitesTipiID, YakitTipiID, SaseNo)
VALUES (1, '34ABC123', 1, 1, 2020, 25000, 1, 'A123B456', 1, 2, 1, 'S123456789'),
       (2, '06XYZ987', 2, 2, 2021, 15000, 2, 'B789C012', 2, 1, 2, 'S987654321'),
	   (3, '34ABC123', 3, 3, 2020, 25000, 3, 'A123B456', 3, 2, 1, 'S123456789'),
       (3, '06XYZ987', 4, 4, 2021, 15000, 4, 'B789C012', 2, 3, 2, 'S987654321');


--PERSONEL
INSERT INTO Personel (Ad, Soyad, TelNo, Maas, PozisyonID)
VALUES ('Ali', 'Demir', '05011223344', 4000, 1),
       ('Ayşe', 'Öztürk', '05055667788', 5000, 2),
       ('Murat', 'Güzel', '05099887766', 8000, 3);

--TAMİR İŞLEMLERİ
INSERT INTO TamirIslemleri (AracID, Tarih, SorunAciklama, YapilanIslem, Maliyet)
VALUES (1, '2024-01-05', 'Motor hararet yapyor', 'Motor bakımı', 1500.00),
       (2, '2024-01-06', 'Frenleri gıcırdıyor', 'Fren bakımı ', 800.00),
	   (3, '2024-01-07', 'Motordan ses geliyor', 'Şase yapıldı', 1500.00),
       (3, '2024-01-08', 'Frenleri tutmuyor', 'Fren disk yapıldı', 800.00);
	   

--YEDEK PARÇALAR
INSERT INTO YedekParcalar (Ad, Tur, Fiyat, StokMiktari)
VALUES ('Fren Balatası', 'Fren Sistemi', 200.00, 15),
       ('Motor Yağı', 'Motor', 150.00,20);


--ÖDEME YÖNTEMLERİ
INSERT INTO OdemeYontemleri (YontemAdi)
VALUES ('Kredi Kartı'),
       ('Nakit'),
       ('Banka Havalesi');



--ÖDEMELER
INSERT INTO Odemeler (TamirID, Tarih, Tutar, OdemeYontemiID)
VALUES (1, '2024-01-05', 1500.00, 1),
       (2, '2024-01-06', 800.00, 2),
	   (3, '2024-01-05', 1500.00, 3),
       (4, '2024-01-06', 800.00, 2)

--RANDEVU DURUMLARI
INSERT INTO RandevuDurumlari (DurumAdi)
VALUES ('Beklemede'),  -- Randevu bekliyor
       ('Tamamlandı'),  -- Randevu tamamlandı
       ('İptal Edildi'); -- Randevu iptal edildi


--RANDEVULAR
INSERT INTO Randevular (MusteriID, AracID, RandevuTarihi, DurumID)
VALUES (1, 1, '2025-01-07 09:00:00', 1),
       (2, 2, '2025-01-08 10:00:00', 1),
	   (3, 3, '2025-01-07 09:00:00', 1),
       (3, 4, '2025-01-08 10:00:00', 1);

--TAMİR-PERSONEL İLİŞKİSİ (N:M)
INSERT INTO Tamir_Personel (TamirID, PersonelID)
VALUES (1, 1),
       (2, 2),
	     (3, 3),
       (4, 3);

--PERSONEL-RANDEVU İLİŞKİSİ (N:M)
INSERT INTO PersonelRandevu (PersonelID, RandevuID)
VALUES (1, 1),
       (2, 2),
	     (3, 3),
       (3, 4);

--PERSONEL-YEDEK PARÇA İLİŞKİSİ (N:M)
INSERT INTO Personel_YedekParca (PersonelID, ParcaID, Adet)
VALUES (1, 2, 1),
       (2, 1, 2),
	     (3, 2, 1),
       (3, 1, 2);
--ÖDEME-TAMİR İLİŞKİSİ (N:M)
INSERT INTO Odeme_Tamir (OdemeID, TamirID)
VALUES (1, 1),
       (2, 2),
	     (3, 3),
       (4, 4);


--TAMİR-YEDEK PARÇA İLİŞKİSİ (N:M)
INSERT INTO Tamir_YedekParca (TamirID, ParcaID, Miktar)
VALUES (1, 2, 1),
       (2, 1, 2),
	     (3, 2, 1),
       (4, 1, 2);

--------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------SORGULAR(QUERYS)----------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------

--Belirlediğimiz bir müşteri ile ilişkili tüm araçları listeleyen sorgu

SELECT M.Ad AS MusteriAd, M.Soyad AS MusteriSoyad, A.Plaka, A.MarkaID, A.ModelID
FROM Musteriler M
JOIN Araclar A ON M.MusteriID = A.MusteriID
WHERE M.MusteriID = 1;

----------------------------------------------------------------------------------------------------------------------------------------------
--Müşterilerin telefon ve email adreslerini getiren sorgu
SELECT DISTINCT 
    M.Ad AS MusteriAdi,
    M.Soyad AS MusteriSoyadi,
    T.TelefonNo AS TelefonNumarasi,
    E.EmailAdres AS EmailAdresi
FROM 
    Musteriler M
INNER JOIN 
    Telefonlar T ON M.MusteriID = T.MusteriID
INNER JOIN 
    EmailAdresleri E ON M.MusteriID = E.MusteriID;
----------------------------------------------------------------------------------------------------------------------------------------------
--Belirli bir müşteri tipine göre araçların renk ve model bilgisini getiren sorgu (bireysel(1)-kurumsa(2))
	SELECT 
    M.Ad AS MusteriAdi,
    M.Soyad AS MusteriSoyadi,
    MO.ModelAdi,
    R.RenkAdi
FROM 
    Musteriler M
INNER JOIN 
    Araclar A ON M.MusteriID = A.MusteriID
INNER JOIN 
    Modeller MO ON A.ModelID = MO.ModelID
INNER JOIN 
    Renkler R ON A.RenkID = R.RenkID
WHERE 
    M.MusteriTipiID = 1;

----------------------------------------------------------------------------------------------------------------------------------------------
--Her markanın kaç modeli olduğunu listeleyen sorgu

	SELECT 
    MA.MarkaAdi,
    COUNT(MO.ModelID) AS ModelSayisi
FROM 
    Markalar MA
INNER JOIN 
    Modeller MO ON MA.MarkaID = MO.MarkaID
GROUP BY 
    MA.MarkaAdi
ORDER BY 
    ModelSayisi DESC;

----------------------------------------------------------------------------------------------------------------------------------------------
--Bir tamir işlemi için yapılan tüm ödemeleri gösterir

SELECT T.TamirID, O.Tutar, O.Tarih, Y.YontemAdi
FROM TamirIslemleri T
JOIN Odemeler O ON T.TamirID = O.TamirID
JOIN OdemeYontemleri Y ON O.OdemeYontemiID = Y.OdemeYontemiID
WHERE T.TamirID = 4;

----------------------------------------------------------------------------------------------------------------------------------------------
--Belirli bir personelin yaptığı tamir işlemlerini listeleyen sorgu

SELECT P.Ad AS PersonelAd, P.Soyad AS PersonelSoyad, T.TamirID, T.SorunAciklama, T.YapilanIslem
FROM Personel P
JOIN Tamir_Personel TP ON P.PersonelID = TP.PersonelID
JOIN TamirIslemleri T ON TP.TamirID = T.TamirID
WHERE P.PersonelID = 1;

----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------PROSEDÜRLER------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------
--Müşteri tablosuna yeni müşteri eklemek için kullanılan prosedür

CREATE PROCEDURE YeniMusteriEkle
    @Ad VARCHAR(50),
    @Soyad VARCHAR(50),
    @Adres VARCHAR(100),
    @MusteriTipiID INT,
    @MusteriBakiye DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO Musteriler (Ad, Soyad, Adres, MusteriTipiID, MusteriBakiye)
    VALUES (@Ad, @Soyad, @Adres, @MusteriTipiID, @MusteriBakiye);
END;

EXEC YeniMusteriEkle 
    @Ad = 'Emirhan', 
    @Soyad = 'Erdem', 
    @Adres = 'İstanbul, Türkiye', 
    @MusteriTipiID = 1, 
    @MusteriBakiye = 1000.50;

----------------------------------------------------------------------------------------------------------------------------------------------
--Hem müşteri tablosuna yeni müşteri eklemek hem de bu müşteri için bir araç kaydı oluşturmak için kullanılan sorgu

CREATE PROCEDURE YeniMusteriyiArabaylaEkle
    @Ad VARCHAR(50),
    @Soyad VARCHAR(50),
    @Adres VARCHAR(100) = NULL,  
    @MusteriTipiID INT,  -- Müşteri tipi ID'si
    @MusteriBakiye DECIMAL(10, 2) = 0,  
    @Plaka VARCHAR(10),  
    @MarkaID INT,  
    @ModelID INT,  
    @Yil INT,  
    @Kilometre INT,  
    @RenkID INT, 
    @MotorNo VARCHAR(30),  
    @TipID INT,  
    @VitesTipiID INT,  
    @YakitTipiID INT,  
    @SaseNo VARCHAR(30) 
AS
BEGIN
    INSERT INTO Musteriler (Ad, Soyad, Adres, MusteriTipiID, MusteriBakiye)
    VALUES (@Ad, @Soyad, @Adres, @MusteriTipiID, @MusteriBakiye);
    DECLARE @MusteriID INT;
    SET @MusteriID = SCOPE_IDENTITY();  

    INSERT INTO Araclar (MusteriID, Plaka, MarkaID, ModelID, Yil, Kilometre, RenkID, MotorNo, TipID, VitesTipiID, YakitTipiID, SaseNo)
    VALUES (@MusteriID, @Plaka, @MarkaID, @ModelID, @Yil, @Kilometre, @RenkID, @MotorNo, @TipID, @VitesTipiID, @YakitTipiID, @SaseNo);

    -- Müşteri ve araç başarıyla eklenmiş olmalı
    PRINT 'Müşteri ve aracı başarıyla eklendi!';
END;

EXEC YeniMusteriyiArabaylaEkle 
    @Ad = 'Emirhan', 
    @Soyad = 'Erdem', 
    @Adres = 'İstanbul, Türkiye', 
    @MusteriTipiID = 1, 
    @MusteriBakiye = 1000.50, 
    @Plaka = '34', 
    @MarkaID = 1, 
    @ModelID = 2, 
    @Yil = 2020, 
    @Kilometre = 15000, 
    @RenkID = 1, 
    @MotorNo = '1234563452', 
    @TipID = 1, 
    @VitesTipiID = 1, 
    @YakitTipiID = 1, 
    @SaseNo = 'EMR987654321';

---------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------TRIGGER---------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------

--Müşterinin tablosundaki müşteri bakiyesini güncel tutmak için kullanılan trigger.
CREATE TRIGGER MusteriBakiyeGuncelle
ON Odemeler
AFTER INSERT
AS
BEGIN
    DECLARE @MusteriID INT, @Tutar DECIMAL(10,2);
    SELECT @MusteriID = M.MusteriID, @Tutar = I.Tutar
    FROM INSERTED I
    JOIN TamirIslemleri T ON I.TamirID = T.TamirID
    JOIN Araclar A ON T.AracID = A.AracID
    JOIN Musteriler M ON A.MusteriID = M.MusteriID;
    UPDATE Musteriler
    SET MusteriBakiye = MusteriBakiye - @Tutar
    WHERE MusteriID = @MusteriID;
END;
INSERT INTO Odemeler (TamirID, Tarih, Tutar, OdemeYontemiID)
VALUES (1, '2025-01-05', 500.00, 1);  

---------------------------------------------------------------------------------------------------------------------------------------------------
--Yedek parçaların stok miktarını otomatik olarak azaltan trigger
CREATE TRIGGER MusteriStokGuncelle
ON Tamir_YedekParca
AFTER INSERT
AS
BEGIN
    DECLARE @ParcaID INT, @Miktar INT;
    SELECT @ParcaID = ParcaID, @Miktar = Miktar
    FROM INSERTED;
    UPDATE YedekParcalar
    SET StokMiktari = StokMiktari - @Miktar
    WHERE ParcaID = @ParcaID;
END;
INSERT INTO Tamir_YedekParca (TamirID, ParcaID, Miktar)
VALUES (1, 2, 3);  
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------TRANSACTION-------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------

--Bir müşterinin tamir sonrası ödeme sürecini veritabanında üç farklı tabloda yansıtmak için kullanılan transaction

BEGIN TRANSACTION;
INSERT INTO Odemeler (TamirID, Tarih, Tutar, OdemeYontemiID)
VALUES (1, '2025-01-05', 1500.00, 1);  
UPDATE Musteriler
SET MusteriBakiye = MusteriBakiye - 1500.00
WHERE MusteriID = 1;  
UPDATE Randevular
SET DurumID = 2  -- 2, 'Tamamlandı' durumu
WHERE RandevuID = 1; 
COMMIT;
END;

------------------------------------------------------------------------------------------------------------------------------------------------------------

--Bir müşterinin tamir sonrası ödeme sürecini veritabanında üç farklı tabloda yansıtmak için kullanılan transaction eğer herhangi bir yerde hata ile karşılaşırsa
--hiçbir değişiklik yapmamış gibi veritabanını eski haline dönderen transaction

BEGIN;
INSERT INTO Odemeler (TamirID, Tarih, Tutar, OdemeYontemiID)
VALUES (1, '2025-01-07', 1500.00, 1);
UPDATE Musteriler
SET MusteriBakiye = MusteriBakiye - 1500.00
WHERE MusteriID = 1;
ROLLBACK;
END;

------------------------------------------------------------------------------------------------------------------------------------------------------------
--Bir tamir yapıldığında ve bu tamir işlemi başarılıysa tamirde kullanılan yedek parçayı güncelleyen transaction

BEGIN TRY
    BEGIN TRANSACTION;
    INSERT INTO Tamir_YedekParca (TamirID, ParcaID, Miktar)
    VALUES (3, 1, 2); 
    UPDATE YedekParcalar
    SET StokMiktari = StokMiktari - 2
    WHERE ParcaID = 2; 
    COMMIT;
    PRINT 'Yedek parça stoğu başarıyla güncellendi.';
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Bir hata oluştu, işlemler geri alındı: ' + ERROR_MESSAGE();
END CATCH;

------------------------------------------------------------------------------------------------------------------------------------------------------------
--Yeni bir müşteri eklendiğinde müşterinin aracınıda ekleyen transaction
BEGIN TRY
    BEGIN TRANSACTION;
    INSERT INTO Musteriler (Ad, Soyad, Adres, MusteriTipiID, MusteriBakiye)
    VALUES ('Ahmet', 'Yılmaz', 'İstanbul', 1, 500.00);
    DECLARE @MusteriID INT;
    SET @MusteriID = SCOPE_IDENTITY(); 
    INSERT INTO Araclar (MusteriID, Plaka, MarkaID, ModelID, Yil, Kilometre, RenkID, MotorNo, TipID, VitesTipiID, YakitTipiID, SaseNo)
    VALUES (@MusteriID, '34ABC123', 1, 1, 2022, 10000, 1, 'ABC123456', 1, 1, 1, 'XYZ123456');
    COMMIT;
    PRINT 'Yeni müşteri ve aracı başarıyla eklendi.';
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Bir hata oluştu, işlemler geri alındı: ' + ERROR_MESSAGE();
END CATCH;
------------------------------------------------------------------------------------------------------------------------------------------------------------
--Bir müşteri sildiğinde müşteriye ait aracıda silen transaction

BEGIN TRY
    BEGIN TRANSACTION;
    DELETE FROM Araclar
    WHERE MusteriID = 4;  
    DELETE FROM Musteriler
    WHERE MusteriID = 4;  
    COMMIT;
    PRINT 'Müşteri ve aracı başarıyla silindi.';
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Bir hata oluştu, işlemler geri alındı: ' + ERROR_MESSAGE();
END CATCH;
