/*==============================================
			TABLO OLUŞTURMA (Crud işlemlerinden Create)
================================================
*/
-- tek satırlık yorum iki tire boşluk
use sys;
CREATE TABLE student
(id VARCHAR(4), -- İLK SUTUN VİRGULLE AYRILDI
NAME VARCHAR(25),
AGE int	-- sonuncuda virgul konulmuyor
); -- noktalı virgül komut bitişidir

INSERT INTO student VALUES('1001', 'MEHMET ALİ', 25);
INSERT INTO student VALUES('1002', 'AYSE YILMAZ', 34);
INSERT INTO student VALUES('1003', 'JOHN STAR', 56);
INSERT INTO student VALUES('1004', 'MARY BROWN', 17);

select * from student;


