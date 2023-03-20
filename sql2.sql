--primary key foreign key practice

create table student(
st_no char(4) primary key,
isim varchar(10),
soyisim varchar(20),
tel varchar(11),
email varchar(20),
sehir varchar(20)
);

select * from student;

INSERT INTO student VALUES ('1234','Erol','Evren','053213546','erol@gmail.com','Ankara');
INSERT INTO student VALUES ('1235','Berk','Can','05322564','berk@gmail.com','Bursa');
INSERT INTO student VALUES ('1236','Rümeysa','Kaya','05325465','rümeysa@gmail.com','Izmir');
INSERT INTO student VALUES ('1237','Ahmet','Erkan','053215467','ahmet@gmail.com','Istanbul');
INSERT INTO student VALUES ('1238','Emre','Can','0532165466','emre@gmail.com','Burdur');

create table notlar(
st_no char(4),
donem varchar(10),
ilkvizenotu real,
ikincivizenotu real,
finalnotu real,
foreign key (st_no) references student(st_no)
);


INSERT INTO notlar VALUES ('1234','1. Dönem',75.5,80,85.5);
INSERT INTO notlar VALUES ('1235','1. Dönem',70,65,82.5);
INSERT INTO notlar VALUES ('1236','1. Dönem',65,95,70);
INSERT INTO notlar VALUES ('1237','1. Dönem',55,95,70);
INSERT INTO notlar VALUES ('1238','1. Dönem',0,50,85);
INSERT INTO notlar VALUES ('1234','2. Dönem',65,80.5,75);
INSERT INTO notlar VALUES ('1235','2. Dönem',55,75,95);

--DQL ->Data Query Language -> WHERE koşulu
--student tablosundan berk isimli öğrencinin tel ve email bilgisini listeleme
select isim,tel,email from student where isim='Berk';

--öğrenci numarası 1236 olan öğrencinin bilgileri
select * from student where st_no='1236';

--öğrenci numarası 1236 olan öğrencinin isim,tel,email bilgileri
select isim,tel,email from student where st_no='1236';

select * from notlar;

--öğrenci numarası 1238 olan öğrencinin notları
select * from notlar where st_no='1238';

--öğrenci numarası 1238 olan öğrencinin notları
select * from notlar where st_no='1234';

--check constraint --> Bir sütunu sınırlandırmak için kullanılır
create table notlar(
st_no char(4),
donem varchar(10),
ilkvizenotu real,
ikincivizenotu real check (ikincivizenotu>45),
finalnotu real check (finalnotu>45), --verilen koşuldan küçük veya eşitse tabloya eklenen değer check constraint hatası verir
foreign key (st_no) references student(st_no)
);

INSERT INTO notlar VALUES ('1234','1. Dönem',75.5,80,85.5);
INSERT INTO notlar VALUES ('1235','1. Dönem',70,65,82.5);
INSERT INTO notlar VALUES ('1236','1. Dönem',65,95,70);
INSERT INTO notlar VALUES ('1237','1. Dönem',55,95,70);
INSERT INTO notlar VALUES ('1238','1. Dönem',0,50,85);
INSERT INTO notlar VALUES ('1234','2. Dönem',65,80.5,75);
INSERT INTO notlar VALUES ('1235','2. Dönem',55,46,50);

select * from notlar;

--notlar tablosundaki 80 üzerindeki ikinci vize notları listele
select ikincivizenotu from notlar where ikincivizenotu > 80;

select ilkvizenotu from notlar where ilkvizenotu < 65;

--DML -> Delete komutu 
--Delete from tablo_adi
delete from notlar; --notlat tablosındaki tüm veriler silinir

--notlar tablosunda st_no=1234 olan verinin tüm notlarını silme
delete from notlar where st_no='1234' --child table dan sildiğimiz veriyi parent tende silebilriz

--student tablosundan öğrenci numarısı=1234 olan verinin tüm bilgilerini sil
delete from student where st_no='1234';
select * from student;

--ilişkili tablolarda child tablodan veri silmeden parent tablodan silemeyiz. eğer o veriyi silmek istiyorsak 
--önce child tablodan sonra parent tablodan silmeliyiz
--NOT: child tabloda olan bir veriyi parent tablodan silmeye çalışırsak hata verir
--ERROR:  update or delete on table "student" violates foreign key constraint "notlar_st_no_fkey" on table "notlar"
delete from student where st_no='1235';

select * from student;

--Truncate komutu ile tablodaki tüm verileri silebirliz ama koşullu silme yapamayız
Truncate Table notlar;


-- ON DELETE CASCADE -->Bu komut sayesinde parent tablodan istediğimiz veriyi silebiliriz.
--Parent tablodan sildiğimiz zaman child tablodan da silinir
Create table notlar(
st_no char(4),
donem varchar(10),
ilkvizenotu real,
ikincivizenotu real check (ikincivizenotu>45),
finalnotu real check (finalnotu>45),
FOREIGN KEY (st_no) references student (st_no) ON DELETE CASCADE    
);

INSERT INTO notlar VALUES ('1234','1. Dönem',75.5,80,85.5);
INSERT INTO notlar VALUES ('1235','1. Dönem',70,65,82.5);
INSERT INTO notlar VALUES ('1236','1. Dönem',65,95,70);
INSERT INTO notlar VALUES ('1237','1. Dönem',55,95,70);
INSERT INTO notlar VALUES ('1238','1. Dönem',0,50,85);
INSERT INTO notlar VALUES ('1234','2. Dönem',65,80.5,75);
INSERT INTO notlar VALUES ('1235','2. Dönem',55,46,50);

select * from notlar;

--student tablosundan 1234 nolu öğrencinin tüm veirlerini sil
delete from student where st_no='1234';

/*on delete cascade kullanmadan parent tabloyu tamamen kaldırmak istersek,
önce child table kaldırmız gerekir. On delete cascade komutunu child table oluşturuken
kullandıysa (drop table parent_tablo_ismi cascade) yazarak kaldırabilriz.*/
drop table tablo_adi --> tabloyu database den tamamen kaldırma komutu(on delete cascade kullandıysam çalışır)

--IN CONDITION
CREATE TABLE musteriler(
urun_id int,  
musteri_isim varchar(50),  
urun_isim varchar(50)
);

INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');  
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');  
INSERT INTO musteriler VALUES (20, 'John', 'Apple');  
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');  
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');  
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');  
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');  
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

select * from musteriler;

--AND --> her iki şartı birden sağlaması gerekir farklı sütunlar için kullanılır
--ürün ismi orange ile apple olan müsteri isimlerini listele
select musteri_isim,urun_isim from musteriler where urun_isim='Orange' or urun_isim='Apple';

--2.Yol Condition kullanımı
select musteri_isim,urun_isim from musteriler where urun_isim in ('Orange','Apple');

--müsteri ismi Amy ve ürün ismi palm olan verileri listele
select musteri_isim,urun_isim from musteriler where musteri_isim='Amy' and urun_isim='Palm';

--not in
--ürün ismi orange ile apple olmayan müşteri ve ürün isimlerini listele
select musteri_isim,urun_isim from musteriler where urun_isim not in('Orange','Apple');

--BETWEEN
--ürün_id değerleri 20 ile 40 arasında olan tüm verileri listeleyinz
select * from musteriler where urun_id>=20 and urun_id<=40;
select * from musteriler where urun_id between 20 and 40;

--not between
--ürün_id değerleri 20 ile 40 arasında olmayan tüm verileri listeleyinz
select * from musteriler where urun_id<20 or urun_id>40;
select * from musteriler where urun_id not between 20 and 40;

--Practice 6
drop table personel;
CREATE table personel
(
id char(4),
isim varchar(50),
maas int
);
insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000);

select * from personel;

--id'si 1003 ile 1005 arasında olan personel bilgilerini listeleyiniz
select * from personel where id between '1003' and '1005';

--D ile Y arasındaki personel bilgilerini listeleyiniz
select * from personel where isim between 'Derya Soylu' and 'Yavuz Bal';

--D ile Y arasında olmayan personel bilgilerini listeleyiniz
select * from personel where isim not between 'Derya Soylu' and 'Yavuz Bal';

--Maaşı 70000 ve ismi Sena olan personeli listeleyiniz
select * from personel where maas=70000 or isim='Sena Beyaz';

--SUBQUERY(alt sorgu)
CREATE TABLE calisanlar2 
(
id int, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas int, 
isyeri VARCHAR(20)
);
INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

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

select * from calisanlar2;

--çalışan sayısı 15000 den büyük olan markaların isimlerini ve bu markada çalışanların isimlerini ve maaşalrını listele
select isyeri,isim,maas from calisanlar2 
where isyeri in (select marka_isim from markalar where calisan_sayisi>15000);

--marka_id si 101 den büyük olan marka çalışanlarının isim,maas,sehirlerini listele
select isim,maas,sehir from calisanlar2 
where isyeri in (select marka_isim from markalar where marka_id>101);

--AGGREGATE METHOD -->(sum(),count(),min(),max(),avg())
--calisanlar tablosundaki en yüksek maası listele
select max(maas) as en_yuksek_maas from calisanlar2;

--calisanlar tablosundaki en dusuk maası listele
select min(maas) as en_dusuk_maas from calisanlar2;

--calisanlar tablosunda kaç kişi var listele
select count(isim) from calisanlar2;
select count(*) as kisi_sayisi from calisanlar2;

--calisanlar tablosundaki maasların maas ortlaması
select avg(maas) from calisanlar2;

--avg() metodunda çıkan sonucu yuvarlama
select round(avg(maas)) from calisanlar2;
select round(avg(maas),2) as ortalama_maas from calisanlar2;

-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listele
--ayrı bir kolon oluşturduğumuz için where in le yapamayız galiba
select marka_id,marka_isim, (select count(sehir)from calisanlar2 where isyeri=marka_isim)from markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
SELECT marka_isim, calisan_sayisi,
(SELECT sum(maas) FROM calisanlar WHERE marka_isim = isyeri) as toplam_maas FROM markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maaşini listele
SELECT marka_isim, calisan_sayisi, (SELECT max(maas) FROM calisanlar WHERE marka_isim = isyeri) as max_maas,
(SELECT min(maas) FROM calisanlar WHERE marka_isim = isyeri) as min_maas
FROM markalar;

--EXISTS CONDITION
CREATE TABLE mart
(   
urun_id int,    
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan 
(   
urun_id int ,
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

select * from mart
select * from nisan

/*MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
 URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
 MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız.*/
SELECT urun_id,musteri_isim FROM mart
WHERE exists (select urun_id FROM nisan WHERE mart.urun_id=nisan.urun_id);






