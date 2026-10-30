CREATE DATABASE npci_upi_project;
USE npci_upi_project;  

CREATE TABLE upi_bank_monthly_performance (
    month_year VARCHAR(7),
    bank_name VARCHAR(150),
    role_type VARCHAR(20),
    total_volume_mn DECIMAL(12, 2),
    approved_volume_mn DECIMAL(12, 2),
    approved_pct DECIMAL(5, 2),
    technical_decline_pct DECIMAL(5, 2),
    business_decline_pct DECIMAL(5, 2),
    total_decline_pct DECIMAL(5, 2)
);