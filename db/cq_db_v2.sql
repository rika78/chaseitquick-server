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
-- Name: spielmodus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spielmodus (
    spmid integer NOT NULL,
    spmname character varying(30)
);


ALTER TABLE public.spielmodus OWNER TO postgres;

--
-- Name: spielmodus_spmid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.spielmodus_spmid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spielmodus_spmid_seq OWNER TO postgres;

--
-- Name: spielmodus_spmid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.spielmodus_spmid_seq OWNED BY public.spielmodus.spmid;


--
-- Name: spielsession; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spielsession (
    sessid integer NOT NULL,
    spmid integer,
    uid integer NOT NULL,
    "time" timestamp without time zone DEFAULT now() NOT NULL,
    punkte integer NOT NULL,
    fertig boolean
);


ALTER TABLE public.spielsession OWNER TO postgres;

--
-- Name: spielsession_sessid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.spielsession_sessid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.spielsession_sessid_seq OWNER TO postgres;

--
-- Name: spielsession_sessid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.spielsession_sessid_seq OWNED BY public.spielsession.sessid;


--
-- Name: userfound; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userfound (
    sessid integer NOT NULL,
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
-- Name: spielmodus spmid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spielmodus ALTER COLUMN spmid SET DEFAULT nextval('public.spielmodus_spmid_seq'::regclass);


--
-- Name: spielsession sessid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spielsession ALTER COLUMN sessid SET DEFAULT nextval('public.spielsession_sessid_seq'::regclass);


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
-- Data for Name: spielmodus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spielmodus (spmid, spmname) FROM stdin;
\.


--
-- Data for Name: spielsession; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spielsession (sessid, spmid, uid, "time", punkte, fertig) FROM stdin;
\.


--
-- Data for Name: userfound; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.userfound (sessid, uid, qid, "time") FROM stdin;
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
-- Name: spielmodus_spmid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.spielmodus_spmid_seq', 1, false);


--
-- Name: spielsession_sessid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.spielsession_sessid_seq', 1, false);


--
-- Name: users_uid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_uid_seq', 2, true);


--
-- Name: qrcodes qrcodes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qrcodes
    ADD CONSTRAINT qrcodes_pkey PRIMARY KEY (qid);


--
-- Name: spielmodus spielmodus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spielmodus
    ADD CONSTRAINT spielmodus_pkey PRIMARY KEY (spmid);


--
-- Name: spielsession spielsession_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spielsession
    ADD CONSTRAINT spielsession_pkey PRIMARY KEY (sessid);


--
-- Name: userfound userfound_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userfound
    ADD CONSTRAINT userfound_pkey PRIMARY KEY (uid, qid, sessid);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (uid);


--
-- Name: spielsession spielsession_spmid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spielsession
    ADD CONSTRAINT spielsession_spmid_fkey FOREIGN KEY (spmid) REFERENCES public.spielmodus(spmid);


--
-- Name: spielsession spielsession_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spielsession
    ADD CONSTRAINT spielsession_uid_fkey FOREIGN KEY (uid) REFERENCES public.users(uid);


--
-- Name: userfound userfound_qid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userfound
    ADD CONSTRAINT userfound_qid_fkey FOREIGN KEY (qid) REFERENCES public.qrcodes(qid);


--
-- Name: userfound userfound_sessid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userfound
    ADD CONSTRAINT userfound_sessid_fkey FOREIGN KEY (sessid) REFERENCES public.spielmodus(spmid);


--
-- Name: userfound userfound_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userfound
    ADD CONSTRAINT userfound_uid_fkey FOREIGN KEY (uid) REFERENCES public.users(uid);


--
-- PostgreSQL database dump complete
--

