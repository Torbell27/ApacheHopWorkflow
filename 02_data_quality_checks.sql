-- 1. Общая статистика
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_id) AS unique_products
FROM public.products_clean;

-- 2. Обязательные поля
SELECT
    COUNT(*) FILTER (WHERE product_id IS NULL OR TRIM(product_id) = '') AS missing_product_id,
    COUNT(*) FILTER (WHERE title IS NULL OR TRIM(title) = '') AS missing_title,
    COUNT(*) FILTER (WHERE price IS NULL) AS missing_price,
    COUNT(*) FILTER (WHERE currency IS NULL OR TRIM(currency) = '') AS missing_currency
FROM public.products_clean;

-- 3. Проверка цен
SELECT
    COUNT(*) FILTER (WHERE price < 0) AS negative_prices,
    COUNT(*) FILTER (WHERE original_price < 0) AS negative_original_prices,
    COUNT(*) FILTER (WHERE discount_pct < 0 OR discount_pct > 100) AS invalid_discounts
FROM public.products_clean;

-- 4. Проверка рейтингов и отзывов
SELECT
    COUNT(*) FILTER (WHERE rating < 1 OR rating > 5) AS invalid_ratings,
    COUNT(*) FILTER (WHERE review_count < 0) AS negative_review_counts
FROM public.products_clean;

-- 5. Проверка остатков
SELECT
    COUNT(*) FILTER (WHERE stock_indicator < 0) AS negative_stock_indicators,
    COUNT(*) FILTER (WHERE in_stock IS NULL) AS missing_stock_status
FROM public.products_clean;

-- 6. Проверка дат
SELECT
    COUNT(*) FILTER (WHERE created_date IS NULL) AS missing_created_date,
    COUNT(*) FILTER (WHERE collected_at IS NULL) AS missing_collected_at
FROM public.products_clean;