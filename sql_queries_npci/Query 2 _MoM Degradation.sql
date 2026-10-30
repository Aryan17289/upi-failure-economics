WITH MoM_Analysis AS (
    SELECT 
        bank_name,
        month_year,
        technical_decline_pct,
        LAG(technical_decline_pct, 1) OVER (
            PARTITION BY bank_name ORDER BY month_year
        ) AS prev_month_td_pct,
        total_volume_mn
    FROM upi_bank_monthly_performance
    WHERE role_type = 'Remitter'
)
SELECT 
    bank_name,
    month_year,
    technical_decline_pct AS current_td_pct,
    prev_month_td_pct,
    ROUND(technical_decline_pct - prev_month_td_pct, 2) AS td_spike_diff,
    total_volume_mn
FROM MoM_Analysis
WHERE prev_month_td_pct IS NOT NULL
  AND (technical_decline_pct - prev_month_td_pct) >= 0.50 
ORDER BY td_spike_diff DESC;