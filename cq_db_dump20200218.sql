--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1
-- Dumped by pg_dump version 12.1

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
-- Name: qrcodes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qrcodes (
    qid integer NOT NULL,
    qrcontent character varying NOT NULL
);


ALTER TABLE public.qrcodes OWNER TO postgres;

--
-- Name: qrcodes_qid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.qrcodes_qid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.qrcodes_qid_seq OWNER TO postgres;

--
-- Name: qrcodes_qid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.qrcodes_qid_seq OWNED BY public.qrcodes.qid;


--
-- Name: userfound; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userfound (
    uid integer NOT NULL,
    qid integer NOT NULL,
    "time" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.userfound OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    uid integer NOT NULL,
    username character varying(30) NOT NULL,
    email character varying(30) NOT NULL,
    password character varying NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_uid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_uid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_uid_seq OWNER TO postgres;

--
-- Name: users_uid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_uid_seq OWNED BY public.users.uid;


--
-- Name: qrcodes qid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrcodes ALTER COLUMN qid SET DEFAULT nextval('public.qrcodes_qid_seq'::regclass);


--
-- Name: users uid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN uid SET DEFAULT nextval('public.users_uid_seq'::regclass);


--
-- Data for Name: qrcodes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.qrcodes (qid, qrcontent) FROM stdin;
1	QR Code Nummer 1
2	QR Code Nummer 2
3	QR Code Nummer 3
4	QR Code Nummer 4
5	QR Code Nummer 5
6	QR Code Nummer 6
\.


--
-- Data for Name: userfound; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.userfound (uid, qid, "time") FROM stdin;
1	1	2020-02-18 13:08:53.528537
1	2	2020-02-18 13:12:42.372445
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (uid, username, email, password) FROM stdin;
1	test2	test2@db.com	$2b$10$1Zipskx0hQkc6FybJhPGguAAAQL7XP2a0xpLD68h7.5sH1KdobQi.
\.


--
-- Name: qrcodes_qid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.qrcodes_qid_seq', 1, false);


--
-- Name: users_uid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_uid_seq', 1, true);


--
-- Name: qrcodes qrcodes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrcodes
    ADD CONSTRAINT qrcodes_pkey PRIMARY KEY (qid);


--
-- Name: userfound userfound_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userfound
    ADD CONSTRAINT userfound_pkey PRIMARY KEY (uid, qid);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (uid);


--
-- Name: userfound userfound_qid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userfound
    ADD CONSTRAINT userfound_qid_fkey FOREIGN KEY (qid) REFERENCES public.qrcodes(qid);


--
-- Name: userfound userfound_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userfound
    ADD CONSTRAINT userfound_uid_fkey FOREIGN KEY (uid) REFERENCES public.users(uid);


--
-- PostgreSQL database dump complete
--

