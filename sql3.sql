--DML --> UPDATE
--eğer soruda değiştirin diyorsa
--önce update tablo_adi
--set stütun_adi
select * from personel;

--personel tablosunda id si 1001 olan öğrencinin ismini erol evren olarak değiştir
update personel
set isim='Erol Evren' -->where şartı kullanmadan update yaparsak bütün isimler erol evren olur 
where id='1001';

CREATE TABLE hastaneler
(
id char(5) primary key, 
isim char(30),
sehir char(15),
ozel char(1)
); 
insert into hastaneler values('H101', 'Aci Madem Hastanesi', 'Istanbul', 'Y');
insert into hastaneler values('H102', 'HasZeki Hastanesi', 'Istanbul', 'N');
insert into hastaneler values('H103', 'Medikol Hastanesi', 'Izmir', 'Y');
insert into hastaneler values('H104', 'Memoryil Hastanesi', 'Ankara', 'Y');
CREATE TABLE hastalar(
  kimlik_no CHAR(11) PRIMARY Key,
  isim CHAR(50) ,
  teshis  CHAR(20)
  );
  insert INTO hastalar values('12345678901','Ali Can','Gizli Seker');
  insert INTO hastalar values('45678901121','Ayse Yilmaz','Hipertansiyon');
  insert INTO hastalar values('78901123451','Steve Jobs','Pankreatit');
  insert INTO hastalar values('12344321251','Tom Hanks','COVID 19');
   
create table bolumler(
bolum_id char(5),
bolum_adi char(20)
);
insert into bolumler values('DHL','Dahiliye');
insert into bolumler values('KBB','Kulak Burun Bogaz');
insert into bolumler values('NRJ','Noroloji');
insert into bolumler values('GAST','Gastoroloji');
insert into bolumler values('KARD','Kardioloji');
insert into bolumler values('PSK','Psikiyatri');
insert into bolumler values('GOZ','Goz Hastaliklari');
create table hasta_kayitlar(
kimlik_no char(11) Primary key,
hasta_ismi char(20),
hastane_adi char(50),
bolum_adi char(20),
teshis char(20)
);
insert into hasta_kayitlar values('1111','NO NAME','','','');
insert into hasta_kayitlar values('2222','NO NAME','','','');
insert into hasta_kayitlar values('3333','NO NAME','','','');
insert into hasta_kayitlar values('4444','NO NAME','','','');
insert into hasta_kayitlar values('5555','NO NAME','','','');

/*
hasta_kayıtlar tablosundaki ‘3333’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.
hasta_isim : ‘Salvadore Dali’ ismi ile
hastane_adi: ‘John Hopins’
bolum_adi: ‘Noroloji’
teshis: ‘Parkinson’
kimlik_no: ‘99991111222’
*/

select * from hasta_kayitlar;

update hasta_kayitlar 
set hasta_ismi='Salvador Dali',
	hastane_adi='John Hopins',
	bolum_adi='Noroloji',
	teshis='Parkinson',
	kimlik_no='99991111222'
where kimlik_no='3333';

/*
hasta_kayıtlar tablosundaki ‘1111’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.
hasta_isim : hastalar tablosundaki kimlik nosu ‘12345678901’ olan kişinin ismi ile
hastane_adi: hastaneler tablosundaki 'H104' bolum_id kodlu hastanenin ismi ile
bolum_adi: bolumler tablosundaki 'DHL' bolum_id kodlu bolum_adi ile
teshis: hastalar tablosundaki 'Ali Can' isimli hastanın teshis bilgisi ile
kimlik_no: hastalar tablosundaki 'Ali Can' isimli hastanın kimlik_no kodu ile
*/
update hasta_kayitlar
set hasta_ismi=(select isim from hastalar where kimlik_no='12345678901'),
	hastane_adi=(select isim from hastaneler where id='H104'),
	bolum_adi=(select bolum_adi from bolumler where bolum_id='DHL'),
	teshis=(select teshis from hastalar where isim='Ali Can'),
	kimlik_no=(select kimlik_no from hastalar where isim='Ali Can')
where kimlik_no='1111';

--ALIAS
select hasta_ismi as isim from hasta_kayitlar;

--IS NULL condition
CREATE TABLE insanlar
(
ssn char(9),
name varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir'); 
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa');  
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');

select * from insanlar;

--insanlar tablosunda name değrei null olan tüm verileri listele
select * from insanlar where name is null;

--insanlar tablosunda name değrei null olmayan tüm verileri listele
select * from insanlar where name is not null;

--insanlar tablosunda name değrei null olan verilerin yerine isim girilmemiş yazdır
update insanlar set name='isim girilmemiş' where name is null;
select * from insanlar;

drop table insanlar

--ORDER BY
--asc --> küçükten büyüğe sıralar default değerdir
--desc --> büyükten küçüğe sıralar.yani tersten sıralar
CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

--insanlar tablosundaki adres sütununu alfabetik olarak sırala ve tüm verileri listele
select * from insanlar order by adres;

--insanlar tablosındaki soy isim sütununu tersten sırala
select * from insanlar order by soyisim desc;

--insanlar tablosındaki isim ve soyisimleri isme göre normal soyisme göre tersten sırala
select * from insanlar order by isim asc, soyisim desc;

-- isim soyisim sütunlarını soyisim kelime uzunluğuna göre sırala
select * from insanlar order by length(soyisim);

--isim ve soyisim sütunlarını birleştirme ve sıralama
select ssn,Concat(isim,' ',soyisim) as isim_soyisim from insanlar order by length(isim)

--GROUP BY
create table sirket(
isim varchar(20),    
sehir varchar(20),
maas int    
);
insert into sirket values ('erol','burdur',1000);
insert into sirket values ('erol','antalya',2000);
insert into sirket values ('erol','izmir',1500);
insert into sirket values ('ahmet','bursa',900);
insert into sirket values ('ahmet','izmir',2500);
insert into sirket values ('ahmet','istanbul',1800);
insert into sirket values ('mert','trabzon',1200);
insert into sirket values ('mert','istanbul',1000);
insert into sirket values ('mert','antep',2000);
insert into sirket values ('mert','tokat',3000);
insert into sirket values ('eda','antep',1200);
insert into sirket values ('eda','urfa',1500);
insert into sirket values ('erol','usak',2000);
insert into sirket values ('erol','burdur',900);

select * from sirket;

--şirkette çalışan farklı isimleri listele
select isim from sirket group by isim;

--şirkette kim hangi şehirde çalışıyor
select isim,sehir from sirket group by isim,sehir order by isim;

--group by komutu aggregate metodlarla kullanımı
--şirkette çalışanların toplam maaşını listele (group by ile yapmazsak hata verir)
select isim,sum(maas) as toplam_maas from sirket group by isim;

--şirkette çalışanların en yüksek ve en düşük maaşını listele (group by ile yapmazsak hata verir)
select isim,min(maas) as endusukmaas,max(maas) as enyuksekmaas,
round(avg(maas),2) as ortlamamaas from sirket group by isim;

--taboda kim kaç ilde çalışıyor, sehir sayısına göre sırala
select isim,count(sehir) as calistiği_iller from sirket group by isim order by count(sehir);

--HAVING --> sadece group by komutu ile kullanılır. Gruplamadan sonra where kullanılmaz.
--ikisi aynı işi yapar
--Toplam maasi 7000 in altında olan kişileri listele
select isim,sum(maas) from sirket group by isim having sum(maas)<7000;

--şehirlere göre ortalama maası 2000 altında olanları ortalama maasa göre tersten listele
select sehir,round(avg(maas)) as ort_maas 
from sirket group by sehir having avg(maas)<2000 order by ort_maas desc;

