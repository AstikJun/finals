PGDMP     "    
                 z            finals    9.3.3    14.1 7    ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ?           1262    336182    finals    DATABASE     g   CREATE DATABASE finals WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Kyrgyzstan.1251';
    DROP DATABASE finals;
                postgres    false            ?           0    0    SCHEMA public    ACL     ?   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   postgres    false    6            ?            1255    336250    delete_audit()    FUNCTION     ?   CREATE FUNCTION public.delete_audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
 	BEGIN
 		delete from audit
		WHERE user_id = (select id from users where users.id = old.id) ;
 		return old;
 	END
 $$;
 %   DROP FUNCTION public.delete_audit();
       public          postgres    false            ?            1255    336252    new_audit()    FUNCTION     #  CREATE FUNCTION public.new_audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
 	begin
 		insert into audit (user_id, entry_date , email) 
		values ((select id from users where id = new.id) ,current_timestamp,(select email from users where email = new.email));
 		RETURN new;
 	end 
 $$;
 "   DROP FUNCTION public.new_audit();
       public          postgres    false            ?            1255    336257    update_audit()    FUNCTION       CREATE FUNCTION public.update_audit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
 	begin
 		update audit set email = (select email from users where email = new.email),
		entry_date = current_timestamp
		WHERE user_id = old.id;
		 
	
 		RETURN old;
 	end 
 $$;
 %   DROP FUNCTION public.update_audit();
       public          postgres    false            ?            1259    336211    animals    TABLE     ?   CREATE TABLE public.animals (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    age integer NOT NULL,
    price integer DEFAULT 0,
    description character varying(50) DEFAULT ''::character varying
);
    DROP TABLE public.animals;
       public            postgres    false            ?            1259    336209    animals_id_seq    SEQUENCE     w   CREATE SEQUENCE public.animals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.animals_id_seq;
       public          postgres    false    176            ?           0    0    animals_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.animals_id_seq OWNED BY public.animals.id;
          public          postgres    false    175            ?            1259    336234    user_buy_animal    TABLE     ?   CREATE TABLE public.user_buy_animal (
    id integer NOT NULL,
    user_id integer NOT NULL,
    animal_id integer NOT NULL,
    bought_at timestamp without time zone
);
 #   DROP TABLE public.user_buy_animal;
       public            postgres    false            ?            1259    336259    animals_view    VIEW     m  CREATE VIEW public.animals_view AS
 SELECT animals.id,
    animals.name,
    animals.age,
    animals.price,
    animals.description,
    animals.price AS price_count
   FROM (public.animals
   LEFT JOIN ( SELECT b.user_id,
            count(*) AS price_count
           FROM public.user_buy_animal b
          GROUP BY b.user_id) a ON ((a.user_id = animals.id)));
    DROP VIEW public.animals_view;
       public          postgres    false    176    176    180    176    176    176            ?            1259    336254    audit    TABLE     ?   CREATE TABLE public.audit (
    user_id integer NOT NULL,
    entry_date character varying(100) NOT NULL,
    email character varying(100)
);
    DROP TABLE public.audit;
       public            postgres    false            ?            1259    336221 
   categories    TABLE     ?   CREATE TABLE public.categories (
    id integer NOT NULL,
    animal_id integer,
    animal_category character varying(50) NOT NULL
);
    DROP TABLE public.categories;
       public            postgres    false            ?            1259    336219    categories_id_seq    SEQUENCE     z   CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.categories_id_seq;
       public          postgres    false    178            ?           0    0    categories_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;
          public          postgres    false    177            ?            1259    336232    user_buy_animal_id_seq    SEQUENCE        CREATE SEQUENCE public.user_buy_animal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.user_buy_animal_id_seq;
       public          postgres    false    180            ?           0    0    user_buy_animal_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.user_buy_animal_id_seq OWNED BY public.user_buy_animal.id;
          public          postgres    false    179            ?            1259    336185    users    TABLE     ?   CREATE TABLE public.users (
    id integer NOT NULL,
    firstname character varying(50) NOT NULL,
    lastname character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    updated_at timestamp without time zone
);
    DROP TABLE public.users;
       public            postgres    false            ?            1259    336183    users_id_seq    SEQUENCE     u   CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    172            ?           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    171            ?            1259    336197    wallet    TABLE     m   CREATE TABLE public.wallet (
    id integer NOT NULL,
    user_id integer,
    user_sum integer DEFAULT 0
);
    DROP TABLE public.wallet;
       public            postgres    false            ?            1259    336195    wallet_id_seq    SEQUENCE     v   CREATE SEQUENCE public.wallet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.wallet_id_seq;
       public          postgres    false    174            ?           0    0    wallet_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.wallet_id_seq OWNED BY public.wallet.id;
          public          postgres    false    173            E           2604    336214 
   animals id    DEFAULT     h   ALTER TABLE ONLY public.animals ALTER COLUMN id SET DEFAULT nextval('public.animals_id_seq'::regclass);
 9   ALTER TABLE public.animals ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    176    175    176            H           2604    336224    categories id    DEFAULT     n   ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);
 <   ALTER TABLE public.categories ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    177    178    178            I           2604    336237    user_buy_animal id    DEFAULT     x   ALTER TABLE ONLY public.user_buy_animal ALTER COLUMN id SET DEFAULT nextval('public.user_buy_animal_id_seq'::regclass);
 A   ALTER TABLE public.user_buy_animal ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    180    179    180            B           2604    336188    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    171    172    172            C           2604    336200 	   wallet id    DEFAULT     f   ALTER TABLE ONLY public.wallet ALTER COLUMN id SET DEFAULT nextval('public.wallet_id_seq'::regclass);
 8   ALTER TABLE public.wallet ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    174    173    174            ?          0    336211    animals 
   TABLE DATA           D   COPY public.animals (id, name, age, price, description) FROM stdin;
    public          postgres    false    176   u?       ?          0    336254    audit 
   TABLE DATA           ;   COPY public.audit (user_id, entry_date, email) FROM stdin;
    public          postgres    false    181   @       ?          0    336221 
   categories 
   TABLE DATA           D   COPY public.categories (id, animal_id, animal_category) FROM stdin;
    public          postgres    false    178   W@       ?          0    336234    user_buy_animal 
   TABLE DATA           L   COPY public.user_buy_animal (id, user_id, animal_id, bought_at) FROM stdin;
    public          postgres    false    180   ?@       ?          0    336185    users 
   TABLE DATA           K   COPY public.users (id, firstname, lastname, email, updated_at) FROM stdin;
    public          postgres    false    172   ?@       ?          0    336197    wallet 
   TABLE DATA           7   COPY public.wallet (id, user_id, user_sum) FROM stdin;
    public          postgres    false    174   wA       ?           0    0    animals_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.animals_id_seq', 6, true);
          public          postgres    false    175            ?           0    0    categories_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.categories_id_seq', 6, true);
          public          postgres    false    177            ?           0    0    user_buy_animal_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.user_buy_animal_id_seq', 2, true);
          public          postgres    false    179            ?           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 7, true);
          public          postgres    false    171            ?           0    0    wallet_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.wallet_id_seq', 6, true);
          public          postgres    false    173            S           2606    336218    animals animals_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.animals
    ADD CONSTRAINT animals_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.animals DROP CONSTRAINT animals_pkey;
       public            postgres    false    176            U           2606    336226    categories categories_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public            postgres    false    178            W           2606    336239 $   user_buy_animal user_buy_animal_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.user_buy_animal
    ADD CONSTRAINT user_buy_animal_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.user_buy_animal DROP CONSTRAINT user_buy_animal_pkey;
       public            postgres    false    180            K           2606    336194    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    172            M           2606    336192    users users_lastname_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_lastname_key UNIQUE (lastname);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_lastname_key;
       public            postgres    false    172            O           2606    336190    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    172            Q           2606    336203    wallet wallet_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.wallet
    ADD CONSTRAINT wallet_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.wallet DROP CONSTRAINT wallet_pkey;
       public            postgres    false    174            ]           2620    336253    users audit_tr    TRIGGER     h   CREATE TRIGGER audit_tr AFTER INSERT ON public.users FOR EACH ROW EXECUTE PROCEDURE public.new_audit();
 '   DROP TRIGGER audit_tr ON public.users;
       public          postgres    false    172    196            \           2620    336251    users delete_audit_trigger    TRIGGER     x   CREATE TRIGGER delete_audit_trigger BEFORE DELETE ON public.users FOR EACH ROW EXECUTE PROCEDURE public.delete_audit();
 3   DROP TRIGGER delete_audit_trigger ON public.users;
       public          postgres    false    172    189            ^           2620    336258    users user_update_trigger    TRIGGER     v   CREATE TRIGGER user_update_trigger AFTER UPDATE ON public.users FOR EACH ROW EXECUTE PROCEDURE public.update_audit();
 2   DROP TRIGGER user_update_trigger ON public.users;
       public          postgres    false    172    197            Y           2606    336227 $   categories categories_animal_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_animal_id_fkey FOREIGN KEY (animal_id) REFERENCES public.animals(id);
 N   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_animal_id_fkey;
       public          postgres    false    178    1875    176            [           2606    336245 .   user_buy_animal user_buy_animal_animal_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.user_buy_animal
    ADD CONSTRAINT user_buy_animal_animal_id_fkey FOREIGN KEY (animal_id) REFERENCES public.animals(id);
 X   ALTER TABLE ONLY public.user_buy_animal DROP CONSTRAINT user_buy_animal_animal_id_fkey;
       public          postgres    false    1875    176    180            Z           2606    336240 ,   user_buy_animal user_buy_animal_user_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.user_buy_animal
    ADD CONSTRAINT user_buy_animal_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 V   ALTER TABLE ONLY public.user_buy_animal DROP CONSTRAINT user_buy_animal_user_id_fkey;
       public          postgres    false    1871    172    180            X           2606    336204    wallet wallet_user_id_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY public.wallet
    ADD CONSTRAINT wallet_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);
 D   ALTER TABLE ONLY public.wallet DROP CONSTRAINT wallet_user_id_fkey;
       public          postgres    false    174    172    1871            ?   ?   x?M?=
?@??y??H^v?,???&??ڤ?Xh!{???B@"z???????F?K?ǖ#{(4?????xr|??;?>|???O?##?????xh?`Q?+??x,?u??H o6n??? ?e???&G??N??}????DD??Cb      ?   0   x?3?4202?50?54S02?20?2??3?4?60?t,.???????? ?*      ?   /   x?3?4?t?O?2?4?tN,?2?4?&?&`ڔ?L?q???=... `
M      ?   )   x?3?4B###]C]C3#+c+C=3?=... h??      ?   ?   x?m?M?0?s?cvS???Ń??K?AJ?????M?җ?!?;0?1?ui???Xغ?3???=.J??m&?+???E??U-/?(?O?H?????\?e?? {?????]?k?"M(ik_#w?E???=?Z???2??????~U1      ?   1   x???  ??R?# ???^>q??ӂ?u?l?X]W7M?7???@     