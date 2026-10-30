SELECT 
    r.bank_name,
    r.month_year,
    r.technical_decline_pct AS remitter_td_pct,
    b.technical_decline_pct AS beneficiary_td_pct,
    ROUND(r.technical_decline_pct - b.technical_decline_pct, 2) AS remitter_debit_friction_delta,
    ROUND((r.total_volume_mn * (r.technical_decline_pct / 100.0)), 2) AS remitter_lost_vol_mn,
    ROUND((b.total_volume_mn * (b.technical_decline_pct / 100.0)), 2) AS beneficiary_lost_vol_mn
FROM upi_bank_monthly_performance r
JOIN upi_bank_monthly_performance b 
  ON r.bank_name = b.bank_name 
 AND r.month_year = b.month_year
WHERE r.role_type = 'Remitter' 
  AND b.role_type = 'Beneficiary'
  AND ABS(r.technical_decline_pct - b.technical_decline_pct) > 0.40
ORDER BY remitter_debit_friction_delta DESC;