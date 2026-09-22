use Bank_Loan_Analysis;
CREATE OR REPLACE VIEW loan_dashboard AS
SELECT
    *,
    
    -- Revenue
    COALESCE(`total Rrec int`, 0)
    + COALESCE(`total fees`, 0)
    + COALESCE(`total pymnt`, 0) AS total_revenue,

    -- Default Rate
    CASE
        WHEN `is default loan` = 1 THEN 1
        ELSE 0
    END AS default_flag,

    -- Delinquent Rate
    CASE
        WHEN `is delinquent loan` = 1 THEN 1
        ELSE 0
    END AS delinquent_flag,

    -- Year
    YEAR(disbursement_date_New) AS disbursement_year,

    -- Month
    MONTH(disbursement_date_New) AS disbursement_month,

    -- Month Name
    MONTHNAME(disbursement_date_New) AS disbursement_month_name

FROM Loan_Data_Clean_1;

Select * from Loan_Dashboard
limit 10;

Select sum(`Funded Amount`) As Total_Loan_Amount_Funded From loan_data_clean_1;

Select count(distinct `Account Id`) As Total_Loans From loan_data_clean_1;

SELECT 
    sum(`Total Pymnt`) AS Total_Collection
FROM Loan_Data_Clean_1;

Select 
Sum(`Total Rrec Int`) As Total_interest From loan_data_clean_1;

Select 
SUM(`Total Rrec Int`)
+SUM(`Total fees`)
+SUM(`Total Rec late Fee`)+
SUM(`Collection recovery fee`) As Total_Revenue
From loan_data_clean_1;

 select
 Count(`Account ID`) As Default_Loans
  From Loan_Data_Clean_1
 Where `Is DefauLt Loan`="Y";
 
 select
 Count(`Account ID`) As Deliquent_Loans
  From Loan_Data_Clean_1
 Where `Is Delinquent Loan`="Y";
 
 Select sum(`Deliquent Flag`)/Count(*)
 As Delinquent_Loan_rate From loan_data_clean_1;
 
select
 Count(`Account ID`) As No_Verified_Loans
  From Loan_Data_Clean_1
 Where `Verification Flag`="Not Verified";

 -- Branchwise Performance--
 select 
`Branch Name`,
sum(`Total Rrec Int`)As Total_Interest,
sum(`Total Fees`)As Total_Fees,
sum(Total_Revenue)As Total_Revenue
From Loan_Dashboard
Group By `Branch Name`
Order By Total_revenue Desc;

-- State Wise Loan Analysis--
select 
`State Name`,
count(distinct `Account ID`) as Total_Loans,
sum(`Funded Amount`) As Total_Loan_Amount
From Loan_Dashboard
group by `State Name`
order by Total_Loans Desc;

-- Religion Wise Loan Analysis--
Select `Religion`,
count(distinct `Account Id`) As Total_Loans,
sum(`Loan Amount`) as Total_Loan_Amount
From Loan_Dashboard
Group By `Religion`
order by Total_Loans Desc;

-- Product group Wise Analysis--
Select `Product Code`,
count(distinct `Account Id`) As Total_Loans,
sum(`Loan Amount`) as Total_Loan_Amount
From Loan_Dashboard
Group By `Product Code`
order by Total_Loans Desc;

-- Grade Wise Loan--
Select `Grade`,
count(distinct `Account Id`) As Total_Loans,
sum(`Loan Amount`) as Total_Loan_Amount
From Loan_Dashboard
Group By `Grade`
order by `Grade` Asc;

-- Disbursement Trend--
select Disbursement_Year,
Disbursement_Month,
Disbursement_Month_Name,
count(distinct `Account Id`) As totall_loans,
sum(`Loan Amount`) As total_loan_Amount
From Loan_Dashboard
group by 
Disbursement_year,
Disbursement_Month,
Disbursement_Month_name
Order By
Disbursement_Year,
Disbursement_Month;

-- Loan Status WIse Analysis--
Select `Loan Status`,
count(distinct `Account Id`) As Total_Loans,
sum(`Loan Amount`) as Total_Loan_Amount
From Loan_Dashboard
Group By `Loan Status`
order by Total_Loans Desc;

-- Age group Wise Loan--
Select `Age`,
count(distinct `Account Id`) As Total_Loans,
sum(`Loan Amount`) as Total_Loan_Amount
From Loan_Dashboard
Group By `Age`
order by Total_Loans Desc;

-- Verification Status--
Select `Verification Status`,
count(distinct `Account Id`) As Total_Loans
From Loan_Dashboard
Group By `Verification Status`
order by `Total_Loans` Desc;

-- Default Vs Delinquent--
Select 
sum(default_Flag) As Default_Loans,
sum(Delinquent_Flag) As Delinquent_Loans
From Loan_Dashboard;

-- Loan Maturity Wise Loans--
Select `Loan Maturity`,
count(distinct `Account Id`) As Total_Loans
From Loan_Dashboard
Group By `Loan Maturity`
order by `Total_Loans` Desc;








 
 
 
 




