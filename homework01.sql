CREATE table hastaneler(
id varchar(5) primary key,
isim varchar(50),
sehir varchar(30),
ozel char(1)
);

INSERT INTO hastaneler VALUES('H101','ACIMADEM HASTANESI','ISTANBUL','Y');
INSERT INTO hastaneler VALUES('H102','HASZEKI HASTANESI','ISTANBUL','N');
INSERT INTO hastaneler VALUES('H103','NEDIKOL HASTANESI','IZMIR','Y');
INSERT INTO hastaneler VALUES('H104','NEMORYIL HASTANESI','ANKARA','Y');

CREATE table hastalar(
kimlik_no varchar(11) primary key,
isim varchar(30),
teshis varchar(40)
);

INSERT INTO hastalar VALUES('12345678901', 'Ali Can', 'Gizli Seker');
INSERT INTO hastalar VALUES('45678901234', 'Ayse Yılmaz', 'Hipertansiyon');
INSERT INTO hastalar VALUES('78901234567', 'Steve Job', 'Pankreatit');
INSERT INTO hastalar VALUES('12378945612', 'Tom Hanks', 'COVID 19');

CREATE table bolumler(
bolum_id varchar(10) primary key,
bolum_adi varchar(45)
);
INSERT INTO bolumler VALUES('DHL','Dahiliye');
INSERT INTO bolumler VALUES('KBB','Kulak-Burun-Bogaz');
INSERT INTO bolumler VALUES('NRJ','Noroloji');
INSERT INTO bolumler VALUES('GAST','Gastroloji');
INSERT INTO bolumler VALUES('KARD','Kardiyoloji');
INSERT INTO bolumler VALUES('PSK','Psikiyatri');
INSERT INTO bolumler VALUES('GOZ','Goz Hastalıkları');

CREATE table hasta_kayitlar(
kimlik_no varchar(11) primary key,
hasta_isim varchar(30),
hastane_ismi varchar(30),
bolum_adi varchar(30),
teshis varchar(30)
);

INSERT INTO hasta_kayitlar (kimlik_no, hasta_isim)VALUES ('1111','NONAME');
INSERT INTO hasta_kayitlar (kimlik_no, hasta_isim)VALUES ('2222','NONAME');
INSERT INTO hasta_kayitlar (kimlik_no, hasta_isim)VALUES ('3333','NONAME');
select * from hastaneler;
select * from hastalar;
select * from bolumler;
select * from hasta_kayitlar;

/*hasta_kayıtlar tablosundaki ‘3333’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.
hasta_isim : ‘Salvadore Dali’ ismi ile
hastane_adi: ‘John Hopins’
bolum_adi: ‘Noroloji’
teshis: ‘Parkinson’
kimlik_no: ‘99991111222’*/

update hasta_kayitlar
set hasta_isim='Salvadore Dali',
	hastane_ismi='John Hopins',
    bolum_adi='Noroloji',
    teshis='Parkinson',
    kimlik_no='9999'
where kimlik_no='3333';

/*hasta_kayıtlar tablosundaki ‘1111’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.
hasta_isim : hastalar tablosundaki ‘Ali Can’ ismi ile
hastane_adi: hastaneler tablosundaki 'H104' bolum_id kodlu hastanenin ismi ile
bolum_adi: bolumler tablosundaki 'DHL' bolum_id kodlu bolum_adi ile
teshis: hastalar tablosundaki 'Ali Can' isimli hastanın teshis bilgisi ile
kimlik_no: hastalar tablosundaki 'Ali Can' isimli hastanın kimlik_no kodu ile*/
    
    update hasta_kayitlar
    set hasta_isim=(select isim from hastalar where isim='Ali Can'),
	hastane_ismi=(select isim from hastaneler where id='H104'),  -- burasi eklenmedi nedenki
    bolum_adi=(select bolum_adi from bolumler where bolum_id='DHL'),
    teshis=(select teshis from hastalar where isim='Ali Can'),
    kimlik_no=(select kimlik_no from hastalar where isim='Ali Can')
    where kimlik_no='1111';
    select * from hasta_kayitlar;
     /*hasta_kayıtlar tablosundaki ‘2222’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.
hasta_isim : hastalar tablosundaki ‘Ayşe Yılmaz’ ismi ile
hastane_adi: hastaneler tablosundaki 'H103' bolum_id kodlu hastanenin ismi ile
bolum_adi: bolumler tablosundaki ‘KBB’ bolum_id kodlu bolum_adi ile
teshis: hastalar tablosundaki ‘Tom Hanks' isimli hastanın teshis bilgisi ile
kimlik_no: hastalar tablosundaki 'Stevev Job' isimli hastanın kimlik_no kodu ile*/
  
  update hasta_kayitlar
  set hasta_isim=(select isim from hastalar where isim='Ayse Yılmaz'),
	hastane_ismi=(select isim from hastaneler where id='H103'),   
    bolum_adi=(select bolum_adi from bolumler where bolum_id='KBB'),
    teshis=(select teshis from hastalar where isim='Tom Hanks'),
    kimlik_no=(select kimlik_no from hastalar where isim='Steve Job')
  where kimlik_no='2222';
  select * from hasta_kayitlar;