
create table hayvanlar(
id char(3) Primary Key,
isim varchar(20) unique,
adet int not null,
dogum_tarihi date
);

INSERT INTO hayvanlar VALUES('100','Kuş',10,'2021-01-01');
INSERT INTO hayvanlar VALUES('101','	',5,'2021-02-01');
INSERT INTO hayvanlar VALUES('102','Kopek',3,'2021-03-01');
INSERT INTO hayvanlar VALUES('103','Inek',1,'2021-04-01');

create table mama_durumu(
id char(3),
mama varchar(10),
constraint hayvanlarId FOREIGN KEY(id) REFERENCES hayvanlar(id) ON DELETE cascade
);

INSERT INTO mama_durumu VALUES('100','var');
INSERT INTO mama_durumu VALUES('101','var');
INSERT INTO mama_durumu VALUES('102','var');
INSERT INTO mama_durumu VALUES('103','yok');

select * FROM hayvanlar;
select * from mama_durumu;
DELETE from hayvanlar where id=101;

select isim from hayvanlar where adet>3;
select * from hayvanlar where isim='Kedi';
select * from hayvanlar where id between '101' and '102';
select * from hayvanlar where id in('100','102','103');
select * from hayvanlar where isim='kuş' or adet=1;
select * from hayvanlar where isim like'K%';
select * from hayvanlar where isim like '%i';
select * from hayvanlar where isim like '_e%';
select * from hayvanlar where isim like '_n%k%';
select * from hayvanlar where isim not like 'k%';
select * from hayvanlar where isim not like '%e%';
select * from mama_durumu where mama not like '%ok%';
select * from hayvanlar where isim like '___';

/* -----------------------------------------------------------------------------
  ORNEK22: İçerisinde 'ot' veya 'at' bulunan kelimeleri küçük harfe dikkat
  ederek listeleyiniz 
 -----------------------------------------------------------------------------*/ 
    -- VEYA işlemi için | karakteri kullanılır.
   select * from kelimeler where regexp_like (kelime, 'ot|at','c');
   
/* -----------------------------------------------------------------------------
  ORNEK23: İçerisinde 'ot' veya 'at' bulunan kelimeleri büyük-küçük harfe dikkat
  etmeksizin listeleyeniz
 -----------------------------------------------------------------------------*/ 
    
 select * from kelimeler where regexp_like(kelime, 'ot|at');
      
   
 /* -----------------------------------------------------------------------------
  ORNEK24: 'ho' veya 'hi' ile başlayan kelimeleri büyük-küçük harfe dikkat
  etmeksizin listeleyeniz
 -----------------------------------------------------------------------------*/   
     -- Başlangıcı göstermek için ^ karakteri kullanılır.
    
    select * from kelimeler where regexp_like (kelime, '^ho|^hi');
    
/* -----------------------------------------------------------------------------
  ORNEK25: Sonu 't' veya 'm' ile bitenleri büyük-küçük harfe dikkat
  etmeksizin listeleyeniz. (i yazmaya gerek yok)
 -----------------------------------------------------------------------------*/   
     -- Bitişi göstermek için $ karakteri kullanılır.

    select * from kelimeler where regexp_like (kelime, 't$|m$');

/* -----------------------------------------------------------------------------
  ORNEK26: h ile başlayıp t ile biten 3 harfli kelimeleri (h ile t küçük harfli 
  olanlari) listeleyeniz
 -----------------------------------------------------------------------------*/ 
select * from kelimeler where regexp_like (kelime, 'h[a-zA-Z0-9]t');

/* -----------------------------------------------------------------------------
  ORNEK27: İlk harfi h, son harfi t olup 2.harfi a veya i olan 3 harfli 
  kelimelerin tüm bilgilerini sorgulayalım.
 -----------------------------------------------------------------------------*/ 
select * from kelimeler where regexp_like (kelime, 'h[ai]t');

/* -----------------------------------------------------------------------------
  ORNEK28: İçinde m veya i veya e olan kelimelerin tüm bilgilerini listeleyiniz.
 -----------------------------------------------------------------------------*/     
select *  from  kelimeler where regexp_like (kelime, '[mie]');
/* -----------------------------------------------------------------------------
  ORNEK29: a veya s ile başlayan kelimelerin tüm bilgilerini listeleyiniz.
-----------------------------------------------------------------------------*/ 
select * from kelimeler where regexp_like (kelime, '^[as]');
/* -----------------------------------------------------------------------------
  ORNEK30: içerisinde en az 2 adet oo barıdıran kelimelerin tüm bilgilerini 
  listeleyiniz.	
-----------------------------------------------------------------------------*/ 
 select * from kelimeler where regexp_like(kelime, '[o][o]');
  select * from kelimeler where regexp_like(kelime, '[o]{3}'); -- en az 3 adet o içeren kelimeler

