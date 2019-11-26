PGDMP                     
    w            cq_db    12.1    12.1                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16393    cq_db    DATABASE     �   CREATE DATABASE cq_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'German_Austria.1252' LC_CTYPE = 'German_Austria.1252';
    DROP DATABASE cq_db;
                postgres    false            �            1259    16407    qrcodes    TABLE     d   CREATE TABLE public.qrcodes (
    qid integer NOT NULL,
    qrcontent character varying NOT NULL
);
    DROP TABLE public.qrcodes;
       public         heap    postgres    false            �            1259    16405    qrcodes_qid_seq    SEQUENCE     �   CREATE SEQUENCE public.qrcodes_qid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.qrcodes_qid_seq;
       public          postgres    false    205                       0    0    qrcodes_qid_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.qrcodes_qid_seq OWNED BY public.qrcodes.qid;
          public          postgres    false    204            �            1259    16416 	   userfound    TABLE     V   CREATE TABLE public.userfound (
    uid integer NOT NULL,
    qid integer NOT NULL
);
    DROP TABLE public.userfound;
       public         heap    postgres    false            �            1259    16396    users    TABLE     �   CREATE TABLE public.users (
    uid integer NOT NULL,
    username character varying(15) NOT NULL,
    email character varying(30) NOT NULL,
    password character varying NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    16394    users_uid_seq    SEQUENCE     �   CREATE SEQUENCE public.users_uid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.users_uid_seq;
       public          postgres    false    203                       0    0    users_uid_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.users_uid_seq OWNED BY public.users.uid;
          public          postgres    false    202            �
           2604    16410    qrcodes qid    DEFAULT     j   ALTER TABLE ONLY public.qrcodes ALTER COLUMN qid SET DEFAULT nextval('public.qrcodes_qid_seq'::regclass);
 :   ALTER TABLE public.qrcodes ALTER COLUMN qid DROP DEFAULT;
       public          postgres    false    205    204    205            �
           2604    16399 	   users uid    DEFAULT     f   ALTER TABLE ONLY public.users ALTER COLUMN uid SET DEFAULT nextval('public.users_uid_seq'::regclass);
 8   ALTER TABLE public.users ALTER COLUMN uid DROP DEFAULT;
       public          postgres    false    202    203    203                      0    16407    qrcodes 
   TABLE DATA           1   COPY public.qrcodes (qid, qrcontent) FROM stdin;
    public          postgres    false    205   �                 0    16416 	   userfound 
   TABLE DATA           -   COPY public.userfound (uid, qid) FROM stdin;
    public          postgres    false    206   �                 0    16396    users 
   TABLE DATA           ?   COPY public.users (uid, username, email, password) FROM stdin;
    public          postgres    false    203   �                   0    0    qrcodes_qid_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.qrcodes_qid_seq', 1, false);
          public          postgres    false    204            !           0    0    users_uid_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_uid_seq', 1, true);
          public          postgres    false    202            �
           2606    16415    qrcodes qrcodes_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.qrcodes
    ADD CONSTRAINT qrcodes_pkey PRIMARY KEY (qid);
 >   ALTER TABLE ONLY public.qrcodes DROP CONSTRAINT qrcodes_pkey;
       public            postgres    false    205            �
           2606    16420    userfound userfound_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.userfound
    ADD CONSTRAINT userfound_pkey PRIMARY KEY (uid, qid);
 B   ALTER TABLE ONLY public.userfound DROP CONSTRAINT userfound_pkey;
       public            postgres    false    206    206            �
           2606    16404    users users_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (uid);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    203            �
           2606    16426    userfound userfound_qid_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.userfound
    ADD CONSTRAINT userfound_qid_fkey FOREIGN KEY (qid) REFERENCES public.qrcodes(qid);
 F   ALTER TABLE ONLY public.userfound DROP CONSTRAINT userfound_qid_fkey;
       public          postgres    false    206    2704    205            �
           2606    16421    userfound userfound_uid_fkey    FK CONSTRAINT     x   ALTER TABLE ONLY public.userfound
    ADD CONSTRAINT userfound_uid_fkey FOREIGN KEY (uid) REFERENCES public.users(uid);
 F   ALTER TABLE ONLY public.userfound DROP CONSTRAINT userfound_uid_fkey;
       public          postgres    false    2702    203    206                  x������ � �            x������ � �         !   x�3�,I-.)Iz���`���1W� ��	H     