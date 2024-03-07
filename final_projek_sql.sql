-- First Month Transaction
SELECT customer_id, 
       MIN(EXTRACT(MONTH FROM order_date)) AS first_month 
FROM customer_transaction
GROUP BY customer_id;

SELECT * FROM customer_transaction
WHERE promo_code = 'Yes'

--1.

SELECT COUNT(*) as jumlah_transaksi
FROM customer_transaction

--WHERE EXTRACT(YEAR FROM order_date) = '2023'

SELECT * FROM customer_transaction


--2.

SELECT 
	COUNT (DISTINCT customer_id) as jumlah_customer_unik
FROM customer_transaction

--3.
SELECT SUM(revenue) as total_revenue
FROM
(
	SELECT *,
		CASE 
		WHEN discount_applied = 'Yes' THEN ROUND(((100-discount)/100)*purchase_amount_usd, 2)
		ELSE purchase_amount_usd
		END AS revenue
	FROM customer_transaction
)

	
--4.	Ada berapa kategori product yang dijual di tahun 2023?
SELECT 
COUNT(DISTINCT category) as jumlah_kategori_produk
FROM customer_transaction

--
SELECT category
FROM customer_transaction
GROUP BY category


--5.	Ada Berapa product yang dijual di tahun 2023?
SELECT 
COUNT(DISTINCT item_purchased) as jumlah_produk_terjual
FROM customer_transaction

--
SELECT item_purchased
FROM customer_transaction
GROUP BY item_purchased

--6.	Berapa rata-rata umur customer yang bertransaksi di tahun 2023?
SELECT 
	ROUND(AVG(age), 2) as rata_rata_umur
FROM customer_transaction

-- di gabung keseluruhan

SELECT COUNT(*) AS jumlah_transaksi,
       COUNT(DISTINCT customer_id) AS jumlah_customer,
       ROUND(SUM(CASE WHEN discount_applied = 'Yes' 
                      THEN (100-discount)/100*purchase_amount_usd
                      ELSE purchase_amount_usd END),2) AS total_revenue,
       COUNT(DISTINCT category) AS jumlah_kategori_produk,
       COUNT(DISTINCT item_purchased) AS jumlah_produk_terjual,
       ROUND(AVG(age),0) AS rata_rata_umur
FROM customer_transaction

-- PERFORMANCE ANALYSIS
--1. Bagaimana overall performance  GenggamData Store ditahun 2023 untuk jumlah order dan total sales ?
--daily
SELECT order_date,
       COUNT(*) AS jumlah_order,
       SUM(purchase_amount_usd) AS total_sales
FROM customer_transaction
GROUP BY order_date
ORDER BY order_date

--monthly

SELECT EXTRACT(MONTH FROM order_date) as bulan,
       COUNT(*) AS jumlah_order,
       SUM(purchase_amount_usd) AS total_sales
FROM customer_transaction
GROUP BY bulan
ORDER BY bulan

--atau

SELECT 
    CASE 
        WHEN EXTRACT(MONTH FROM order_date) = 1 THEN 'januari'
        WHEN EXTRACT(MONTH FROM order_date) = 2 THEN 'februari'
        WHEN EXTRACT(MONTH FROM order_date) = 3 THEN 'maret'
        WHEN EXTRACT(MONTH FROM order_date) = 4 THEN 'april'
        WHEN EXTRACT(MONTH FROM order_date) = 5 THEN 'mei'
        WHEN EXTRACT(MONTH FROM order_date) = 6 THEN 'juni'
        WHEN EXTRACT(MONTH FROM order_date) = 7 THEN 'juli'
        WHEN EXTRACT(MONTH FROM order_date) = 8 THEN 'agustus'
        WHEN EXTRACT(MONTH FROM order_date) = 9 THEN 'september'
        WHEN EXTRACT(MONTH FROM order_date) = 10 THEN 'oktober'
        WHEN EXTRACT(MONTH FROM order_date) = 11 THEN 'november'
        ELSE 'desember'
    END AS bulan,
    COUNT(*) AS jumlah_order,
    SUM(purchase_amount_usd) AS total_sales
FROM 
    customer_transaction
GROUP BY 
    EXTRACT(MONTH FROM order_date)
ORDER BY 
    CASE 
        WHEN EXTRACT(MONTH FROM order_date) = 1 THEN 1
        WHEN EXTRACT(MONTH FROM order_date) = 2 THEN 2
        WHEN EXTRACT(MONTH FROM order_date) = 3 THEN 3
        WHEN EXTRACT(MONTH FROM order_date) = 4 THEN 4
        WHEN EXTRACT(MONTH FROM order_date) = 5 THEN 5
        WHEN EXTRACT(MONTH FROM order_date) = 6 THEN 6
        WHEN EXTRACT(MONTH FROM order_date) = 7 THEN 7
        WHEN EXTRACT(MONTH FROM order_date) = 8 THEN 8
        WHEN EXTRACT(MONTH FROM order_date) = 9 THEN 9
        WHEN EXTRACT(MONTH FROM order_date) = 10 THEN 10
        WHEN EXTRACT(MONTH FROM order_date) = 11 THEN 11
        ELSE 12
    END


--2. .Bagaimana overall performance berdasarkan kategori produk GenggamData Store ditahun 2023 untuk jumlah order dan total sales ?
--
SELECT EXTRACT(MONTH FROM order_date) AS bulan,
       category,
       COUNT(*) AS jumlah_order,
       SUM(purchase_amount_usd) AS total_sales
FROM customer_transaction
GROUP BY bulan, category
ORDER BY bulan

--atau

SELECT 
    CASE 
        WHEN EXTRACT(MONTH FROM order_date) = 1 THEN 'januari'
        WHEN EXTRACT(MONTH FROM order_date) = 2 THEN 'februari'
        WHEN EXTRACT(MONTH FROM order_date) = 3 THEN 'maret'
        WHEN EXTRACT(MONTH FROM order_date) = 4 THEN 'april'
        WHEN EXTRACT(MONTH FROM order_date) = 5 THEN 'mei'
        WHEN EXTRACT(MONTH FROM order_date) = 6 THEN 'juni'
        WHEN EXTRACT(MONTH FROM order_date) = 7 THEN 'juli'
        WHEN EXTRACT(MONTH FROM order_date) = 8 THEN 'agustus'
        WHEN EXTRACT(MONTH FROM order_date) = 9 THEN 'september'
        WHEN EXTRACT(MONTH FROM order_date) = 10 THEN 'oktober'
        WHEN EXTRACT(MONTH FROM order_date) = 11 THEN 'november'
        ELSE 'desember'
    END AS bulan,
	category,
    COUNT(*) AS jumlah_order,
    SUM(purchase_amount_usd) AS total_sales
FROM 
    customer_transaction
GROUP BY 
    EXTRACT(MONTH FROM order_date),category
ORDER BY jumlah_order desc,
    CASE 
        WHEN EXTRACT(MONTH FROM order_date) = 1 THEN 1
        WHEN EXTRACT(MONTH FROM order_date) = 2 THEN 2
        WHEN EXTRACT(MONTH FROM order_date) = 3 THEN 3
        WHEN EXTRACT(MONTH FROM order_date) = 4 THEN 4
        WHEN EXTRACT(MONTH FROM order_date) = 5 THEN 5
        WHEN EXTRACT(MONTH FROM order_date) = 6 THEN 6
        WHEN EXTRACT(MONTH FROM order_date) = 7 THEN 7
        WHEN EXTRACT(MONTH FROM order_date) = 8 THEN 8
        WHEN EXTRACT(MONTH FROM order_date) = 9 THEN 9
        WHEN EXTRACT(MONTH FROM order_date) = 10 THEN 10
        WHEN EXTRACT(MONTH FROM order_date) = 11 THEN 11
        ELSE 12
    END


--3. Bagaimana growth order dan sales GenggamData Store ditahun 2023 ?

SELECT 
	bulan,
	ROUND(((jumlah_order/LAG(jumlah_order) OVER(ORDER BY bulan))-1)*100, 2) as growth_order,
	ROUND(((total_sales/LAG(total_sales) OVER(ORDER BY bulan))-1)*100,2) as growth_sales
FROM
(
	SELECT
		EXTRACT (MONTH FROM order_date) AS bulan,
		CAST(COUNT(*) AS numeric) AS jumlah_order,
    	SUM(purchase_amount_usd) AS total_sales
	FROM customer_transaction
	GROUP BY bulan
	ORDER BY bulan
)


--4. Bagaimana growth order dan sales GenggamData Store ditahun 2023 berdaarkan kategori produk

SELECT 
	bulan,
	category,
	ROUND(((jumlah_order/LAG(jumlah_order) OVER(PARTITION BY category ORDER BY bulan))-1)*100, 2) as growth_order,
	ROUND(((total_sales/LAG(total_sales) OVER(PARTITION BY category ORDER BY bulan))-1)*100,2) as growth_sales
FROM
(
	SELECT
		EXTRACT (MONTH FROM order_date) AS bulan,
		category,
		CAST(COUNT(*) AS numeric) AS jumlah_order,
    	SUM(purchase_amount_usd) AS total_sales
	FROM customer_transaction
	GROUP BY bulan, category
	ORDER BY bulan
)


--Promotional Cost Efficiency Analysis
--1

SELECT 
	bulan,
	total_diskon,
	total_sales,
	ROUND(total_diskon/total_sales*100,2) as burn_rate
FROM
(
	SELECT
		EXTRACT (MONTH FROM order_date) AS bulan,
		SUM(purchase_amount_usd) AS total_sales,
		ROUND(SUM(purchase_amount_usd*discount/100),2) as total_diskon
	FROM customer_transaction
	GROUP BY bulan
	ORDER BY bulan
)

--2 Efektifitas dan efisiensi promosi yang dilakukan selama tahun 2023, 
--dengan menghitung burn rate dari promosi yang dilakukan overall berdasarkan product category dan bulan

SELECT 
	bulan,
	category,
	total_diskon,
	total_sales,
	ROUND(total_diskon/total_sales*100,2) as burn_rate
FROM
(
	SELECT
		EXTRACT (MONTH FROM order_date) AS bulan,
		category,
		SUM(purchase_amount_usd) AS total_sales,
		ROUND(SUM(purchase_amount_usd*discount/100),2) as total_diskon
	FROM customer_transaction
	GROUP BY bulan, category
	ORDER BY bulan
)	


--Customer Retention Analysis

-- CTE cohort table
-- Join Table
WITH 
periode_pertama_transaksi AS 
(
	SELECT
		customer_id,
		MIN(EXTRACT(MONTH FROM order_date)) as bulan_pertama_transaksi
	FROM customer_transaction
	GROUP BY customer_id
	ORDER BY customer_id
),

bulan_transaksi AS
(
	SELECT DISTINCT customer_id, 
		EXTRACT(MONTH FROM order_date) AS bulan
	FROM customer_transaction
	ORDER BY customer_id
),

tabel_gab AS
(
	SELECT ppt.customer_id, 
		   bt.bulan, 
		   ppt.bulan_pertama_transaksi,
		   bt.bulan - ppt.bulan_pertama_transaksi AS periode_ke
	FROM periode_pertama_transaksi ppt
	JOIN bulan_transaksi bt
	ON ppt.customer_id = bt.customer_id
)

-- main tabel
(
	SELECT bulan_pertama_transaksi, 
		   SUM(CASE WHEN periode_ke = 0 THEN 1 ELSE 0 END) AS m0,
		   SUM(CASE WHEN periode_ke = 1 THEN 1 ELSE 0 END) AS m1,
		   SUM(CASE WHEN periode_ke = 2 THEN 1 ELSE 0 END) AS m2,
		   SUM(CASE WHEN periode_ke = 3 THEN 1 ELSE 0 END) AS m3,
		   SUM(CASE WHEN periode_ke = 4 THEN 1 ELSE 0 END) AS m4,
		   SUM(CASE WHEN periode_ke = 5 THEN 1 ELSE 0 END) AS m5,
		   SUM(CASE WHEN periode_ke = 6 THEN 1 ELSE 0 END) AS m6,
		   SUM(CASE WHEN periode_ke = 7 THEN 1 ELSE 0 END) AS m7,
		   SUM(CASE WHEN periode_ke = 8 THEN 1 ELSE 0 END) AS m8,
		   SUM(CASE WHEN periode_ke = 9 THEN 1 ELSE 0 END) AS m9,
		   SUM(CASE WHEN periode_ke = 10 THEN 1 ELSE 0 END) AS m10,
		   SUM(CASE WHEN periode_ke = 11 THEN 1 ELSE 0 END) AS m11
	FROM tabel_gab
	GROUP BY bulan_pertama_transaksi
	ORDER BY bulan_pertama_transaksi
)

------------------------
--- tabel retention
WITH 
periode_pertama_transaksi AS 
(
	SELECT
		customer_id,
		MIN(EXTRACT(MONTH FROM order_date)) as bulan_pertama_transaksi
	FROM customer_transaction
	GROUP BY customer_id
	ORDER BY customer_id
),

bulan_transaksi AS
(
	SELECT DISTINCT customer_id, 
		EXTRACT(MONTH FROM order_date) AS bulan
	FROM customer_transaction
	ORDER BY customer_id
),

tabel_gab AS
(
	SELECT ppt.customer_id, 
		   bt.bulan, 
		   ppt.bulan_pertama_transaksi,
		   bt.bulan - ppt.bulan_pertama_transaksi AS periode_ke
	FROM periode_pertama_transaksi ppt
	JOIN bulan_transaksi bt
	ON ppt.customer_id = bt.customer_id
),

tabel_cohort AS
(
	SELECT bulan_pertama_transaksi, 
		   SUM(CASE WHEN periode_ke = 0 THEN 1 ELSE 0 END) AS m0,
		   SUM(CASE WHEN periode_ke = 1 THEN 1 ELSE 0 END) AS m1,
		   SUM(CASE WHEN periode_ke = 2 THEN 1 ELSE 0 END) AS m2,
		   SUM(CASE WHEN periode_ke = 3 THEN 1 ELSE 0 END) AS m3,
		   SUM(CASE WHEN periode_ke = 4 THEN 1 ELSE 0 END) AS m4,
		   SUM(CASE WHEN periode_ke = 5 THEN 1 ELSE 0 END) AS m5,
		   SUM(CASE WHEN periode_ke = 6 THEN 1 ELSE 0 END) AS m6,
		   SUM(CASE WHEN periode_ke = 7 THEN 1 ELSE 0 END) AS m7,
		   SUM(CASE WHEN periode_ke = 8 THEN 1 ELSE 0 END) AS m8,
		   SUM(CASE WHEN periode_ke = 9 THEN 1 ELSE 0 END) AS m9,
		   SUM(CASE WHEN periode_ke = 10 THEN 1 ELSE 0 END) AS m10,
		   SUM(CASE WHEN periode_ke = 11 THEN 1 ELSE 0 END) AS m11
	FROM tabel_gab
	GROUP BY bulan_pertama_transaksi
	ORDER BY bulan_pertama_transaksi
)

SELECT bulan_pertama_transaksi as cohort_month,
	   ROUND((m0/CAST(m0 AS numeric))*100, 0) AS m0,
       ROUND((m1/CAST(m0 AS numeric))*100, 0) AS m1,
	   ROUND((m2/CAST(m0 AS numeric))*100, 0) AS m2,
	   ROUND((m3/CAST(m0 AS numeric))*100, 0) AS m3,
	   ROUND((m4/CAST(m0 AS numeric))*100, 0) AS m4,
	   ROUND((m5/CAST(m0 AS numeric))*100, 0) AS m5,
	   ROUND((m6/CAST(m0 AS numeric))*100, 0) AS m6,
	   ROUND((m7/CAST(m0 AS numeric))*100, 0) AS m7,
	   ROUND((m8/CAST(m0 AS numeric))*100, 0) AS m8,
	   ROUND((m9/CAST(m0 AS numeric))*100, 0) AS m9,
	   ROUND((m10/CAST(m0 AS numeric))*100, 0) AS m10,
	   ROUND((m11/CAST(m0 AS numeric))*100, 0) AS m11
FROM tabel_cohort
ORDER BY bulan_pertama_transaksi

--- churn rate
WITH 
periode_pertama_transaksi AS 
(
	SELECT
		customer_id,
		MIN(EXTRACT(MONTH FROM order_date)) as bulan_pertama_transaksi
	FROM customer_transaction
	GROUP BY customer_id
	ORDER BY customer_id
),

bulan_transaksi AS
(
	SELECT DISTINCT customer_id, 
		EXTRACT(MONTH FROM order_date) AS bulan
	FROM customer_transaction
	ORDER BY customer_id
),

tabel_gab AS
(
	SELECT ppt.customer_id, 
		   bt.bulan, 
		   ppt.bulan_pertama_transaksi,
		   bt.bulan - ppt.bulan_pertama_transaksi AS periode_ke
	FROM periode_pertama_transaksi ppt
	JOIN bulan_transaksi bt
	ON ppt.customer_id = bt.customer_id
),

tabel_cohort AS
(
	SELECT bulan_pertama_transaksi, 
		   SUM(CASE WHEN periode_ke = 0 THEN 1 ELSE 0 END) AS m0,
		   SUM(CASE WHEN periode_ke = 1 THEN 1 ELSE 0 END) AS m1,
		   SUM(CASE WHEN periode_ke = 2 THEN 1 ELSE 0 END) AS m2,
		   SUM(CASE WHEN periode_ke = 3 THEN 1 ELSE 0 END) AS m3,
		   SUM(CASE WHEN periode_ke = 4 THEN 1 ELSE 0 END) AS m4,
		   SUM(CASE WHEN periode_ke = 5 THEN 1 ELSE 0 END) AS m5,
		   SUM(CASE WHEN periode_ke = 6 THEN 1 ELSE 0 END) AS m6,
		   SUM(CASE WHEN periode_ke = 7 THEN 1 ELSE 0 END) AS m7,
		   SUM(CASE WHEN periode_ke = 8 THEN 1 ELSE 0 END) AS m8,
		   SUM(CASE WHEN periode_ke = 9 THEN 1 ELSE 0 END) AS m9,
		   SUM(CASE WHEN periode_ke = 10 THEN 1 ELSE 0 END) AS m10,
		   SUM(CASE WHEN periode_ke = 11 THEN 1 ELSE 0 END) AS m11
	FROM tabel_gab
	GROUP BY bulan_pertama_transaksi
	ORDER BY bulan_pertama_transaksi
),

retention_table as
(
SELECT bulan_pertama_transaksi as cohort_month,
	   ROUND((m0/CAST(m0 AS numeric))*100, 0) AS m0,
       ROUND((m1/CAST(m0 AS numeric))*100, 0) AS m1,
	   ROUND((m2/CAST(m0 AS numeric))*100, 0) AS m2,
	   ROUND((m3/CAST(m0 AS numeric))*100, 0) AS m3,
	   ROUND((m4/CAST(m0 AS numeric))*100, 0) AS m4,
	   ROUND((m5/CAST(m0 AS numeric))*100, 0) AS m5,
	   ROUND((m6/CAST(m0 AS numeric))*100, 0) AS m6,
	   ROUND((m7/CAST(m0 AS numeric))*100, 0) AS m7,
	   ROUND((m8/CAST(m0 AS numeric))*100, 0) AS m8,
	   ROUND((m9/CAST(m0 AS numeric))*100, 0) AS m9,
	   ROUND((m10/CAST(m0 AS numeric))*100, 0) AS m10,
	   ROUND((m11/CAST(m0 AS numeric))*100, 0) AS m11
FROM tabel_cohort
ORDER BY bulan_pertama_transaksi
	
)

SELECT cohort_month,
	   (100 - m0) as churn_m0,
	   (100 - m1) as churn_m1,
	   (100 - m2) as churn_m2,
	   (100 - m3) as churn_m3,
	   (100 - m4) as churn_m4,
	   (100 - m5) as churn_m5,
	   (100 - m6) as churn_m6,
	   (100 - m7) as churn_m7,
	   (100 - m8) as churn_m8,
	   (100 - m9) as churn_m9,
	   (100 - m10) as churn_m10,
	   (100 - m11) as churn_m11
FROM retention_table
ORDER BY cohort_month


-- Customer Behavior Analysis


--1.	Trend Pembelian
--a.	Bagaimana Trend Pembelian dari bulan ke bulan ?

SELECT 
	CASE 
	WHEN bulan = '1' THEN 'Januari' 
	WHEN bulan = '2' THEN 'Feburari'
	WHEN bulan = '3' THEN 'Maret'
	WHEN bulan = '4' THEN 'April'
	WHEN bulan = '5' THEN 'Mei'
	WHEN bulan = '6' THEN 'Juni'
	WHEN bulan = '7' THEN 'Juli'
	WHEN bulan = '8' THEN 'Agustus'
	WHEN bulan = '9' THEN 'September'
	WHEN bulan = '10' THEN 'Oktober'
	WHEN bulan = '11' THEN 'November'
	ELSE 'Desember' END as bulan,
	total_revenue
FROM
(
	SELECT 
		EXTRACT(MONTH FROM order_date) as bulan,
		ROUND(SUM(CASE WHEN discount_applied = 'Yes' THEN (100-discount)/100*purchase_amount_usd
			ELSE purchase_amount_usd END),2) AS total_revenue
	FROM customer_transaction
	GROUP BY bulan
	ORDER BY bulan
)


--2.	Preferensi Produk
--a.	Produk apa yang paling sering dibeli oleh pelanggan?

SELECT 
	DENSE_RANK () OVER(ORDER BY COUNT(item_purchased) DESC) as denserank_num,
	item_purchased,
	COUNT(item_purchased) as jumlah_produk
FROM customer_transaction
GROUP BY item_purchased
ORDER BY denserank_num


--b.	Apakah ada produk yang lebih disukai oleh pelanggan tertentu? (Misal  marketing ingin membuat iklan yang akan disebar berdasarkan gender)
--mengecek
SELECT 
	COUNT(CASE WHEN gender = 'Female' THEN customer_id END) as female,
	item_purchased,
	COUNT(CASE WHEN gender = 'Male' THEN gender END) as male
	--COUNT(CASE WHEN gender = 'Female' THEN gender END) as female,
	--COUNT(item_purchased) as jumlah_produk
FROM customer_transaction
GROUP BY item_purchased
ORDER BY female DESC

--male
SELECT 
    DENSE_RANK() OVER(ORDER BY male DESC) AS denserank_num,
    item_purchased,
    male
FROM (
    SELECT 
        item_purchased,
        SUM(CASE WHEN gender = 'Male' THEN 1 ELSE 0 END) AS male,
        SUM(CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) AS female
    FROM customer_transaction
    GROUP BY item_purchased
) AS ringkasan_pembelian
ORDER BY denserank_num


--female

SELECT 
    DENSE_RANK() OVER(ORDER BY female DESC) AS denserank_num,
    item_purchased,
    female
FROM (
    SELECT 
        item_purchased,
        SUM(CASE WHEN gender = 'Male' THEN 1 ELSE 0 END) AS male,
        SUM(CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) AS female
    FROM customer_transaction
    GROUP BY item_purchased
) AS ringkasan_pembelian
ORDER BY denserank_num


--3.	Korelasi Rating dan Review
--a.	Apakah rating berpengaruh kepada jumlah pembelian? Gunakan Pearson Correlation & buat scatter plot nya

SELECT
    CORR(review_rating, jumlah_pembelian) AS pearson_correlation
FROM 
(
	SELECT 
		review_rating,
		COUNT(customer_id) as jumlah_pembelian
	FROM customer_transaction
	GROUP BY review_rating
)

--4.-	Pola Diskon
--a.	Berapa sering pelanggan menggunakan diskon?

--overall
SELECT 
	penggunaan_diskon,
	jumlah_pengguna,
	ROUND(CAST (penggunaan_diskon AS numeric)/CAST (jumlah_pengguna as numeric)*100,2) as persentase_penggunaan_diskon
FROM
(
	SELECT
	SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END) as penggunaan_diskon,
	COUNT(discount_applied) as jumlah_pengguna
	FROM customer_transaction
) as tabel_persentase

-- per customer
SELECT 
	customer_id,
	transaksi_diskon,
	jumlah_transaksi,
	ROUND(CAST (transaksi_diskon AS numeric)/CAST (jumlah_transaksi as numeric)*100,2) as persentase_penggunaan_diskon
FROM
(
	SELECT
	customer_id,
	SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END) as transaksi_diskon,
	COUNT(customer_id) as jumlah_transaksi
	FROM customer_transaction
	GROUP BY customer_id
	ORDER BY customer_id
) as tabel_persentase

ORDER BY persentase_penggunaan_diskon









