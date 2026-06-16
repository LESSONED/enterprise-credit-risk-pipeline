CREATE TABLE IF NOT EXISTS public.application_train
(
    sk_id_curr bigint,
    target bigint,
    name_contract_type character varying COLLATE pg_catalog."default",
    code_gender character varying COLLATE pg_catalog."default",
    flag_own_car character varying COLLATE pg_catalog."default",
    flag_own_realty character varying COLLATE pg_catalog."default",
    cnt_children bigint,
    amt_income_total numeric,
    amt_credit numeric,
    amt_annuity numeric,
    amt_goods_price numeric,
    name_type_suite character varying COLLATE pg_catalog."default",
    name_income_type character varying COLLATE pg_catalog."default",
    name_education_type character varying COLLATE pg_catalog."default",
    name_family_status character varying COLLATE pg_catalog."default",
    name_housing_type character varying COLLATE pg_catalog."default",
    region_population_relative numeric,
    days_birth bigint,
    days_employed bigint,
    days_registration numeric,
    days_id_publish bigint,
    own_car_age numeric,
    flag_mobil bigint,
    flag_emp_phone bigint,
    flag_work_phone bigint,
    flag_cont_mobile bigint,
    flag_phone bigint,
    flag_email bigint,
    occupation_type character varying COLLATE pg_catalog."default",
    cnt_fam_members numeric,
    region_rating_client bigint,
    region_rating_client_w_city bigint,
    weekday_appr_process_start character varying COLLATE pg_catalog."default",
    hour_appr_process_start bigint,
    reg_region_not_live_region bigint,
    reg_region_not_work_region bigint,
    live_region_not_work_region bigint,
    reg_city_not_live_city bigint,
    reg_city_not_work_city bigint,
    live_city_not_work_city bigint,
    organization_type character varying COLLATE pg_catalog."default",
    ext_source_1 numeric,
    ext_source_2 numeric,
    ext_source_3 numeric,
    apartments_avg numeric,
    basementarea_avg numeric,
    years_beginexpluatation_avg numeric,
    years_build_avg numeric,
    commonarea_avg numeric,
    elevators_avg numeric,
    entrances_avg numeric,
    floorsmax_avg numeric,
    floorsmin_avg numeric,
    landarea_avg numeric,
    livingapartments_avg numeric,
    livingarea_avg numeric,
    nonlivingapartments_avg numeric,
    nonlivingarea_avg numeric,
    apartments_mode numeric,
    basementarea_mode numeric,
    years_beginexpluatation_mode numeric,
    years_build_mode numeric,
    commonarea_mode numeric,
    elevators_mode numeric,
    entrances_mode numeric,
    floorsmax_mode numeric,
    floorsmin_mode numeric,
    landarea_mode numeric,
    livingapartments_mode numeric,
    livingarea_mode numeric,
    nonlivingapartments_mode numeric,
    nonlivingarea_mode numeric,
    apartments_medi numeric,
    basementarea_medi numeric,
    years_beginexpluatation_medi numeric,
    years_build_medi numeric,
    commonarea_medi numeric,
    elevators_medi numeric,
    entrances_medi numeric,
    floorsmax_medi numeric,
    floorsmin_medi numeric,
    landarea_medi numeric,
    livingapartments_medi numeric,
    livingarea_medi numeric,
    nonlivingapartments_medi numeric,
    nonlivingarea_medi numeric,
    fondkapremont_mode character varying COLLATE pg_catalog."default",
    housetype_mode character varying COLLATE pg_catalog."default",
    totalarea_mode numeric,
    wallsmaterial_mode character varying COLLATE pg_catalog."default",
    emergencystate_mode character varying COLLATE pg_catalog."default",
    obs_30_cnt_social_circle numeric,
    def_30_cnt_social_circle numeric,
    obs_60_cnt_social_circle numeric,
    def_60_cnt_social_circle numeric,
    days_last_phone_change numeric,
    flag_document_2 bigint,
    flag_document_3 bigint,
    flag_document_4 bigint,
    flag_document_5 bigint,
    flag_document_6 bigint,
    flag_document_7 bigint,
    flag_document_8 bigint,
    flag_document_9 bigint,
    flag_document_10 bigint,
    flag_document_11 bigint,
    flag_document_12 bigint,
    flag_document_13 bigint,
    flag_document_14 bigint,
    flag_document_15 bigint,
    flag_document_16 bigint,
    flag_document_17 bigint,
    flag_document_18 bigint,
    flag_document_19 bigint,
    flag_document_20 bigint,
    flag_document_21 bigint,
    amt_req_credit_bureau_hour numeric,
    amt_req_credit_bureau_day numeric,
    amt_req_credit_bureau_week numeric,
    amt_req_credit_bureau_mon numeric,
    amt_req_credit_bureau_qrt numeric,
    amt_req_credit_bureau_year numeric
);


-- Data Ingestion: Application Train
COPY application_train
FROM 'C:\Data\application_train.csv'
DELIMITER ','
CSV HEADER;











CREATE TABLE IF NOT EXISTS public.bureau
(
    sk_id_curr bigint,
    sk_id_bureau bigint,
    credit_active character varying COLLATE pg_catalog."default",
    credit_currency character varying COLLATE pg_catalog."default",
    days_credit bigint,
    credit_day_overdue bigint,
    days_credit_enddate numeric,
    days_enddate_fact numeric,
    amt_credit_max_overdue numeric,
    cnt_credit_prolong bigint,
    amt_credit_sum numeric,
    amt_credit_sum_debt numeric,
    amt_credit_sum_limit numeric,
    amt_credit_sum_overdue numeric,
    credit_type character varying COLLATE pg_catalog."default",
    days_credit_update bigint,
    amt_annuity numeric
);



-- Data Ingestion: Bureau
COPY bureau
FROM 'C:\Data\bureau.csv'
DELIMITER ','
CSV HEADER;


CREATE OR REPLACE VIEW public.vw_bureau_summary
 AS
 SELECT sk_id_curr,
    count(sk_id_bureau) AS total_bureau_loans,
    sum(
        CASE
            WHEN credit_active::text = 'Active'::text THEN 1
            ELSE 0
        END) AS active_bureau_loans,
    sum(amt_credit_sum) AS total_bureau_credit_amount,
    sum(amt_credit_sum_debt) AS total_bureau_current_debt,
    round(avg(days_credit), 0) AS avg_days_since_previous_credit
   FROM bureau
  GROUP BY sk_id_curr;










CREATE TABLE IF NOT EXISTS public.bureau_balance
(
    sk_id_bureau bigint,
    months_balance bigint,
    status character varying COLLATE pg_catalog."default"
);


-- Data Ingestion: Bureau Balance
COPY bureau_balance
FROM 'C:\Data\bureau_balance.csv'
DELIMITER ','
CSV HEADER;










CREATE TABLE IF NOT EXISTS public.credit_card_balance
(
    sk_id_prev bigint,
    sk_id_curr bigint,
    months_balance bigint,
    amt_balance numeric,
    amt_credit_limit_actual bigint,
    amt_drawings_atm_current numeric,
    amt_drawings_current numeric,
    amt_drawings_other_current numeric,
    amt_drawings_pos_current numeric,
    amt_inst_min_regularity numeric,
    amt_payment_current numeric,
    amt_payment_total_current numeric,
    amt_receivable_principal numeric,
    amt_recivable numeric,
    amt_total_receivable numeric,
    cnt_drawings_atm_current numeric,
    cnt_drawings_current bigint,
    cnt_drawings_other_current numeric,
    cnt_drawings_pos_current numeric,
    cnt_instalment_mature_cum numeric,
    name_contract_status character varying COLLATE pg_catalog."default",
    sk_dpd bigint,
    sk_dpd_def bigint
);



-- Data Ingestion: Credit Card Balance
COPY credit_card_balance
FROM 'C:\Data\credit_card_balance.csv'
DELIMITER ','
CSV HEADER;




CREATE OR REPLACE VIEW public.vw_credit_card_summary
 AS
 SELECT sk_id_curr,
    count(months_balance) AS total_cc_months_active,
    round(avg(amt_balance), 2) AS avg_cc_monthly_balance,
    round(avg(amt_credit_limit_actual), 2) AS avg_cc_credit_limit,
    sum(cnt_drawings_atm_current) AS total_amt_cash_draws,
    sum(
        CASE
            WHEN sk_dpd > 0 THEN 1
            ELSE 0
        END) AS month_with_late_cc_payment
   FROM credit_card_balance
  GROUP BY sk_id_curr;











CREATE TABLE IF NOT EXISTS public.installments_payments
(
    sk_id_prev bigint,
    sk_id_curr bigint,
    num_instalment_version numeric,
    num_instalment_number bigint,
    days_instalment numeric,
    days_entry_payment numeric,
    amt_instalment numeric,
    amt_payment numeric
);


-- Data Ingestion: Installments Payments
COPY installments_payments
FROM 'C:\Data\installments_payments.csv'
DELIMITER ','
CSV HEADER;


CREATE OR REPLACE VIEW public.vw_installments_summary
 AS
 SELECT sk_id_curr,
    count(num_instalment_number) AS total_installment_paid,
    sum(
        CASE
            WHEN days_entry_payment > days_instalment THEN 1
            ELSE 0
        END) AS total_late_payments,
    sum(
        CASE
            WHEN amt_payment < amt_instalment THEN 1
            ELSE 0
        END) AS total_underpayment,
    max(
        CASE
            WHEN days_entry_payment > days_instalment THEN days_entry_payment - days_instalment
            ELSE 0::numeric
        END) AS max_days_past_due
   FROM installments_payments
  GROUP BY sk_id_curr;











CREATE TABLE IF NOT EXISTS public.pos_cash_balance
(
    sk_id_prev bigint,
    sk_id_curr bigint,
    months_balance bigint,
    cnt_instalment numeric,
    cnt_instalment_future numeric,
    name_contract_status character varying COLLATE pg_catalog."default",
    sk_dpd bigint,
    sk_dpd_def bigint
);


-- Data Ingestion: Pos Cash Balance
COPY pos_cash_balance
FROM 'C:\Data\pos_cash_balance.csv'
DELIMITER ','
CSV HEADER;


CREATE OR REPLACE VIEW public.vw_pos_cash_summary
 AS
 SELECT sk_id_curr,
    count(months_balance) AS total_pos_months_active,
    sum(
        CASE
            WHEN name_contract_status::text = 'Completed'::text THEN 1
            ELSE 0
        END) AS pos_xompleted_contracts,
    sum(
        CASE
            WHEN name_contract_status::text = 'ACtive'::text THEN 1
            ELSE 0
        END) AS pos_active_contracts,
    sum(
        CASE
            WHEN sk_dpd > 0 THEN 1
            ELSE 0
        END) AS pos_months_with_late_payments,
    max(sk_dpd) AS pos_max_days_past_due
   FROM pos_cash_balance
  GROUP BY sk_id_curr;










CREATE TABLE IF NOT EXISTS public.previous_application
(
    sk_id_prev bigint,
    sk_id_curr bigint,
    name_contract_type character varying COLLATE pg_catalog."default",
    amt_annuity numeric,
    amt_application numeric,
    amt_credit numeric,
    amt_down_payment numeric,
    amt_goods_price numeric,
    weekday_appr_process_start character varying COLLATE pg_catalog."default",
    hour_appr_process_start bigint,
    flag_last_appl_per_contract character varying COLLATE pg_catalog."default",
    nflag_last_appl_in_day bigint,
    rate_down_payment numeric,
    rate_interest_primary numeric,
    rate_interest_privileged numeric,
    name_cash_loan_purpose character varying COLLATE pg_catalog."default",
    name_contract_status character varying COLLATE pg_catalog."default",
    days_decision bigint,
    name_payment_type character varying COLLATE pg_catalog."default",
    code_reject_reason character varying COLLATE pg_catalog."default",
    name_type_suite character varying COLLATE pg_catalog."default",
    name_client_type character varying COLLATE pg_catalog."default",
    name_goods_category character varying COLLATE pg_catalog."default",
    name_portfolio character varying COLLATE pg_catalog."default",
    name_product_type character varying COLLATE pg_catalog."default",
    channel_type character varying COLLATE pg_catalog."default",
    sellerplace_area bigint,
    name_seller_industry character varying COLLATE pg_catalog."default",
    cnt_payment numeric,
    name_yield_group character varying COLLATE pg_catalog."default",
    product_combination character varying COLLATE pg_catalog."default",
    days_first_drawing numeric,
    days_first_due numeric,
    days_last_due_1st_version numeric,
    days_last_due numeric,
    days_termination numeric,
    nflag_insured_on_approval numeric
);



-- Data Ingestion: Previous Application
COPY previous_application
FROM 'C:\Data\previous_application.csv'
DELIMITER ','
CSV HEADER;



CREATE OR REPLACE VIEW public.vw_previous_app_summary
 AS
 SELECT sk_id_curr,
    count(sk_id_prev) AS total_prev_app,
    sum(
        CASE
            WHEN name_contract_status::text = 'Approved'::text THEN 1
            ELSE 0
        END) AS approved_prev_apps,
    sum(
        CASE
            WHEN name_contract_status::text = 'Refused'::text THEN 1
            ELSE 0
        END) AS refused_prev_apps,
    sum(
        CASE
            WHEN name_contract_status::text = 'Cancele'::text THEN 1
            ELSE 0
        END) AS cancele_prev_apps,
    round(avg(amt_application), 2) AS avg_prev_asking_amount,
    round(avg(amt_credit), 2) AS avg_prev_granted_amount
   FROM previous_application
  GROUP BY sk_id_curr;