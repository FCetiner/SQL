/* ============================= SUBQUERIES ====================================
    SORGU içinde çalişan SORGUYA SUBQUERY (ALT SORGU) denilir.
==============================================================================*/
CREATE TABLE calisanlar 
    (
        id int, 
        isim VARCHAR(50), 
        sehir VARCHAR(50), 
        maas int, 
        isyeri VARCHAR(20)
    );
    INSERT INTO calisanlar VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
    INSERT INTO calisanlar VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
    INSERT INTO calisanlar VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
    INSERT INTO calisanlar VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
    INSERT INTO calisanlar VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
    INSERT INTO calisanlar VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
    INSERT INTO calisanlar VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');
    
    CREATE TABLE markalar
    (
        marka_id int, 
        marka_isim VARCHAR(20), 
        calisan_sayisi int
    );
    
    INSERT INTO markalar VALUES(100, 'Vakko', 12000);
    INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
    INSERT INTO markalar VALUES(102, 'Adidas', 10000);
    INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);
    select * from calisanlar;
    select * from markalar;
    
    /* ============================= SUBQUERIES ====================================
     ORNEK1: calisan sayisi 15.000’den cok olan markalarin isimlerini ve bu 
  markada  calisanlarin isimlerini ve maaşlarini listeleyin
==============================================================================*/
-- in yerine eşittir olmaz çünkü eşittir bir adet veri için yazılabilir
select isim, maas, isyeri from calisanlar
where isyeri in (select marka_isim from markalar where calisan_sayisi>15000);

/* ----------------------------------------------------------------------------
  ORNEK2: marka_id’si 101’den büyük olan marka çalişanlarinin isim, maaş ve 
  şehirlerini listeleyiniz. 
  -----------------------------------------------------------------------------*/
  select isim, maas, sehir from calisanlar
  where isyeri in (select marka_isim from markalar where marka_id>101);
  /* -----------------------------------------------------------------------------
  ORNEK3: Ankara’da calisani olan markalarin marka id'lerini ve calisan
  sayilarini listeleyiniz.
  -----------------------------------------------------------------------------*/ 
  select marka_id, calisan_sayisi from markalar
  where marka_isim in(select isyeri from calisanlar where sehir='Ankara');
    /* ===================== AGGREGATE METOT KULLANIMI ===========================
    Aggregate Metotlari(SUM,COUNT, MIN,MAX, AVG) Subquery içinde kullanilabilir.
    Ancak, Sorgu tek bir değer döndürüyor olmalidir.
==============================================================================*/
    /* -----------------------------------------------------------------------------
  ORNEK4: Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin
  toplam maaşini listeleyen bir Sorgu yaziniz.
 -----------------------------------------------------------------------------*/
select marka_isim, calisan_sayisi, (select sum(maas) from calisanlar 
									where marka_isim=calisanlar.isyeri) as toplam_maas
from markalar;

  -- markalar. ve calisanlar. : ifadelerini ayni isimler olsaydi kullaniriz burda ornekledik
-- as toplam_maas : parantez icine isim vermek icin

/* -----------------------------------------------------------------------------
  ORNEK5: Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin
  ortalama maaşini listeleyen bir Sorgu yaziniz.
 -----------------------------------------------------------------------------*/
 select marka_isim, calisan_sayisi, (select round(avg(maas)) from calisanlar where marka_isim=calisanlar.isyeri) ortalama_maas
 from markalar;
 
/* ----------------------------------------------------------------------------
  ORNEK6: Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin
  maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.
 -----------------------------------------------------------------------------*/
 select marka_isim, calisan_sayisi, (select max(maas) from calisanlar where marka_isim=isyeri)max_maas,
 (select min(maas) from calisanlar where marka_isim=isyeri)min_maas
 from markalar;
 
 /* -----------------------------------------------------------------------------
  ORNEK7: Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu 
  listeleyen bir SORGU yaziniz.
 -----------------------------------------------------------------------------*/
 select marka_id, marka_isim, (select count(sehir) from calisanlar where marka_isim=isyeri)sehir_sayisi
 from markalar;
 
 /*=============================== ALTER TABLE ==================================
    
    ALTER TABLE  tabloda ADD, MODIFY, veya DROP/DELETE COLUMNS islemleri icin 
    kullanilir.
    
    ALTER TABLE ifadesi tablolari yeniden isimlendirmek (RENAME) icin de
    kullanilir.
   
==============================================================================*/
    CREATE TABLE personel
    (
        id int PRIMARY KEY , 
        isim VARCHAR(50), 
        sehir VARCHAR(50), 
        maas int, 
        sirket VARCHAR(20)
    );
    INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
    INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
    INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'); 
    INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
    INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
    INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');
  
  
  /* -----------------------------------------------------------------------------
  ORNEK1: personel tablosuna ulke_isim adinda ve default degeri 'Turkiye' olan 
  yeni bir sutun ekleyiniz.
------------------------------------------------------------------------------*/ 
 alter table personel 
 add ulke_isim varchar(20) default 'Turkiye';
     
/* -----------------------------------------------------------------------------
  ORNEK2: personel tablosuna cinsiyet Varchar2(20) ve yas int(3) seklinde 
  yeni sutunlar ekleyiniz.
------------------------------------------------------------------------------*/  
    alter table personel
    add  (cinsiyet varchar(20), yas int(3));
/* -----------------------------------------------------------------------------
  ORNEK3: personel tablosundan sirket sutununu siliniz. 
------------------------------------------------------------------------------*/ 
 alter table personel
 drop column sirket; 
 

/* -----------------------------------------------------------------------------
  ORNEK4: personel tablosundaki ulke_isim sutununun adini ulke_adi olarak 
  degistiriniz. 
------------------------------------------------------------------------------*/  
alter table personel
rename column ulke_isim to ulke_adi;
     select * from personel;
/* -----------------------------------------------------------------------------
  ORNEK5: personel tablosunun adini isciler olarak degistiriniz. 
------------------------------------------------------------------------------*/  
  alter table personel
  rename  to isciler;
/* -----------------------------------------------------------------------------
  ORNEK6: isciler tablosundaki ulke_adi sutununa NOT NULL kisitlamasi ekleyiniz
  ve veri tipini VARCHAR(30) olarak değiştiriniz. 
------------------------------------------------------------------------------*/ 
  alter table isciler
  modify ulke_adi varchar(30) not null;
  select * from isciler;