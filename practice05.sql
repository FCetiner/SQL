/* ----------------------------------------------------------------------------
  ORNEK5: kisi ismine ve urun adına göre (gruplayarak) satılan ürünlerin toplamını bulan ve
  ve bu toplam değeri 3 ve fazlası olan kayıtları toplam urun miktarlarina göre
  ters siralayarak listeyen sorguyu yazınız.
 -----------------------------------------------------------------------------*/  
 select isim, urun_adi, sum(urun_miktari)
 from manav
 group by isim, urun_adi
 having sum(urun_miktari)>=3
 order by sum(urun_miktari) desc;
 -- where sum komutu oldugu için uyari veriyor yerine having kullanıyoruz
 -- aggregate fonksiyonları ile ilgili bir koşul koymak için (sum,max,avg,min..)
 -- group by dan sonra having cumleciği kullanılır
 
  /* ----------------------------------------------------------------------------
  ORNEK6: satılan urun_adi'na göre (gruplayarak) MAX urun sayılarını sıralayarak listeleyen 
  sorguyu yazınız. NOT: Sorgu, sadece MAKS urun_miktari MIN urun_miktarına 
  eşit olmayan kayıtları listelemelidir.
 -----------------------------------------------------------------------------*/    
 select urun_adi, max(urun_miktari)max
 from manav
 group by urun_adi
 having  not max=min(urun_miktari)
 order by max;
 
 
 /*============================= DISTINCT =====================================
    
    DISTINCT cümleciği bir SORGU ifadesinde benzer olan satırları filtrelemek
    için kullanılır. Dolayısıyla seçilen sutun yada sutunlar için benzersiz veri
    içeren satırlar oluşturmaya yarar.
   
    SYNTAX
    -------
    SELECT DISTINCT sutun_adi1, sutun_adi2, sutun_adi3
    FROM  tablo_adı;
==============================================================================*/

/* ----------------------------------------------------------------------------
  ORNEK1: satılan farklı meyve türlerinin sayısını listeleyen sorguyu yazınız.
-----------------------------------------------------------------------------*/
select urun_adi, count(distinct(urun_adi))
from manav;

/* -----------------------------------------------------------------------------
  ORNEK2: satılan meyve + isimlerin farklı olanlarını listeyen sorguyu yazınız.
------------------------------------------------------------------------------*/
select distinct isim,urun_adi
from manav;

/* ----------------------------------------------------------------------------
  ORNEK3: satılan meyvelerin urun_mikarlarinin benzersiz  olanlarının 
  toplamlarini listeyen sorguyu yazınız.
-----------------------------------------------------------------------------*/
select  urun_adi, sum(distinct(urun_miktari))
from manav;
/*==================== SET OPERATORLERI: UNION, UNION ALL======================
    
    UNION, UNION ALL, (oracleSql->INTERSECT, ve MINUS) gibi SET operatorleri yardimiyla  
    Çoklu Sorgular birlestirilebilirler.
    UNION :  Bir SET operatorudur. 2 veya daha fazla Sorgu ifadesinin sonuc 
    kumelerini birlesitirerek tek bir sonuc kumesi olusturur.    
   
    NOT:  Birlesik olan olan Sorgu ifadesinin veri türü diger sorgulardaki 
    ifadelerin veri türü ile uyumlu olmalidir.
    
    Syntax:
    ----------
    SELECT sutun_adi,sutun_adi2, .. FROM tablo_adi1
    UNION
    SELECT sutun_adi1, sutun_adi2, .. FROM tablo_adi2;
    
    NOT: UNION operatoru SADECE benzersiz degerleri alir. Benzerli verileri almak
    için UNION ALL kullanilir.
==============================================================================*/ 

CREATE TABLE personel 
    (
        id int  PRIMARY KEY, 
        isim VARCHAR(50), 
        sehir VARCHAR(50), 
        maas int, 
        sirket VARCHAR(20)
        
    );
   
    INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
    INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
    INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'); 
    INSERT INTO personel VALUES(345678902, 'Mehmet Ozturk', 'istanbul', 3500, 'Honda'); 
    INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
    INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
    INSERT INTO personel VALUES(453445611, 'Veli Sahin', 'Ankara', 4500, 'Ford');
    INSERT INTO personel VALUES(123456710, 'Hatice Sahin','Bursa', 4200, 'Honda');
    
    SELECT * FROM personel;
    
/* -----------------------------------------------------------------------------
  ORNEK1: Maasi 4000’den cok olan isci isimlerini + 5000 liradan fazla maas 
  alinan sehirleri gosteren sorguyu yaziniz
------------------------------------------------------------------------------*/
select isim,maas
from personel
where maas>4000
union
select sehir,maas
from personel
where maas>5000
order by maas desc;

/* -----------------------------------------------------------------------------
  ORNEK2: Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul'daki 
  personelin maaslarini yüksekten alçaga dogru siralayarak bir tabloda gosteren 
  sorguyu yaziniz.    
------------------------------------------------------------------------------*/ 
select isim,maas
from personel
where isim='mehmet ozturk'
union
select isim, maas
from personel
where sehir='Istanbul';

/* -----------------------------------------------------------------------------
  ORNEK3: Honda,Ford ve Tofas'ta calisan ortak isimde personel varsa listeleyin
------------------------------------------------------------------------------*/
select isim, sirket
from personel
where sirket='Honda'
union
select isim, sirket
from personel
where sirket='Frod'
union
select isim, sirket
from personel
where sirket='Tofas';

/* -----------------------------------------------------------------------------
  ORNEK4: 5000’den az maas alanlarin, arti Honda calisani olmayanlarin bilgilerini
  listeleyen bir sorgu yaziniz. 
------------------------------------------------------------------------------*/ 
select isim,maas
from personel
where maas<5000
union
select isim,maas
from personel
where sirket<>'honda';
/* -----------------------------------------------------------------------------
  ORNEK5: Ismi Mehmet Ozturk olanlari + olarak Istanbul'da calismayanlarin isimlerini ve 
  sehirlerini listeleyen sorguyu yaziniz.
------------------------------------------------------------------------------*/
select isim,sehir
from personel
where isim='Mehmet Ozturk'
union
select isim ,sehir
from personel
where sehir<>'Istanbul';

/*======================== FARKLI TABLOLARDAN BIRLESTIRME ====================*/   
    
    CREATE TABLE personel_bilgi 
    (
        id int, 
        tel char(10) UNIQUE , 
        cocuk_sayisi int
      
    ); 
   
    INSERT INTO personel_bilgi VALUES(123, '5302345678' , 5);
    INSERT INTO personel_bilgi VALUES(234, '5422345678', 4);
    INSERT INTO personel_bilgi VALUES(345, '5354561245', 3); 
    INSERT INTO personel_bilgi VALUES(478, '5411452659', 3);
    INSERT INTO personel_bilgi VALUES(789, '5551253698', 2);
    INSERT INTO personel_bilgi VALUES(344, '5524578574', 2);
    INSERT INTO personel_bilgi VALUES(125, '5537488585', 1);
    
    /* -----------------------------------------------------------------------------
  ORNEK6: id'si 123456789 olan personelin Personel tablosundan sehir ve 
  maasini, personel_bilgi tablosundan da (id ilk 3 hanesiyle kaydolmuş=123)
  tel ve cocuk sayisini yazdirin  
------------------------------------------------------------------------------*/
select sehir, maas
from personel
where id='123456789'
union
select tel,cocuk_sayisi
from personel_bilgi
where id='123';

/* -----------------------------------------------------------------------------
  ORNEK7: Personel tablosundan Istanbul veya Ankara'da calisanlarin id'lerini
 ve 
 Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini sorgulayiniz.

------------------------------------------------------------------------------*/
select id
from personel
where sehir in('Istanbul','Ankara')
union
select id 
from personel_bilgi
where cocuk_sayisi in(2,3);

-- sirketlerden grupla sirketlerin çalışan isimlerini say
select sirket, count(isim)personel_sayisi
from personel
group by sirket;