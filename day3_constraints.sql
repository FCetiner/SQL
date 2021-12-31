/*======================= CONSTRAINTS - KISITLAMALAR ======================================
           
    NOT NULL - Bir Sütunun  NULL içermemesini garanti eder. 
    UNIQUE - Bir sütundaki tüm değerlerin BENZERSİZ olmasını garanti eder.  
    PRIMARY KEY - Bir sütünün NULL içermemesini ve sütundaki verilerin 
                  BENZERSİZ olmasını garanti eder.(NOT NULL ve UNIQUE birleşimi gibi)
    FOREIGN KEY - Başka bir tablodaki Primary Key’i referans göstermek için kullanılır. 
                  Böylelikle, tablolar arasında ilişki kurulmuş olur. 
                  foreign ve primary ile tablolar birbirine bağlamadan da, id leri ayni olan satirlarda işlem yap diyebiliriz, böylelikle
                  ayni field verilebilir, parent child ilişkisi olmamiş olur
    CHECK - Bir sutundaki tüm verilerin belirlenen özel bir şartı sağlamasını garanti eder. 
    DEFAULT - Herhangi bir değer atanamadığında Başlangıç değerinin atanmasını sağlar.
 ========================================================================================*/
 
 CREATE TABLE calisanlar
    (
        id CHAR(5) PRIMARY KEY, -- not null+ unique
        isim VARCHAR(50) UNIQUE,
        maas int NOT NULL,
        ise_baslama DATE
    );
 
 
INSERT INTO calisanlar VALUES( '10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
   INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
   INSERT INTO calisanlar VALUES('10010', null, 5000, '2018-04-14');-- 2. kez null benzersizlik kisitlamasini bozmaz
    INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
    INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14'); 
    INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- maas null olamaz
    INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
	INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14');-- can zaten var
    INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14');-- '' bunu int kabul etmez
    INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');-- '' bunu (hiçlik) string kabul eder
     INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); -- id tekrarl olamaz primary key 
      INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14');-- primary key old. null yazamayz

    select * from calisanlar;
    
  /*  ------------------------------------------------------------
  KISITLAMALAR (ORNEK3 - FOREIGN KEY)
----------------------------------------------------------------*/
      
    CREATE TABLE adresler
    (
        adres_id CHAR(5),     
        sokak VARCHAR(50),
        cadde VARCHAR(30),
        sehir VARCHAR(15),
        CONSTRAINT id_fk FOREIGN KEY(adres_id) REFERENCES calisanlar(id) -- (solda tablo seçiliyken üstteki info dan ismi kontrol edebilirsin)
    );
    
    INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
    INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
    INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
    -- parent tabloda olmayan id ile child a ekleme yapamayız
    -- FK'ye null değeri atanabilir. 
    INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');