
/*===================================================
        SUBQUERIES
====================================================*/

	/* albums tablosundaki Title sutunu ‘Faceless’ olan kaydın albumid'sini elde ederek 
	tracks tablosunda bu değere eşit olan kayıtların bilgilerini SUBQUERY yazarak listeyiniz.
	Listelemede trackid, name ve albumid bilgilerini bulunmalıdır. */

	SELECT TrackId,Name, AlbumId
	FROM tracks
	WHERE 	AlbumId = (SELECT AlbumId 
	 FROM albums
		WHERE title= 'Faceless');

	/* albums tablosundaki Title sutunu ‘Faceless’ olan kaydın albumid'si elde ederek 
	tracks tablosunda bu değere eşit olan kayıtların bilgilerini JOIN kullanarak listeyiniz.
	Listelemede trackid, name ve albumid bilgileri bulunmalıdır. */				
	
	SELECT t.TrackId,  t.Name,  t.AlbumId
	FROM tracks t
	JOIN albums a
	ON t.AlbumId = a.AlbumId
	WHERE a.Title = 'Faceless';
	
	
	/* albums tablosundaki Title sutunu Faceless veya Let There Be Rock olan kayıtların 
	albumid'lerini elde ederek tracks tablosunda bu id'lere eşit olan kayıtların bilgilerini 
	SUBQUERY kullanarak listeyiniz. 
	Listelemede trackid, name ve albumid bilgileri bulunmalıdır. */	
	SELECT TrackId,Name, AlbumId
	FROM tracks
	WHERE AlbumId IN (SELECT AlbumId 
	 FROM albums 
		WHERE title IN ('Faceless','Let There Be Rock'));
	
	/* albums tablosundaki Title sutunu Faceless veya Let There Be Rock olan kayıtların 
	albumid'lerini elde ederek tracks tablosunda bu id'lere eşit olan kayıtların bilgilerini 
	JOIN kullanarak listeyiniz.Listelemede trackid, name ve albumid bilgileri bulunmalıdır. */	
	
	SELECT t.TrackId, t.Name, t.AlbumId
	FROM tracks t
	JOIN albums a 
	ON t.AlbumId= a.AlbumId
	WHERE a.Title IN ('Faceless' ,'Let There Be Rock');
	
/*===================================================
        DDL COMMANDS (CREATE TABLE, DROP TABLE,ALTER TABLE)
====================================================*/	
	
	/*------------------------------------------------------------------------------------------
	/*  CREATE TABLE
	/*------------------------------------------------------------------------------------------
	
	/*personel adinda bir tablo oluşturunuz.  Tabloda first_name, last_name 
	age(INT) ve hire_date (Date) sutunuları bulunmalıdır.*/
	CREATE TABLE personel (
		first_name VARCHAR(20),
		last_name TEXT,
		age INT,
		hire_date DATE
	);
	
	/* Aynı isimle yeniden bir veritabanı oluşturalmak istenirse hata verir. Bu hatayı
	almamak için IF NOT EXISTS keywordu kullanılabilir */
	CREATE TABLE IF NOT EXISTS personel (
		first_name VARCHAR(20),
		last_name VARCHAR(20),
		age INT,
		hire_date DATE
	);
	
	/*Veritabanında vacation_plan adında yeni bir tablo oluşturunuz.  Sutun isimleri
	place_id, country, hotel_name, employee_id, vacation_length, budget */
	
	CREATE TABLE vacation_plan(
		place_id INTEGER,
		country TEXT,
		hotel_name TEXT,
		employee_id INTEGER,
		vacation_length INTEGER,
		budget REAL
	);
	
	/*------------------------------------------------------------------------------------------
	/*  DROP TABLE
	/*------------------------------------------------------------------------------------------
	
	/* personel tablosunu siliniz */
	DROP TABLE personel;
	
	/* Bir tabloyu silerken tablo bulunamazsa hata verir. Bu hatayı görememek için
	IF EXISTS keywordu kullanılabilir.*/
	DROP TABLE IF EXISTS personel;
		
	-- NOT: SQL'de TRUNCATE TABLE komutu bulunmasına karşın SQLite bu komutu 
	-- desteklememektedir. Truncate komutu  bir tabloyu değil içindeki tüm verileri 
	-- silmek için kullanılır.
		
	/*------------------------------------------------------------------------------------------
	/*  INSERT INTO
	/*----------------------------------------------------------------------------------------*/

	/* vacation_plan tablosuna 2 kayıt gerçekletiriniz.*/
	INSERT INTO vacation_plan VALUES(34,'Turkey', 'Happ hotel',1 , 7,3000);

	
	-- NOT: Aynı komut tekrar çalıştırılırsa herhangi bir kısıt yoksa ise aynı veriler
	-- tekrar tabloya girilmiş olur. 
	
	/*vacation_plan tablosuna hotel_name, vacation_lenght,budget sutunlarını 
	eksik olarak veri girişi yapınız*/
	INSERT INTO vacation_plan (place_id,country,employee_id) VALUES(48,'Turkey', 2 );
	-- NOT : giriş yapılmayan sutunlara NULL atanır.
	
	/*------------------------------------------------------------------------------------------
	/*  CONSTRAINTS - KISITLAMALAR 
	/*-----------------------------------------------------------------------------------------
  NOT NULL - Bir Sütunun NULL içermemesini garanti eder. 
		UNIQUE - Bir sütundaki tüm değerlerin BENZERSİZ olmasını garanti eder. 
		PRIMARY KEY - Bir sütünün NULL içermemesini ve sütundaki verilerin 
                BENZERSİZ olmasını garanti eder.(NOT NULL ve UNIQUE birleşimi gibi)
		FOREIGN KEY - Başka bir tablodaki Primary Key’i referans göstermek için kullanılır.
		             Böylelikle, tablolar arasında ilişki kurulmuş olur. 
		DEFAULT - Herhangi bir değer atanmadığında Başlangıç değerinin atanmasını sağlar.
	/*----------------------------------------------------------------------------------------*/
	
	CREATE TABLE workers (
		id INTEGER PRIMARY KEY,
		id_number VARCHAR(11) UNIQUE NOT NULL,
		name TEXT DEFAULT 'NONAME',
		salary INTEGER NOT NULL
	);
	
	INSERT INTO workers VALUES( 1, '12345678910', 'HALİL PATRON', 120000);
	--NOT NULL Violation
	INSERT INTO workers (id,id_number,name) VALUES( 3, '12345678220', 'KENAN BAŞGAN');
			