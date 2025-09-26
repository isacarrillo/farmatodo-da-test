-- Crear tabla gold_dim_date para todo el año 2024
-- No depende de ninguna otra tabla
CREATE OR REFRESH MATERIALIZED VIEW operations.gold_dim_date AS
WITH date_sequence AS (
    SELECT 
        DATE_ADD('2024-01-01', pos) as full_date
    FROM (
        SELECT POSEXPLODE(SPLIT(SPACE(366), ' '))
    ) 
)
SELECT
    -- Llave primaria
    CAST(DATE_FORMAT(full_date, 'yyyyMMdd') as INT) as date_key,
    full_date,
    
    -- Año
    YEAR(full_date) as year,
    QUARTER(full_date) as quarter,
    
    -- Mes
    MONTH(full_date) as month,
    DATE_FORMAT(full_date, 'MMMM') as month_name,
    
    -- Semana
    WEEKOFYEAR(full_date) as week_of_year,
    
    -- Día
    DAY(full_date) as day_of_month,
    DAYOFYEAR(full_date) as day_of_year,
    DAYOFWEEK(full_date) as day_of_week,
    DATE_FORMAT(full_date, 'EEEE') as day_name,
    
    -- Fin de semana
    CASE 
        WHEN DAYOFWEEK(full_date) IN (1, 7) THEN true 
        ELSE false 
    END as is_weekend,
    
    -- Días festivos principales
    CASE 
        WHEN (MONTH(full_date) = 1 AND DAY(full_date) = 1) OR
             (MONTH(full_date) = 5 AND DAY(full_date) = 1) OR
             (MONTH(full_date) = 7 AND DAY(full_date) IN (5, 9, 20)) OR
             (MONTH(full_date) = 12 AND DAY(full_date) IN (24, 25, 31))
        THEN true
        ELSE false
    END as is_holiday,
    
    -- Estación
    CASE 
        WHEN MONTH(full_date) IN (12, 1, 2) THEN 'Verano'
        WHEN MONTH(full_date) IN (3, 4, 5) THEN 'Otoño'
        WHEN MONTH(full_date) IN (6, 7, 8) THEN 'Invierno'
        ELSE 'Primavera'
    END as season,
    
    -- Inicio o fin de mes
    CASE 
        WHEN DAY(full_date) <= 5 OR DAY(full_date) >= 27 THEN true
        ELSE false
    END as is_month_boundary
    
FROM date_sequence
WHERE full_date <= '2024-12-31'
ORDER BY full_date;