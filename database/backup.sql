--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9
-- Dumped by pg_dump version 16.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audit_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    store_id uuid,
    action character varying(100) NOT NULL,
    entity_type character varying(50) NOT NULL,
    entity_id uuid,
    payload json,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.audit_logs OWNER TO postgres;

--
-- Name: cash_flow_entries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cash_flow_entries (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    store_id uuid NOT NULL,
    customer_id uuid,
    type character varying(20) NOT NULL,
    category character varying(100) NOT NULL,
    description text NOT NULL,
    amount numeric(12,2) NOT NULL,
    payment_method character varying(50),
    reference character varying(255),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.cash_flow_entries OWNER TO postgres;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    store_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    phone character varying(50),
    email character varying(255),
    address text,
    balance numeric(12,2) DEFAULT '0'::numeric,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: debt_payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.debt_payments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    debt_id uuid NOT NULL,
    store_id uuid NOT NULL,
    amount numeric(12,2) NOT NULL,
    payment_method character varying(50),
    notes text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.debt_payments OWNER TO postgres;

--
-- Name: debts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.debts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    transaction_id uuid NOT NULL,
    store_id uuid NOT NULL,
    customer_id uuid NOT NULL,
    amount numeric(12,2) NOT NULL,
    paid_amount numeric(12,2) DEFAULT '0'::numeric,
    due_date timestamp without time zone,
    status character varying(20) DEFAULT 'pending'::character varying,
    reminder_sent boolean DEFAULT false,
    last_reminder_date timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.debts OWNER TO postgres;

--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    store_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    sku character varying(100) NOT NULL,
    price_buy numeric(12,2) NOT NULL,
    price_sell numeric(12,2) NOT NULL,
    stock integer DEFAULT 0 NOT NULL,
    unit character varying(50) DEFAULT 'pcs'::character varying,
    category character varying(100),
    description text,
    image_url text,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: stock_movements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock_movements (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    product_id uuid NOT NULL,
    store_id uuid NOT NULL,
    type character varying(20) NOT NULL,
    quantity integer NOT NULL,
    reference character varying(255),
    notes text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.stock_movements OWNER TO postgres;

--
-- Name: stores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stores (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255) NOT NULL,
    address text,
    phone character varying(50),
    timezone character varying(50) DEFAULT 'Asia/Jakarta'::character varying,
    currency character varying(10) DEFAULT 'IDR'::character varying,
    low_stock_threshold integer DEFAULT 5,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.stores OWNER TO postgres;

--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    store_id uuid NOT NULL,
    customer_id uuid,
    invoice_number character varying(100) NOT NULL,
    items json NOT NULL,
    subtotal numeric(12,2) NOT NULL,
    discount numeric(12,2) DEFAULT '0'::numeric,
    tax numeric(12,2) DEFAULT '0'::numeric,
    total numeric(12,2) NOT NULL,
    payment_status character varying(20) DEFAULT 'unpaid'::character varying NOT NULL,
    payment_method character varying(50),
    notes text,
    offline_id character varying(100),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255),
    phone character varying(50),
    role character varying(50) DEFAULT 'cashier'::character varying NOT NULL,
    password_hash text NOT NULL,
    store_ids json DEFAULT '[]'::json,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.audit_logs (id, user_id, store_id, action, entity_type, entity_id, payload, created_at) FROM stdin;
\.


--
-- Data for Name: cash_flow_entries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cash_flow_entries (id, store_id, customer_id, type, category, description, amount, payment_method, reference, created_at, updated_at) FROM stdin;
d64b54e8-a87a-4a81-9200-562e4d6b0a56	b47e1a4c-2f41-461b-9c29-ccc215466cac	\N	income	Penjualan	Penjualan hari ini	500000.00	\N	\N	2025-09-09 17:30:25.865683	2025-09-09 17:30:25.865683
cba25b17-f5f0-4ef5-8bfd-3e4d6bc32ef9	b47e1a4c-2f41-461b-9c29-ccc215466cac	\N	expense	Pembelian	Beli stok barang	200000.00	\N	\N	2025-09-09 17:30:25.868384	2025-09-09 17:30:25.868384
5d22a98c-e25f-43f7-a175-437f25bdd41d	b47e1a4c-2f41-461b-9c29-ccc215466cac	\N	income	Piutang	Pelunasan piutang	150000.00	\N	\N	2025-09-09 17:30:25.872844	2025-09-09 17:30:25.872844
bad6f17d-728f-495a-9cec-3e5735d9081f	b47e1a4c-2f41-461b-9c29-ccc215466cac	\N	expense	Operasional	Bayar listrik	50000.00	\N	\N	2025-09-09 17:30:25.875255	2025-09-09 17:30:25.875255
d148a0b0-9556-43aa-ba47-b290f280b337	c9bba60c-68e6-4fb1-b806-975dc5338b5c	\N	income	Penjualan	Penjualan hari ini	500000.00	\N	\N	2025-09-09 17:30:25.879825	2025-09-09 17:30:25.879825
297dbd3f-4b76-4f19-a72a-786ce2b84875	c9bba60c-68e6-4fb1-b806-975dc5338b5c	\N	expense	Pembelian	Beli stok barang	200000.00	\N	\N	2025-09-09 17:30:25.882093	2025-09-09 17:30:25.882093
778dece5-e57c-48aa-8500-d8e27eb2e1a2	c9bba60c-68e6-4fb1-b806-975dc5338b5c	\N	income	Piutang	Pelunasan piutang	150000.00	\N	\N	2025-09-09 17:30:25.888239	2025-09-09 17:30:25.888239
282b06ef-8da2-4702-b59f-24a12cebfbd9	c9bba60c-68e6-4fb1-b806-975dc5338b5c	\N	expense	Operasional	Bayar listrik	50000.00	\N	\N	2025-09-09 17:30:25.890536	2025-09-09 17:30:25.890536
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, store_id, name, phone, email, address, balance, created_at, updated_at) FROM stdin;
26b77547-47a8-41b5-9e95-b4ff315deab3	b47e1a4c-2f41-461b-9c29-ccc215466cac	Ibu Sari	08123456789	sari@email.com	Jl. Kenanga No. 10	0.00	2025-09-09 17:30:25.837224	2025-09-09 17:30:25.837224
1b080019-6c27-4479-b69d-2d04e9d74dcb	b47e1a4c-2f41-461b-9c29-ccc215466cac	Pak Budi	08234567890	\N	Jl. Anggrek No. 15	0.00	2025-09-09 17:30:25.841852	2025-09-09 17:30:25.841852
126267f7-f93a-43d6-8133-0624a8d378b5	b47e1a4c-2f41-461b-9c29-ccc215466cac	Ibu Maya	08345678901	maya@email.com	Jl. Cempaka No. 20	0.00	2025-09-09 17:30:25.848153	2025-09-09 17:30:25.848153
a4c6a6f7-69fb-4d33-95b3-0350f5f5ce9d	b47e1a4c-2f41-461b-9c29-ccc215466cac	Pak Joko	08456789012	\N	Jl. Dahlia No. 25	0.00	2025-09-09 17:30:25.85144	2025-09-09 17:30:25.85144
2e1acd4c-a47e-486b-a0fc-bc13391080fc	c9bba60c-68e6-4fb1-b806-975dc5338b5c	Ibu Sari	08123456789	sari@email.com	Jl. Kenanga No. 10	0.00	2025-09-09 17:30:25.853968	2025-09-09 17:30:25.853968
1912b02f-8fcc-4212-b8f4-1b84519fd805	c9bba60c-68e6-4fb1-b806-975dc5338b5c	Pak Budi	08234567890	\N	Jl. Anggrek No. 15	0.00	2025-09-09 17:30:25.856328	2025-09-09 17:30:25.856328
eeac2c18-89ec-44d4-8bba-0fc085d8486a	c9bba60c-68e6-4fb1-b806-975dc5338b5c	Ibu Maya	08345678901	maya@email.com	Jl. Cempaka No. 20	0.00	2025-09-09 17:30:25.860623	2025-09-09 17:30:25.860623
f8c8e723-eed6-409a-a184-36d56f7f150e	c9bba60c-68e6-4fb1-b806-975dc5338b5c	Pak Joko	08456789012	\N	Jl. Dahlia No. 25	0.00	2025-09-09 17:30:25.862893	2025-09-09 17:30:25.862893
3acba716-424b-4d36-8776-518551efb99d	b47e1a4c-2f41-461b-9c29-ccc215466cac	Budi (Toko Sumber Rejeki)	08123456789	\N	Jakarta Utara	0.00	2025-09-09 17:51:34.490926	2025-09-09 17:51:34.490926
d9cd3239-7618-4a90-87ec-0567b2fc5737	c9bba60c-68e6-4fb1-b806-975dc5338b5c	Sari (Warung Bu Siti)	08198765432	\N	Bandung Timur	0.00	2025-09-09 17:51:35.758934	2025-09-09 17:51:35.758934
97261f1e-d9b5-4d51-b10f-29d29f2838b2	b47e1a4c-2f41-461b-9c29-ccc215466cac	231	313			0.00	2025-09-09 17:52:47.702125	2025-09-09 17:52:47.702125
\.


--
-- Data for Name: debt_payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.debt_payments (id, debt_id, store_id, amount, payment_method, notes, created_at) FROM stdin;
\.


--
-- Data for Name: debts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.debts (id, transaction_id, store_id, customer_id, amount, paid_amount, due_date, status, reminder_sent, last_reminder_date, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, store_id, name, sku, price_buy, price_sell, stock, unit, category, description, image_url, is_active, created_at, updated_at) FROM stdin;
01ba3c38-bc42-42a7-9e31-8c2c39f12607	b47e1a4c-2f41-461b-9c29-ccc215466cac	Beras Premium 5kg	BRS001-6cac	45000.00	52000.00	25	karung	Sembako	\N	\N	t	2025-09-09 17:30:25.787311	2025-09-09 17:30:25.787311
0d036c0c-d413-4d09-8212-4179f4ed2c56	b47e1a4c-2f41-461b-9c29-ccc215466cac	Minyak Goreng 2L	MYG001-6cac	28000.00	32000.00	15	botol	Sembako	\N	\N	t	2025-09-09 17:30:25.790716	2025-09-09 17:30:25.790716
bce3df64-71d3-49ef-8b14-48d167e26faa	b47e1a4c-2f41-461b-9c29-ccc215466cac	Gula Pasir 1kg	GLP001-6cac	12000.00	14000.00	30	kg	Sembako	\N	\N	t	2025-09-09 17:30:25.795834	2025-09-09 17:30:25.795834
956c70d8-fcb8-4cf2-a0fc-559c9e073682	b47e1a4c-2f41-461b-9c29-ccc215466cac	Teh Celup 25 pcs	TEH001-6cac	8000.00	10000.00	50	kotak	Minuman	\N	\N	t	2025-09-09 17:30:25.79864	2025-09-09 17:30:25.79864
5f38d06f-6b35-4052-bafa-ab6a1bb2c717	b47e1a4c-2f41-461b-9c29-ccc215466cac	Kopi Instan	KOP001-6cac	15000.00	18000.00	20	sachet	Minuman	\N	\N	t	2025-09-09 17:30:25.801011	2025-09-09 17:30:25.801011
a6d4b389-1e4f-445b-98cb-7aa79913d0aa	b47e1a4c-2f41-461b-9c29-ccc215466cac	Sabun Mandi	SAB001-6cac	3500.00	5000.00	40	batang	Kebersihan	\N	\N	t	2025-09-09 17:30:25.803032	2025-09-09 17:30:25.803032
b025ff91-c5ee-4c5e-bf08-fd2599e91b23	c9bba60c-68e6-4fb1-b806-975dc5338b5c	Beras Premium 5kg	BRS001-8b5c	45000.00	52000.00	25	karung	Sembako	\N	\N	t	2025-09-09 17:30:25.808256	2025-09-09 17:30:25.808256
fb450c71-3bce-42fc-b08f-da4007976983	c9bba60c-68e6-4fb1-b806-975dc5338b5c	Minyak Goreng 2L	MYG001-8b5c	28000.00	32000.00	15	botol	Sembako	\N	\N	t	2025-09-09 17:30:25.811041	2025-09-09 17:30:25.811041
5bf3dae9-d07e-42b7-9fa4-654e16ea89e8	c9bba60c-68e6-4fb1-b806-975dc5338b5c	Gula Pasir 1kg	GLP001-8b5c	12000.00	14000.00	30	kg	Sembako	\N	\N	t	2025-09-09 17:30:25.815933	2025-09-09 17:30:25.815933
51e54907-736c-41b8-961e-6f22b816fbc7	c9bba60c-68e6-4fb1-b806-975dc5338b5c	Teh Celup 25 pcs	TEH001-8b5c	8000.00	10000.00	50	kotak	Minuman	\N	\N	t	2025-09-09 17:30:25.822357	2025-09-09 17:30:25.822357
52693a79-2895-4f22-9d79-0e94230274e6	c9bba60c-68e6-4fb1-b806-975dc5338b5c	Kopi Instan	KOP001-8b5c	15000.00	18000.00	20	sachet	Minuman	\N	\N	t	2025-09-09 17:30:25.82653	2025-09-09 17:30:25.82653
13d50956-02f1-4516-af90-9d437bba0bf1	c9bba60c-68e6-4fb1-b806-975dc5338b5c	Sabun Mandi	SAB001-8b5c	3500.00	5000.00	40	batang	Kebersihan	\N	\N	t	2025-09-09 17:30:25.83453	2025-09-09 17:30:25.83453
d569c0f8-d4c3-44d3-8482-345d395e08a0	b47e1a4c-2f41-461b-9c29-ccc215466cac	Test Produk Toko Sumber Rejeki	TSR-001	10000.00	15000.00	20	pcs	\N	\N	\N	t	2025-09-09 17:51:23.681448	2025-09-09 17:51:23.681448
79facba0-66ce-4a40-8dcf-15868db7085e	c9bba60c-68e6-4fb1-b806-975dc5338b5c	Test Produk Warung Bu Siti	WBS-001	8000.00	12000.00	15	pcs	\N	\N	\N	t	2025-09-09 17:51:25.337975	2025-09-09 17:51:25.337975
3a6e5027-af31-4bfd-88eb-220a4b77496d	b47e1a4c-2f41-461b-9c29-ccc215466cac	313	13	313.00	13.00	13123	pcs		\N	\N	t	2025-09-09 17:52:55.893586	2025-09-09 17:52:55.893586
\.


--
-- Data for Name: stock_movements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stock_movements (id, product_id, store_id, type, quantity, reference, notes, created_at) FROM stdin;
\.


--
-- Data for Name: stores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stores (id, name, address, phone, timezone, currency, low_stock_threshold, created_at, updated_at) FROM stdin;
b47e1a4c-2f41-461b-9c29-ccc215466cac	Toko Sumber Rejeki	Jl. Mawar No. 123, Jakarta Selatan	021-12345678	Asia/Jakarta	IDR	5	2025-09-09 17:30:25.109374	2025-09-09 17:30:25.109374
c9bba60c-68e6-4fb1-b806-975dc5338b5c	Warung Bu Siti	Jl. Melati No. 456, Bandung	022-87654321	Asia/Jakarta	IDR	3	2025-09-09 17:30:25.78426	2025-09-09 17:30:25.78426
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, store_id, customer_id, invoice_number, items, subtotal, discount, tax, total, payment_status, payment_method, notes, offline_id, created_at, updated_at) FROM stdin;
0bc547ad-48ac-4eea-89af-24f093d4194b	b47e1a4c-2f41-461b-9c29-ccc215466cac	26b77547-47a8-41b5-9e95-b4ff315deab3	TRX-1757439025893-0	[{"productId":"01ba3c38-bc42-42a7-9e31-8c2c39f12607","productName":"Beras Premium 5kg","quantity":2,"price":52000,"discount":0},{"productId":"0d036c0c-d413-4d09-8212-4179f4ed2c56","productName":"Minyak Goreng 2L","quantity":2,"price":32000,"discount":0},{"productId":"bce3df64-71d3-49ef-8b14-48d167e26faa","productName":"Gula Pasir 1kg","quantity":3,"price":14000,"discount":0}]	210000.00	0.00	0.00	210000.00	paid	cash	Transaksi contoh	\N	2025-09-09 17:30:25.894139	2025-09-09 17:30:25.894139
df3dc63c-cb9e-4301-a348-df3e2286fd57	c9bba60c-68e6-4fb1-b806-975dc5338b5c	2e1acd4c-a47e-486b-a0fc-bc13391080fc	TRX-1757439025897-1	[{"productId":"b025ff91-c5ee-4c5e-bf08-fd2599e91b23","productName":"Beras Premium 5kg","quantity":2,"price":52000,"discount":0},{"productId":"fb450c71-3bce-42fc-b08f-da4007976983","productName":"Minyak Goreng 2L","quantity":2,"price":32000,"discount":0},{"productId":"5bf3dae9-d07e-42b7-9fa4-654e16ea89e8","productName":"Gula Pasir 1kg","quantity":1,"price":14000,"discount":0}]	182000.00	0.00	0.00	182000.00	paid	cash	Transaksi contoh	\N	2025-09-09 17:30:25.897604	2025-09-09 17:30:25.897604
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, phone, role, password_hash, store_ids, created_at, updated_at) FROM stdin;
d0e2a075-4ee5-406b-adf0-bbfc50bd289f	Admin POS	admin@pos.com	\N	owner	$2b$10$VANsGF4rZ2rABNv5dt4LrOxwjdEfoLSwWAQqahjy.jGnanbUQoEMi	["b47e1a4c-2f41-461b-9c29-ccc215466cac", "c9bba60c-68e6-4fb1-b806-975dc5338b5c"]	2025-09-09 17:40:32.873921	2025-09-09 17:40:32.873921
\.


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: cash_flow_entries cash_flow_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cash_flow_entries
    ADD CONSTRAINT cash_flow_entries_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: debt_payments debt_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.debt_payments
    ADD CONSTRAINT debt_payments_pkey PRIMARY KEY (id);


--
-- Name: debts debts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.debts
    ADD CONSTRAINT debts_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: stock_movements stock_movements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_movements
    ADD CONSTRAINT stock_movements_pkey PRIMARY KEY (id);


--
-- Name: stores stores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: audit_logs audit_logs_store_id_stores_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_store_id_stores_id_fk FOREIGN KEY (store_id) REFERENCES public.stores(id);


--
-- Name: audit_logs audit_logs_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: cash_flow_entries cash_flow_entries_customer_id_customers_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cash_flow_entries
    ADD CONSTRAINT cash_flow_entries_customer_id_customers_id_fk FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE SET NULL;


--
-- Name: cash_flow_entries cash_flow_entries_store_id_stores_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cash_flow_entries
    ADD CONSTRAINT cash_flow_entries_store_id_stores_id_fk FOREIGN KEY (store_id) REFERENCES public.stores(id) ON DELETE CASCADE;


--
-- Name: customers customers_store_id_stores_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_store_id_stores_id_fk FOREIGN KEY (store_id) REFERENCES public.stores(id) ON DELETE CASCADE;


--
-- Name: debt_payments debt_payments_debt_id_debts_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.debt_payments
    ADD CONSTRAINT debt_payments_debt_id_debts_id_fk FOREIGN KEY (debt_id) REFERENCES public.debts(id) ON DELETE CASCADE;


--
-- Name: debt_payments debt_payments_store_id_stores_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.debt_payments
    ADD CONSTRAINT debt_payments_store_id_stores_id_fk FOREIGN KEY (store_id) REFERENCES public.stores(id) ON DELETE CASCADE;


--
-- Name: debts debts_customer_id_customers_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.debts
    ADD CONSTRAINT debts_customer_id_customers_id_fk FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE CASCADE;


--
-- Name: debts debts_store_id_stores_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.debts
    ADD CONSTRAINT debts_store_id_stores_id_fk FOREIGN KEY (store_id) REFERENCES public.stores(id) ON DELETE CASCADE;


--
-- Name: debts debts_transaction_id_transactions_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.debts
    ADD CONSTRAINT debts_transaction_id_transactions_id_fk FOREIGN KEY (transaction_id) REFERENCES public.transactions(id) ON DELETE CASCADE;


--
-- Name: products products_store_id_stores_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_store_id_stores_id_fk FOREIGN KEY (store_id) REFERENCES public.stores(id) ON DELETE CASCADE;


--
-- Name: stock_movements stock_movements_product_id_products_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_movements
    ADD CONSTRAINT stock_movements_product_id_products_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: stock_movements stock_movements_store_id_stores_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_movements
    ADD CONSTRAINT stock_movements_store_id_stores_id_fk FOREIGN KEY (store_id) REFERENCES public.stores(id) ON DELETE CASCADE;


--
-- Name: transactions transactions_customer_id_customers_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_customer_id_customers_id_fk FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: transactions transactions_store_id_stores_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_store_id_stores_id_fk FOREIGN KEY (store_id) REFERENCES public.stores(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

