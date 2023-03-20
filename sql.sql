--database oluşturma
Create database deneme;
--DDL(Data Definition Language) Create
Create table ogrenciler1(
ogr_no varchar(10),
isim varchar(10),
tel varchar(15),
email varchar(25),
kayit_tarihi date
);
-- oluşturulan tablodan yeni bir tablo oluşturma
CREATE TABLE ogr_bilgi 
AS SELECT isim,tel FROM ogrenciler1;
--DML -> Data manipulation language -> INSERT(tabloya veri ekleme)
--tüm sütunlara veri ekleme
insert into ogrenciler1 values ('1234','Erol','05321546244','erol@gmail.com','06-03-2023');
--bazı sütunlara veri ekleme,parçalı veri ekleme
insert into ogrenciler1 (isim,tel,email) values('Evren','04564868','evren@gmail.com');

create table tedarikciler(
tedarikci_id char(4),
tedarikci_ismi varchar(25),
tedarikci_adres varchar(50),
ulasim_tarihi date
);

create table tedarikci_ziyaret 
as select tedarikci_ismi,ulasim_tarihi from tedarikciler;

--DQL -> Data Query Language ->Select
--Tablodaki tüm sütun bilgilerini select komutu getirir
select * from ogrenciler1;
--tablodaki istediğimiz bir veya birden fazla sütunu getirmek için
select isim,tel from ogrenciler1;
--constraint(kısıtlama)
--UNİQUE
--unique kısıtlamalarını constraints içinde görebiliriz
--not null kısımlarını properties->coulumn dan görebilirz
--not: kısıtlamalar tablo oluşturulurken yapılmaldır.sonradan alter komutu ile 
--kısıtlama eklenebilir fakat bu ilişkili tablolarda sorun teşkil edebilir.
Create table ogrenciler5(
ogr_no varchar(10),
isim varchar(10) unique,
tel varchar(15) not null,
email varchar(25) not null,
kayit_tarihi date,
constraint uniq_ky UNIQUE(tel) --hem not null hem unique eklemek istersek
UNIQUE(email)
);

select * from ogrenciler4;
insert into ogrenciler4 values ('1234','Erol','05321546244','erol@gmail.com','06-03-2023');
insert into ogrenciler4 (isim,email) values ('evren','evren@gmail.com')
insert into ogrenciler4 values ('12345','ErolEvren','','erol1@gmail.com','06-03-2023');

/*
--ERROR:  null value in column "isim" of relation "personel" violates not-null constraint
Bu Insert islemini kabul etmez ve yukardaki gibi hata verir. Çünkü isim sütununa NOT NULL kısıtlaması
tablo oluştururken atanmıştır, dolayısıyla isim sütunu boş geçilemez.
*/
Create table personel(
id varchar(10),
isim varchar(50) not null,
soyisim varchar(50),
email varchar(50),
ise_baslama_tarihi date
maas int
);

select * from personel
insert into personel (id,soyisim) values ('12345','Evren');
--PRIMARY KEY
--Tabloya Primary Key ataması 1.Yol
CREATE TABLE personel
(
id char(10) primary key,
isim varchar(50),  
soyisim varchar(50),
email varchar(50),
ise_baslama_tar date,  
maas int    
);
--Tabloya Primary Key ataması 2.Yol
CREATE TABLE personel
(
id char(10),
isim varchar(50),  
soyisim varchar(50),
email varchar(50),
ise_baslama_tar date,  
maas int,
CONSTRAINT pk PRIMARY KEY (id)    
);
--Tabloya Primary Key ataması 3.Yol
CREATE TABLE personel
(
id char(10),
isim varchar(50),  
soyisim varchar(50),
email varchar(50),
ise_baslama_tar date,  
maas int,
PRIMARY KEY (id)    
);

--foreign key  -> primary key  olan tablo ile bağlantı kuracak diğer tablodaki foreign key ataması yapılır
create table tedarikciler(
tedarikci_id varchar(10) primary key,
tedarikci_ismi varchar(30),
iletisim_isim varchar(50)
);
create table urunler(
tedarikci_id varchar(10),
urun_id varchar(10),
foreign key(tedarikci_id) references tedarikciler(tedarikci_id)
);






