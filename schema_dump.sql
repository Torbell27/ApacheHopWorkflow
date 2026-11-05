--
-- PostgreSQL database dump
--

\restrict iTj5nkYvzw5CwMG0aefv9voh5pMag7Xuk2yzMXq0DKN6YPoRxlluEjmd99A1QY8

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: category_analytics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category_analytics (
    category text NOT NULL,
    product_count bigint,
    average_price numeric(12,2),
    min_price numeric(12,2),
    max_price numeric(12,2),
    average_rating numeric(3,2),
    total_reviews bigint,
    calculated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.category_analytics OWNER TO postgres;

--
-- Name: dashboard_summary; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dashboard_summary (
    metric_name text NOT NULL,
    metric_value numeric(18,2),
    metric_description text,
    calculated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.dashboard_summary OWNER TO postgres;

--
-- Name: data_quality_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_quality_log (
    check_id bigint NOT NULL,
    check_name text NOT NULL,
    failed_count bigint NOT NULL,
    check_status text NOT NULL,
    checked_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.data_quality_log OWNER TO postgres;

--
-- Name: data_quality_log_check_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.data_quality_log ALTER COLUMN check_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.data_quality_log_check_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: fx_rates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fx_rates (
    rate_id bigint NOT NULL,
    rate_date date NOT NULL,
    base_currency text NOT NULL,
    quote_currency text NOT NULL,
    exchange_rate numeric(18,8) NOT NULL,
    source text NOT NULL,
    http_status integer,
    response_time_ms integer,
    loaded_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.fx_rates OWNER TO postgres;

--
-- Name: fx_rates_rate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.fx_rates ALTER COLUMN rate_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.fx_rates_rate_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: inventory_analytics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_analytics (
    stock_status text NOT NULL,
    product_count bigint,
    percentage_of_products numeric(8,2),
    average_price numeric(12,2),
    calculated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.inventory_analytics OWNER TO postgres;

--
-- Name: price_analytics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.price_analytics (
    price_segment text NOT NULL,
    product_count bigint,
    average_price numeric(12,2),
    min_price numeric(12,2),
    max_price numeric(12,2),
    average_discount numeric(8,2),
    calculated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.price_analytics OWNER TO postgres;

--
-- Name: products_clean; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_clean (
    product_id text NOT NULL,
    sku text,
    spu text,
    title text,
    product_url text,
    country text,
    currency text,
    price numeric(12,2),
    price_display text,
    original_price numeric(12,2),
    original_price_display text,
    discount_pct numeric(8,4),
    price_usd numeric(12,2),
    top_category text,
    category text,
    category_path text,
    category_id text,
    in_stock boolean,
    stock_indicator integer,
    review_count integer,
    rating numeric(3,2),
    color_count integer,
    image_url text,
    image_urls text,
    image_count integer,
    seller_store_id text,
    created_date date,
    collected_at timestamp with time zone,
    source_file text,
    run_id uuid,
    cleaned_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.products_clean OWNER TO postgres;

--
-- Name: products_enriched; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products_enriched (
    product_id text NOT NULL,
    rate_date date,
    base_currency text,
    quote_currency text,
    exchange_rate numeric(18,8),
    price_gbp numeric(12,2),
    price_usd_current numeric(12,2),
    api_source text,
    enriched_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.products_enriched OWNER TO postgres;

--
-- Name: staging_products_raw; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staging_products_raw (
    raw_id bigint NOT NULL,
    run_id uuid NOT NULL,
    product_id text,
    sku text,
    spu text,
    title text,
    product_url text,
    country text,
    currency text,
    price text,
    price_display text,
    original_price text,
    original_price_display text,
    discount_pct text,
    price_usd text,
    top_category text,
    category text,
    category_path text,
    category_id text,
    in_stock text,
    stock_indicator text,
    review_count text,
    rating text,
    color_count text,
    image_url text,
    image_urls text,
    image_count text,
    seller_store_id text,
    created_date text,
    collected_at text,
    source_file text,
    ingested_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.staging_products_raw OWNER TO postgres;

--
-- Name: staging_products_raw_raw_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.staging_products_raw ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.staging_products_raw_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: category_analytics category_analytics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_analytics
    ADD CONSTRAINT category_analytics_pkey PRIMARY KEY (category);


--
-- Name: dashboard_summary dashboard_summary_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dashboard_summary
    ADD CONSTRAINT dashboard_summary_pkey PRIMARY KEY (metric_name);


--
-- Name: data_quality_log data_quality_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_quality_log
    ADD CONSTRAINT data_quality_log_pkey PRIMARY KEY (check_id);


--
-- Name: fx_rates fx_rates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fx_rates
    ADD CONSTRAINT fx_rates_pkey PRIMARY KEY (rate_id);


--
-- Name: inventory_analytics inventory_analytics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_analytics
    ADD CONSTRAINT inventory_analytics_pkey PRIMARY KEY (stock_status);


--
-- Name: price_analytics price_analytics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.price_analytics
    ADD CONSTRAINT price_analytics_pkey PRIMARY KEY (price_segment);


--
-- Name: products_clean products_clean_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_clean
    ADD CONSTRAINT products_clean_pkey PRIMARY KEY (product_id);


--
-- Name: products_enriched products_enriched_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products_enriched
    ADD CONSTRAINT products_enriched_pkey PRIMARY KEY (product_id);


--
-- Name: staging_products_raw staging_products_raw_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staging_products_raw
    ADD CONSTRAINT staging_products_raw_pkey PRIMARY KEY (raw_id);


--
-- Name: idx_raw_run_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_raw_run_id ON public.staging_products_raw USING btree (run_id);


--
-- PostgreSQL database dump complete
--

\unrestrict iTj5nkYvzw5CwMG0aefv9voh5pMag7Xuk2yzMXq0DKN6YPoRxlluEjmd99A1QY8

