
/*===================================================
	AGGREGATE FUNCTION COUNT,SUM,MIN,MAX, AVG)
====================================================*/
	
	-- COUNT
	-------------------------------------------------------------------------------------------------	
	
	/* invoices tablosunda kaç adet fatura bulunduğunu döndüren sorguyu yazınız*/
	SELECT COUNT(InvoiceId) AS num_of_records
	FROM invoices;
	
	SELECT COUNT(*) AS num_of_records
	FROM invoices
	WHERE BillingPostalCode IS NULL;
	
	/* tracks tablosunda kaç adet farklı Composer bulunduğunu döndüren sorguyu yazınız*/
	SELECT count(DISTINCT Composer) as Besteci_Sayisi
	FROM tracks;
	
	/*ÖDEV: invoices tablosunda kaç adet farklı yıl olduğunu hesaplayan sorguyu yazınız*/ 
	
	
	-- MIN,MAX
	-------------------------------------------------------------------------------------------------	
	/* tracks tablosundaki şarkı süresi en kısa olan şarkının adını ve süresi listeleyen
	sorguyu yaziniz */
	
	SELECT Name AS Song_Name, MIN(Milliseconds) AS Min_Duration
	FROM tracks;
		
	/*students tablosundaki en düşük ve en yüksek notu listeleyen sorguyu yazınız */
	SELECT MIN(Grade) as min_grade, MAX(Grade) as max_grade
	FROM students;
	
	-- SUM,AVG
	-------------------------------------------------------------------------------------------------	
	/* invoices  tablosundaki faturaların toplam değerini listeyiniz */
	
	SELECT SUM(total) as total_invoices
	FROM invoices;
	
	/* invoices  tablosunda 2009 ile 2013 tarihileri arasındaki faturaların toplam 
	değerini listeyiniz */
	SELECT SUM(total) as total_invoices
	FROM invoices
	WHERE InvoiceDate BETWEEN '2009%' AND '2013-12-31';
	
	
	/* tracks  tablosundaki şarkıların ortalama duration değerini */
	SELECT ROUND(AVG(Milliseconds)) AS ort_duration
	FROM tracks;
		
	/* tracks tablosundaki şarkıların ortalama süresinden daha uzun olan 
	şarkıların adlarını listeleyiniz */
	SELECT Name, Milliseconds
	FROM tracks
	WHERE Milliseconds>393599;
	
	/*Bu yöntem hard-coded olduğu için çok mantıklı bir çözüm değil. 
	alt-sorgu(sub-query) ile daha doğru bir yaklaşım olacaktır sonraki 
	bölümlerde alt-sorguyu ayrıntılı bir şekilde inceleyeceğiz.*/
	
	SELECT Name, Milliseconds
	FROM tracks
	WHERE Milliseconds > (	SELECT AVG(Milliseconds) 
										FROM tracks);
										
													
/*===================================================
 GROUP BY
====================================================*/

	/* tracks tablosundaki her bir Bestecisinin (Composer) toplam şarkı sayısını 
	Besteci adına göre gruplandırarak listeleyen sorguyu yazınız. */
	
	SELECT Composer , COUNT(Name)
	FROM tracks
	WHERE Composer IS NOT NULL
	GROUP BY Composer;

	
	/* customers tablosundaki müşterilerin sayılarını Ülkelerine (Country) göre gruplandırarak 
	ve müşteri sayısına göre AZALAN şekilde sıralayarak listeleyen sorguyu yazınız*/
	
	SELECT country, Count(CustomerId) as no_of_customers
	FROM customers
	GROUP BY country
	ORDER BY no_of_customers DESC, country ASC;
		
	/* tracks tablosundaki herbir albumü AlbumId'lerine göre gruplandırarak 
	her albumdeki minumum şarkı sürelerini listeleyen sorguyu yazınız */
	
	SELECT AlbumId, MIN(Milliseconds) as Min_Duration
	FROM tracks
	GROUP BY AlbumId;
	
	/* invoices tablosundaki her bir ülkenin (BillingCountry) fatura ortalamalarını 
	hesaplayan ve ülke bilgileri ile listeleyen sorguyu yazınız.*/
	
	SELECT BillingCountry, ROUND(AVG(total)) as ort_fatura
	FROM invoices
	GROUP BY BillingCountry;
		
/*===================================================
        JOINS
====================================================*/
    
--     Join islemleri farkli tablolardan secilen sutunlar ile yeni bir tablo 
--     olusturmak icin kullanilabilir.
--     
--     JOIN islemleri Iliskisel Veritabanlari icin cok onemli bir ozelliktir. Çunku
--    	Foreign Key'ler ile iliskili olan tablolardan istenilen sutunlari cekmek 
--     icin JOIN islemleri kullanilabilir.

--     Standart SQL'de en çok kullanılan Join islemleri:
--   	1) FULL JOIN:  Tablodaki tum sonuclari gosterir
--     2) INNER JOIN:  Tablolardaki ortak olan sonuc kumesini gosterir
--     3) LEFT JOIN:  Ilk tabloda (Sol) olup digerinde olmayan sonuclari gosterir
--     4) RIGHT JOIN: Sadece Ikinci tabloda olan tum sonuclari gosterir.

--		NOT: SQLite Sadece INNER, LEFT VE CROSS JOIN İşlemlerini desteklemektedir.
 
 /*===================================================*/   

  /* araclar.db adındaki veritabanını kullanarak Markalar ve Siparisler tablolarındaki 
 marka_id’si ayni olan kayıtların marka_id, marka_adi, siparis_adedi ve siparis_tarihi   
 bilgilerini  listeleyen bir sorgu yaziniz.*/
 
	 SELECT * FROM markalar;
	 SELECT *FROM siparisler;
	 
	 SELECT siparisler.marka_id, markalar.marka_adi, 
				 siparisler.siparis_adedi, siparisler.siparis_tarihi 
	 FROM siparisler
	 JOIN markalar ON siparisler.marka_id = markalar.marka_id;
	 
	 /* Daha kısa olarak*/
	SELECT s.marka_id, m.marka_adi, 
				 s.siparis_adedi, s.siparis_tarihi 
	 FROM siparisler s
	 JOIN markalar m ON s.marka_id = m.marka_id;
 

/* Markalar ve Siparisler tablolarındaki tüm araç markalarının siparis bilgilerini
   (marka_id,marka_adi,siparis_adedi,siparis_tarihi) listeleyen bir sorgu yaziniz.*/
	
	 SELECT m.marka_id, m.marka_adi, 
				 s.siparis_adedi, s.siparis_tarihi 
	 FROM markalar m
	 LEFT JOIN siparisler s ON s.marka_id = m.marka_id;
	 
	 
/* Chinook veritabanındaki tracks tablosunda bulunan her bir şarkının türü (genre)
listeleyiniz.*/
	select * from genres;
	select * from tracks;

	SELECT  t.Name as song_name, g.Name as genre_type
	FROM tracks t
	JOIN genres g
	on t.GenreId = g.GenreId;

 /* invoice tablosundaki faturaların her birinin müşteri adını (FirstName),
 soyadını (lastName), fatura tarihi (InvoiceDate) ve fatura meblağını (total) 
 listeleyen sorguyu yazınız */
	select * from invoices;
	SELECT * from customers;
	
	SELECT c.FirstName, c.LastName, i.InvoiceDate, i.total
	FROM invoices i
	left JOIN customers c
	ON i.CustomerId = c.CustomerId;
	
/* artists tablosunda bulunan kişilerin albums tablosundaki 
albümlerini listeleyen sorguyu yazınız. 
Sorguda ArtistId, Name, Title ve AlbumId olmalıdır */

	SELECT * FROM artists;
	SELECT * FROM albums;
	
	SELECT ar.ArtistId, ar.name, al.Title,al.AlbumId
	FROM artists	ar
	JOIN albums al
	ON ar.ArtistId = al.ArtistId;

  /* artists tablosunda bulunan TÜM KİŞİLERİN albums tablosunda 
  bulunan albümlerini listeleyen sorguyu yazınız. 
  Sorguda ArtistId, Name, Title ve AlbumId olmalıdır*/
 	
	SELECT ar.ArtistId, ar.name, al.Title,al.AlbumId
	FROM artists	ar
	LEFT JOIN albums al
	ON ar.ArtistId = al.ArtistId;
