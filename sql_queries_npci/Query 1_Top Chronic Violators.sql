SELECT 
    bank_name,
    role_type,
    COUNT(month_year) AS total_months_tracked,
    SUM(CASE WHEN technical_decline_pct > 1.0 THEN 1 ELSE 0 END) AS breach_months_count,
    ROUND((SUM(CASE WHEN technical_decline_pct > 1.0 THEN 1 ELSE 0 END) * 1.0 / COUNT(month_year)) * 100, 1) AS breach_consistency_pct,
    ROUND(AVG(technical_decline_pct), 2) AS avg_td_pct,
    MAX(technical_decline_pct) AS peak_td_pct,
    ROUND(SUM(total_volume_mn * (technical_decline_pct / 100.0)), 2) AS total_lost_transactions_mn
FROM upi_bank_monthly_performance
WHERE role_type = 'Remitter'
GROUP BY bank_name, role_type
HAVING SUM(CASE WHEN technical_decline_pct > 1.0 THEN 1 ELSE 0 END) >= 3
ORDER BY total_lost_transactions_mn DESC;