-- 1. Top 5 Produk Terlaris Tiap Tahun
SELECT
    tahun,
    product_name,
    total_terjual
FROM (
    SELECT
        t.year AS tahun,
        p.product_name,
        SUM(f.quantity) AS total_terjual,
        ROW_NUMBER() OVER (
            PARTITION BY t.year
            ORDER BY SUM(f.quantity) DESC
        ) AS ranking
    FROM factsales f
    JOIN dimproduct p
        ON f.id_product = p.id_product
    JOIN dimtime t
        ON f.id_time = t.id_time
    GROUP BY t.year, p.product_name
) x
WHERE ranking <= 5
ORDER BY tahun ASC, ranking ASC;

-- 2. Top 5 Customer Paling Loyal Tiap Tahun
SELECT
    tahun,
    customer_name,
    jumlah_transaksi
FROM (
    SELECT
        t.year AS tahun,
        c.customer_name,
        COUNT(*) AS jumlah_transaksi,
        ROW_NUMBER() OVER(
            PARTITION BY t.year
            ORDER BY COUNT(*) DESC
        ) AS ranking
    FROM factsales f
    JOIN dimcustomer c
        ON f.id_customer = c.id_customer
    JOIN dimtime t
        ON f.id_time = t.id_time
    GROUP BY t.year, c.customer_name
) x
WHERE ranking <= 5
ORDER BY tahun, ranking;

-- 3. Rata-rata Nilai Penjualan per Transaksi Setiap Tahun
SELECT
    t.year,
    ROUND(AVG(f.sales),2) AS rata_rata_transaksi
FROM factsales f
JOIN dimtime t
    ON f.id_time = t.id_time
GROUP BY t.year
ORDER BY t.year;