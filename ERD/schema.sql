-- Redshift Database Schema DDL
-- Generated from Data Dictionary

-- Customer & Household Tables
CREATE TABLE SAS_CUSTOMER_MSTR_VW (
    customer_id BIGINT PRIMARY KEY,
    household_id BIGINT,
    mstr_customer_id BIGINT,
    mstr_household_id BIGINT,
    birth_mmdd INTEGER,
    bu_purchased VARCHAR(240),
    channels_purchased VARCHAR(40),
    centile_m1 SMALLINT,
    centile_m2 SMALLINT,
    centile_m3 SMALLINT,
    dnm_flag CHAR(4),
    lifetime_dollars NUMERIC(18,2),
    lifetime_frequency INTEGER,
    lifetime_net NUMERIC(18,2),
    original_date VARCHAR(16),
    recency_activity_date DATE,
    recency_purchase_date DATE,
    sex SMALLINT,
    state VARCHAR(16),
    suppress_reasons VARCHAR(80),
    zip CHAR(20),
    m0_12_net NUMERIC(18,2),
    m13_24_net NUMERIC(18,2),
    m25_36_net NUMERIC(18,2)
);

CREATE TABLE SAS_CUSTOMER_MSTR_BU_VW (
    customer_id BIGINT,
    household_id BIGINT,
    mstr_customer_id BIGINT,
    mstr_household_id BIGINT,
    business_unit SMALLINT,
    channels_purchased VARCHAR(80),
    centile_m1 SMALLINT,
    centile_m2 SMALLINT,
    centile_m3 SMALLINT,
    last_purchase_dollar NUMERIC(18,2),
    lifetime_dollars NUMERIC(18,2),
    lifetime_frequency INTEGER,
    lifetime_net NUMERIC(18,2),
    original_purchase_date DATE,
    primary_sa INTEGER,
    store_of_preference INTEGER,
    recency_activity_date DATE,
    recency_purchase_date DATE,
    m0_12_net NUMERIC(18,2),
    m13_24_net NUMERIC(18,2),
    m25_36_net NUMERIC(18,2),
    PRIMARY KEY (customer_id, business_unit)
);

CREATE TABLE SAS_HOUSEHOLD_VW (
    household_id BIGINT PRIMARY KEY,
    customer_id BIGINT,
    birth_mmdd SMALLINT,
    bu_purchased VARCHAR(60),
    channels_purchased VARCHAR(20),
    country_code SMALLINT,
    centile_m1 SMALLINT,
    centile_m2 SMALLINT,
    centile_m3 SMALLINT,
    lifetime_dollars NUMERIC(18,2),
    lifetime_frequency INTEGER,
    lifetime_net NUMERIC(18,2),
    original_date DATE,
    recency_activity_date DATE,
    recency_purchase_date DATE,
    sex SMALLINT,
    state VARCHAR(4),
    zip VARCHAR(10),
    m0_12_net NUMERIC(18,2),
    m13_24_net NUMERIC(18,2),
    m25_36_net NUMERIC(18,2)
);

CREATE TABLE SAS_HOUSEHOLD_BU_VW (
    household_id BIGINT,
    customer_id BIGINT,
    business_unit SMALLINT,
    channels_purchased VARCHAR(20),
    centile_m1 SMALLINT,
    centile_m2 SMALLINT,
    centile_m3 SMALLINT,
    last_purchase_dollar NUMERIC(18,2),
    lifetime_dollars NUMERIC(18,2),
    lifetime_frequency INTEGER,
    lifetime_net NUMERIC(18,2),
    primary_sa BIGINT,
    store_of_preference INTEGER,
    recency_activity_date DATE,
    recency_purchase_date DATE,
    m0_12_net NUMERIC(18,2),
    m13_24_net NUMERIC(18,2),
    m25_36_net NUMERIC(18,2),
    PRIMARY KEY (household_id, business_unit)
);

CREATE TABLE SAS_CUST_MSTR_SUPPRESS (
    customer_id BIGINT,
    business_unit SMALLINT,
    media_type VARCHAR(10),
    suppress_reason VARCHAR(10),
    rec_updated_date DATE,
    PRIMARY KEY (customer_id, business_unit)
);

-- Contact Information Tables
CREATE TABLE SAS_EMAIL_ADDRESSES_VW (
    email_id INTEGER PRIMARY KEY,
    household_id BIGINT,
    customer_id BIGINT,
    mstr_customer_id BIGINT,
    mstr_household_id BIGINT,
    business_unit SMALLINT,
    first_name VARCHAR(100),
    middle_name VARCHAR(100),
    last_name VARCHAR(100),
    email_address VARCHAR(200),
    customer_birth_month SMALLINT,
    email_domain VARCHAR(200),
    email_undeliverable_flag CHAR(1),
    opt_in_date DATE,
    opt_out_date DATE,
    opt_in_valid CHAR(1),
    original_date DATE,
    opt_in_flag VARCHAR(2)
);

CREATE TABLE SAS_C_PHONE_VW (
    rec_source VARCHAR(4),
    business_unit SMALLINT,
    household_id BIGINT,
    customer_id BIGINT,
    mstr_customer_id BIGINT,
    home_phone_ind CHAR(1),
    h_phone VARCHAR(100),
    o_phone VARCHAR(100),
    cell_phone VARCHAR(100),
    dnp_flag CHAR(1),
    dnp_date DATE,
    rec_added_date DATE,
    rec_updated_date DATE
);

CREATE TABLE SAS_CONTACT_SUMM_MSTR_VW (
    mstr_customer_id BIGINT,
    mstr_household_id BIGINT,
    business_unit SMALLINT,
    promotion_date DATE,
    times_mailed INTEGER,
    times_emailed INTEGER,
    times_phoned INTEGER,
    total_contacts INTEGER,
    pieces_mailed INTEGER,
    pieces_emailed INTEGER,
    pieces_phoned INTEGER,
    total_pieces INTEGER,
    PRIMARY KEY (mstr_customer_id, business_unit, promotion_date)
);

-- Transaction Tables
CREATE TABLE SAS_TRANSACTION_VW (
    transaction_no BIGINT PRIMARY KEY,
    order_id VARCHAR(400),
    line_number INTEGER,
    household_id BIGINT,
    customer_id BIGINT,
    mstr_customer_id BIGINT,
    mstr_household_id BIGINT,
    amount NUMERIC(18,2),
    business_unit SMALLINT,
    cgroup_code INTEGER,
    channel_code SMALLINT,
    class INTEGER,
    color INTEGER,
    payment_method SMALLINT,
    product_level_1 INTEGER,
    product_level_2 SMALLINT,
    product_level_3 INTEGER,
    product_level_4 INTEGER,
    prod_size INTEGER,
    quantity INTEGER,
    record_source VARCHAR(16),
    sales_credit SMALLINT,
    sku VARCHAR(800),
    store_code INTEGER,
    style INTEGER,
    transaction_date DATE,
    vendor INTEGER,
    fiscal_year SMALLINT,
    fiscal_month INTEGER
);

CREATE TABLE SAS_TRANS_TENDER (
    transaction_no BIGINT PRIMARY KEY,
    order_id VARCHAR(100),
    store_id SMALLINT,
    business_date DATE,
    register_id SMALLINT,
    transaction_id INTEGER,
    tender_id VARCHAR(40),
    local_amount NUMERIC(18,2),
    sequence SMALLINT,
    customer_id BIGINT,
    household_id BIGINT,
    mstr_customer_id BIGINT,
    mstr_household_id BIGINT,
    business_unit SMALLINT,
    amount NUMERIC(18,2)
);

CREATE TABLE SAS_OFFER_VW (
    record_source VARCHAR(4),
    business_unit SMALLINT,
    household_id BIGINT,
    customer_id BIGINT,
    mstr_customer_id BIGINT,
    transaction_date DATE,
    store_code INTEGER,
    order_id VARCHAR(100),
    transaction_no BIGINT,
    line_number SMALLINT,
    offer_level VARCHAR(40),
    discount_code VARCHAR(50),
    discount_description VARCHAR(100),
    coupon_code VARCHAR(200),
    coupon_description VARCHAR(200),
    promotion_id INTEGER,
    promotion_code VARCHAR(100),
    promotion_description VARCHAR(400),
    offer_percent NUMERIC(18,2),
    offer_amount NUMERIC(18,2)
);

-- Marketing & Promotion Tables
CREATE TABLE SAS_PROMOTION_VW (
    promotion_id INTEGER PRIMARY KEY,
    client_promo_id VARCHAR(40),
    promotion_title VARCHAR(100),
    in_home_date DATE,
    start_date DATE,
    end_date DATE,
    promotion_level SMALLINT,
    promotion_type SMALLINT
);

CREATE TABLE SAS_PROMO_HISTORY_VW (
    household_id BIGINT,
    customer_id BIGINT,
    mstr_customer_id BIGINT,
    promotion_id INTEGER,
    segment_key VARCHAR(20),
    promotion_type SMALLINT
);

CREATE TABLE SAS_EMAIL_TRANS_VW (
    transaction_no BIGINT PRIMARY KEY,
    household_id BIGINT,
    customer_id BIGINT,
    mstr_customer_id BIGINT,
    mstr_household_id BIGINT,
    action_code VARCHAR(4),
    action_date DATE,
    business_unit SMALLINT,
    email_id BIGINT,
    promotion_id INTEGER,
    rec_added_date DATE,
    rec_updated_date DATE
);

-- Reference Tables
CREATE TABLE SAS_LOOKUP_VW (
    code_id SMALLINT,
    code INTEGER,
    code_description VARCHAR(60),
    description VARCHAR(200),
    client_code VARCHAR(100),
    parent_code_1 SMALLINT,
    PRIMARY KEY (code_id, code)
);

CREATE TABLE SAS_CALENDAR (
    exact_day_dt DATE PRIMARY KEY,
    calendar_year SMALLINT,
    calendar_quarter SMALLINT,
    calendar_month SMALLINT,
    calendar_week SMALLINT,
    fyr SMALLINT,
    fqq SMALLINT,
    fmm SMALLINT,
    fwk SMALLINT,
    us_holiday_ind VARCHAR(100),
    us_holiday_name VARCHAR(100)
);

CREATE TABLE SAS_STORE_DETAIL (
    store_number INTEGER PRIMARY KEY,
    business_unit SMALLINT,
    store_name VARCHAR(200),
    address_line1 VARCHAR(200),
    city VARCHAR(200),
    state VARCHAR(200),
    zip VARCHAR(200),
    country_code VARCHAR(200),
    store_type VARCHAR(200),
    region_code VARCHAR(200),
    open_date DATE,
    close_date DATE,
    latitude NUMERIC(18,6),
    longitude NUMERIC(18,6)
);

CREATE TABLE SAS_SKU_XREF_VW (
    long_item_number VARCHAR(40) PRIMARY KEY,
    company_source VARCHAR(20),
    business_unit SMALLINT,
    group_div VARCHAR(20),
    division VARCHAR(4),
    department VARCHAR(6),
    sub_department VARCHAR(8),
    label VARCHAR(4),
    label_code SMALLINT,
    cgroup_code INTEGER,
    vendor_style_no VARCHAR(30),
    item_description VARCHAR(50),
    short_sku_number INTEGER,
    upc_code VARCHAR(24)
);

-- Analytics Tables
CREATE TABLE CLICKSTREAM_AGGREGATE_VW (
    gcd_customer_id BIGINT,
    gcd_household_id BIGINT,
    mstr_customer_id BIGINT,
    fyr SMALLINT,
    fmm SMALLINT,
    fwk SMALLINT,
    visitor_id VARCHAR(512),
    total_visits INTEGER,
    total_pv INTEGER,
    homepage_pv INTEGER
);

-- Salesforce Marketing Cloud Tables
CREATE TABLE ENT_RLEU_CWW_Sent (
    sendid BIGINT,
    subscriberkey VARCHAR(100),
    clientid BIGINT,
    subscriberid BIGINT,
    listid BIGINT,
    eventdate TIMESTAMP,
    eventtype VARCHAR(6),
    PRIMARY KEY (sendid, subscriberkey)
);

CREATE TABLE ENT_RLEU_CWW_Opens (
    sendid BIGINT,
    subscriberkey VARCHAR(100),
    subscriberid BIGINT,
    listid BIGINT,
    eventdate TIMESTAMP,
    eventtype VARCHAR(4),
    clientid BIGINT,
    PRIMARY KEY (subscriberkey, eventdate)
);

CREATE TABLE ENT_RLEU_CWW_Clicks (
    sendid BIGINT,
    subscriberkey VARCHAR(100),
    subscriberid BIGINT,
    listid BIGINT,
    eventdate TIMESTAMP,
    url VARCHAR(4000),
    eventtype VARCHAR(6),
    clientid BIGINT,
    PRIMARY KEY (subscriberkey, eventdate)
);

CREATE TABLE ENT_RLEU_CWW_Bounces (
    sendid BIGINT,
    subscriberkey VARCHAR(100),
    subscriberid BIGINT,
    eventdate TIMESTAMP,
    bouncecategory VARCHAR(50),
    clientid BIGINT,
    PRIMARY KEY (subscriberkey, eventdate)
);

CREATE TABLE ENT_RLEU_CWW_Unsubs (
    sendid BIGINT,
    subscriberkey VARCHAR(100),
    subscriberid BIGINT,
    eventdate TIMESTAMP,
    eventtype VARCHAR(11),
    clientid BIGINT,
    PRIMARY KEY (subscriberkey, eventdate)
);

-- Currency Tables
CREATE TABLE CURRENCY_EXCHANGE_TB (
    fiscal_year SMALLINT PRIMARY KEY,
    year SMALLINT,
    month VARCHAR(10),
    month_number SMALLINT,
    euro NUMERIC(29,17),
    pound NUMERIC(29,17)
);

CREATE TABLE CURRENCY_EXCHANGE_VAT_TB (
    country_code VARCHAR(4) PRIMARY KEY,
    date1 DATE,
    vat1 NUMERIC(18,2)
);

-- Foreign Key Constraints
ALTER TABLE SAS_CUSTOMER_MSTR_VW ADD FOREIGN KEY (household_id) REFERENCES SAS_HOUSEHOLD_VW(household_id);
ALTER TABLE SAS_CUSTOMER_MSTR_BU_VW ADD FOREIGN KEY (customer_id) REFERENCES SAS_CUSTOMER_MSTR_VW(customer_id);
ALTER TABLE SAS_CUSTOMER_MSTR_BU_VW ADD FOREIGN KEY (household_id) REFERENCES SAS_HOUSEHOLD_VW(household_id);
ALTER TABLE SAS_HOUSEHOLD_BU_VW ADD FOREIGN KEY (household_id) REFERENCES SAS_HOUSEHOLD_VW(household_id);
ALTER TABLE SAS_CUST_MSTR_SUPPRESS ADD FOREIGN KEY (customer_id) REFERENCES SAS_CUSTOMER_MSTR_VW(customer_id);
ALTER TABLE SAS_EMAIL_ADDRESSES_VW ADD FOREIGN KEY (customer_id) REFERENCES SAS_CUSTOMER_MSTR_VW(customer_id);
ALTER TABLE SAS_EMAIL_ADDRESSES_VW ADD FOREIGN KEY (household_id) REFERENCES SAS_HOUSEHOLD_VW(household_id);
ALTER TABLE SAS_C_PHONE_VW ADD FOREIGN KEY (customer_id) REFERENCES SAS_CUSTOMER_MSTR_VW(customer_id);
ALTER TABLE SAS_C_PHONE_VW ADD FOREIGN KEY (household_id) REFERENCES SAS_HOUSEHOLD_VW(household_id);
ALTER TABLE SAS_CONTACT_SUMM_MSTR_VW ADD FOREIGN KEY (mstr_customer_id) REFERENCES SAS_CUSTOMER_MSTR_VW(mstr_customer_id);
ALTER TABLE SAS_TRANSACTION_VW ADD FOREIGN KEY (customer_id) REFERENCES SAS_CUSTOMER_MSTR_VW(customer_id);
ALTER TABLE SAS_TRANSACTION_VW ADD FOREIGN KEY (household_id) REFERENCES SAS_HOUSEHOLD_VW(household_id);
ALTER TABLE SAS_TRANSACTION_VW ADD FOREIGN KEY (store_code) REFERENCES SAS_STORE_DETAIL(store_number);
ALTER TABLE SAS_TRANS_TENDER ADD FOREIGN KEY (customer_id) REFERENCES SAS_CUSTOMER_MSTR_VW(customer_id);
ALTER TABLE SAS_TRANS_TENDER ADD FOREIGN KEY (order_id) REFERENCES SAS_TRANSACTION_VW(order_id);
ALTER TABLE SAS_OFFER_VW ADD FOREIGN KEY (customer_id) REFERENCES SAS_CUSTOMER_MSTR_VW(customer_id);
ALTER TABLE SAS_OFFER_VW ADD FOREIGN KEY (order_id) REFERENCES SAS_TRANSACTION_VW(order_id);
ALTER TABLE SAS_OFFER_VW ADD FOREIGN KEY (promotion_id) REFERENCES SAS_PROMOTION_VW(promotion_id);
ALTER TABLE SAS_PROMO_HISTORY_VW ADD FOREIGN KEY (customer_id) REFERENCES SAS_CUSTOMER_MSTR_VW(customer_id);
ALTER TABLE SAS_PROMO_HISTORY_VW ADD FOREIGN KEY (promotion_id) REFERENCES SAS_PROMOTION_VW(promotion_id);
ALTER TABLE SAS_EMAIL_TRANS_VW ADD FOREIGN KEY (customer_id) REFERENCES SAS_CUSTOMER_MSTR_VW(customer_id);
ALTER TABLE SAS_EMAIL_TRANS_VW ADD FOREIGN KEY (email_id) REFERENCES SAS_EMAIL_ADDRESSES_VW(email_id);
ALTER TABLE SAS_EMAIL_TRANS_VW ADD FOREIGN KEY (promotion_id) REFERENCES SAS_PROMOTION_VW(promotion_id);
ALTER TABLE CLICKSTREAM_AGGREGATE_VW ADD FOREIGN KEY (gcd_customer_id) REFERENCES SAS_CUSTOMER_MSTR_VW(customer_id);
ALTER TABLE CLICKSTREAM_AGGREGATE_VW ADD FOREIGN KEY (gcd_household_id) REFERENCES SAS_HOUSEHOLD_VW(household_id);
ALTER TABLE ENT_RLEU_CWW_Opens ADD FOREIGN KEY (sendid) REFERENCES ENT_RLEU_CWW_Sent(sendid);
ALTER TABLE ENT_RLEU_CWW_Clicks ADD FOREIGN KEY (sendid) REFERENCES ENT_RLEU_CWW_Sent(sendid);
ALTER TABLE ENT_RLEU_CWW_Bounces ADD FOREIGN KEY (sendid) REFERENCES ENT_RLEU_CWW_Sent(sendid);
ALTER TABLE ENT_RLEU_CWW_Unsubs ADD FOREIGN KEY (sendid) REFERENCES ENT_RLEU_CWW_Sent(sendid);
