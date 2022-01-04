drop TABLE mama_durumu;
drop table hayvanlar;
CREATE TABLE hayvanlar(
sıra int(3) primary key,
cins varchar(10) UNIQUE,
isim varchar (10)
);

INSERT INTO hayvanlar VALUES('100','kedi','pamuk');
INSERT INTO hayvanlar VALUES('101','kopek','jhonny');
INSERT INTO hayvanlar VALUES('102','at','fırtına');
INSERT INTO hayvanlar VALUES('103','inek','sarıkız');
INSERT INTO hayvanlar VALUES('104','koyun','benekli');
INSERT INTO hayvanlar VALUES('105','kuş','arthur');
savepoint ab;

CREATE TABLE fiyatlar(
sıra int(3) primary key,
fiyat double not null,
adet int(2),
constraint isim foreign key(sıra) references hayvanlar(sıra)
);

INSERT INTO fiyatlar VALUES('100','1000','1');
INSERT INTO fiyatlar VALUES('101','2000','2');
INSERT INTO fiyatlar VALUES('102','50000','5');
INSERT INTO fiyatlar VALUES('103','3000','5');
INSERT INTO fiyatlar VALUES('104','1000','0');
INSERT INTO fiyatlar VALUES('105','500','10');
drop table fiyatlar;
select * from hayvanlar, fiyatlar where (hayvanlar.sıra=fiyatlar.sıra);

/* -----------------------------------------------------------------------------
  ORNEK1: id'si 124 olan ogrenciyi siliniz.
 -----------------------------------------------------------------------------*/ 
  
  delete from hayvanlar where sıra=101;
    
/* -----------------------------------------------------------------------------
  ORNEK2: ismi Kemal Yasa olan satırını siliniz.
 -----------------------------------------------------------------------------*/   
     delete from hayvanlar where isim='pamuk';
	
      
/* -----------------------------------------------------------------------------
  ORNEK3: ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.
 -----------------------------------------------------------------------------*/        
  delete from hayvanlar where isim='sarıkız' or isim='arthur';
  delete from hayvanlar where isim in ('sarıkız','arthur');
  select* from hayvanlar;
/* ----------------------------------------------------------------------------
  ORNEK4: İsmi Ali Can ve id'si 123 olan kaydı siliniz.
 -----------------------------------------------------------------------------*/    
     delete from hayvanlar where cins='at' and sıra=102;
   
/* ----------------------------------------------------------------------------
  ORNEK5: id 'si 126'dan büyük olan kayıtları silelim.
 -----------------------------------------------------------------------------*/  
    delete from hayvanlar where sıra>103;
  
 /* ----------------------------------------------------------------------------
  ORNEK6: id'si 123, 125 ve 126 olanları silelim.
 -----------------------------------------------------------------------------*/     
    delete from hayvanlar where sıra in(101,102,104);
    
/* ----------------------------------------------------------------------------
  ORNEK7:  TABLODAKİ TÜM KAYITLARI SİLELİM..
 -----------------------------------------------------------------------------*/     
  delete from hayvanlar;
    
-- *************************************************    
    
      -- tablodaki kayitlari silmek ile tabloyu silmek farkli islemlerdir
-- silme komutlari da iki basamaklidir, biz genelde geri getirilebilecek sekilde sileriz 
-- ancak bazen guvenlik gibi sebeplerle geri getirilmeyecek sekilde silinmesi istenebilir   
/* ======================== DELETE - TRUNCATE - DROP ============================   
  
  1-) TRUNCATE komutu DELETE komutu gibi bir tablodaki verilerin tamamını siler.
    Ancak, seçmeli silme yapamaz. Çünkü Truncate komutu DML değil DDL komutudur.*/ 
         TRUNCATE TABLE ogrenciler;  -- doğru yazım
       
    
   /* 2-) DELETE komutu beraberinde WHERE cümleciği kullanılabilir. TRUNCATE ile 
    kullanılmaz.
        TRUNCATE TABLE ogrenciler
        WHERE veli_isim='Hasan';  .....yanlış yazım
        
-- TRUNCATE komutu tablo yapısını değiştirmeden, 
-- tablo içinde yer alan tüm verileri tek komutla silmenizi sağlar.
        
    3-) Delete komutu ile silinen veriler ROLLBACK Komutu ile kolaylıkla geri 
    alınabilir.
    
    4-) Truncate ile silinen veriler geri alınması daha zordur. Ancak
    Transaction yöntemi ile geri alınması mümkün olabilir.
    
    5-) DROP komutu da bir DDL komutudur. Ancak DROP veriler ile tabloyu da 
    siler. 
==============================================================================*/ 
    -- INSERT veri girişinden sonra SAVEPOİNT ABC; ile verileri buraya sakla
    -- (yanlışlık yapma olasılığına karşın önlem gibi, AYNI İSİMDE BAŞKA TABLO VARSA)
    -- sonra istediğini sil (ister tümü ister bir kısmı)
    -- sonra savepoint yaptığın yerden alttaki gibi rollback ile verileri geri getir
    INSERT INTO hayvanlar VALUES('100','kedi','pamuk');
INSERT INTO hayvanlar VALUES('101','kopek','jhonny');
INSERT INTO hayvanlar VALUES('102','at','fırtına');
INSERT INTO hayvanlar VALUES('103','inek','sarıkız');
INSERT INTO hayvanlar VALUES('104','koyun','benekli');
INSERT INTO hayvanlar VALUES('105','kuş','arthur');
savepoint ab;
 
    delete from hayvanlar;
    rollback to ab;
    select* from hayvanlar;
    
     SELECT * FROM tedarikciler;
    SELECT * FROM urunler;
    
    -- SYNTAX
    -- --------
    -- UPDATE tablo_adı
    -- SET sutun1 = yeni_deger1, sutun2 = yeni_deger2,...  
    -- WHERE koşul;
    select * from tedarikciler , urunler where tedarikciler.vergi_no = urunler.ted_vergino;
      
/* -----------------------------------------------------------------------------
  ORNEK1: vergi_no’su 102 olan tedarikcinin (firma) ismini 'Vestel' olarak güncelleyeniz. 
 -----------------------------------------------------------------------------*/ 
update tedarikciler 
set firma_ismi='vestel' 
where vergi_no=102 ;
   
/* -----------------------------------------------------------------------------
  ORNEK2: Tedarikciler tablosundaki tüm firma isimlerini 'CASPER' olarak 
  güncelleyeniz. 
 -----------------------------------------------------------------------------*/ 
   update tedarikciler
   set firma_ismi='CASPER';
   
/* -----------------------------------------------------------------------------
  ORNEK3: vergi_no’su 101 olan tedarikcinin ismini 'casper' ve irtibat_ismi’ni 
  'Ali Veli' olarak güncelleyiniz. 
 -----------------------------------------------------------------------------*/ 
   update tedarikciler
   set irtibat_ismi='Ali Veli', firma_ismi='Casper'
   where vergi_no=101;
    
    
/* -----------------------------------------------------------------------------
  ORNEK4: firma_ismi casper olan tedarikcinin irtibat_ismini 'İpek Bilgin' 
  olarak güncelleyiniz.
 -----------------------------------------------------------------------------*/ 
 update tedarikciler
 set irtibat_ismi='İpek Bilgin'
 where firma_ismi='casper';
/* -----------------------------------------------------------------------------
  ORNEK5: urunler tablosundaki 'Phone' değerlerini Telefon olarak güncelleyiniz.
 -----------------------------------------------------------------------------*/
  update urunler
  set urun_isim='telefon'
  where urun_isim='Phone';
  

/* -----------------------------------------------------------------------------
  ORNEK6: urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id
  değerlerini bir arttırınız
 -----------------------------------------------------------------------------*/ 
   update urunler
   set urun_id=urun_id+1
  where urun_id>1004;
 /* ----------------------------------------------------------------------------
  ORNEK7: urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino 
  sutun değerleri ile toplayarak güncelleyiniz.
 -----------------------------------------------------------------------------*/  
  update urunler
  set urun_id=urun_id+ted_vergino;
     select * from urunler;
/*-----------------------------------------------------------------------------
 ORNEK8: urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci 
 tablosunda irtibat_ismi 'Adam Eve' olan firmanın ismi (firma_ismi) ile 
 degistiriniz.
 -----------------------------------------------------------------------------*/
 delete from tedarikciler;
 update urunler
  set urun_isim=(select firma_ismi from tedarikciler where irtibat_ismi='Adam Eve')
  where musteri_isim='Ali Bak';
/*------------------------------------------------------------------------------
 ORNEK9: Laptop satin alan musterilerin ismini, Apple’in irtibat_isim'i ile 
 degistirin
 -----------------------------------------------------------------------------*/
 update urunler
 set musteri_isim=(select irtibat_ismi from tedarikciler where firma_ismi='apple')
 where urun_isim='laptop';
 select * from urunler;