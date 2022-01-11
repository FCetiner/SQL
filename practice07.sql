-- people tablosunda 'Daha sonra eklenecek' tüm boş değerleri değiştirin
update people
set name=coalesce(name,'Daha sonra eklenecek');
select * from people;
-- Boş adları "ad daha sonra eklenecek" olarak değiştirin
update people
set name='İsimler daha sonra eklenecek'
where name='Daha sonra eklenecek';
-- Boş adresleri 'Adres daha sonra eklenecek' olarak değiştirin
update people
set address='Adres daha sonra eklenecek'
where address is null;

-- *************************
select * from worker;
-- Veli Han'ın maaşını en yüksek maaştan yüzde 20 daha azına artırin
update worker
set worker_salary=((select max( worker_salary)from (select * from worker)as new_salary)*0.8)
where worker_name='Veli Han';

-- Ali Can'ın maaşını en düşük maaştan yüzde 30 daha fazla düşürun
update worker
set worker_salary= (select min(worker_salary) from (select * from worker)as new_salary)*0.7
where worker_name='oli Can';
-- Maaş ortalama maaştan düşükse maaşları 1000 artırın
update worker
set worker_salary=worker_salary+1000
where worker_salary< (select avg(worker_salary) from (select * from worker)as ortalama_maas);
-- Maaşın ortalama maaştan az olması durumunda maaşları ortalama maaşa eşitleyin 
update worker
set worker_salary=(select avg(worker_salary) from(select * from worker)as w)
where worker_salary<(select avg(worker_salary) from(select * from worker)as ww);

-------- Örnek 1: Hangi isimden kaç tane olduğunu bulun.
select ograd, count(ograd)adet from ogrenci
group by ograd
order by adet desc;
-------- Örnek 2: Sınıflardaki öğrenci sayısını bulun
select sinif, count(sinif)ogr_adet from ogrenci
group by sinif
order by sinif;
-------- Örnek 3: Her sınıftaki erkek ve kız öğrenci sayısını bulun.(cinsiyet ve sinifa göre grupla)
select sinif, count(cinsiyet) from ogrenci
group by sinif,cinsiyet
order by sinif;
-------- Örnek 4: Her türden kaç tane kitap olduğunu listeleyiniz.
select turno, count(turno) from kitap
group by turno
order by turno;
-------- Örnek 5: Her türdeki en fazla sayfa sayısı olan kitapları listeleyiniz.
select turno, max(sayfasayisi) from kitap
group by turno
order by turno;
-------- Örnek 6: Her türdeki en az sayfa sayısı olan kitapları listeleyiniz.
select turno, min(sayfasayisi) from kitap
group by turno
order by turno;
-------- Örnek 7***: Her türden kaç tane kitap olduğunu listeleyiniz.(Tür isimleri de olsun)
select (select kitap_turu from islemler where islemler.turno=kitap.turno) kitap_turu, count(idno) kitap_sayisi
from kitap group by turno
order by (select kitap_turu from islemler where islemler.turno=kitap.turno);
