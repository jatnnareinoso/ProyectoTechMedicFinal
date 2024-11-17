PGDMP  1    1            
    |        
   techmedicc    16.2    16.2 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    58423 
   techmedicc    DATABASE     �   CREATE DATABASE techmedicc WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Dominican Republic.1252';
    DROP DATABASE techmedicc;
                postgres    false            �            1255    66634    update_fecha_actualizacion()    FUNCTION     �   CREATE FUNCTION public.update_fecha_actualizacion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.fecha_actualizacion = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;
 3   DROP FUNCTION public.update_fecha_actualizacion();
       public          postgres    false            �            1259    58424    accesos    TABLE     4  CREATE TABLE public.accesos (
    id_acessos integer NOT NULL,
    modulo character varying(50),
    estado boolean DEFAULT true,
    id_especialidad integer,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.accesos;
       public         heap    postgres    false            �            1259    58428    accesos_id_acessos_seq    SEQUENCE     �   ALTER TABLE public.accesos ALTER COLUMN id_acessos ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.accesos_id_acessos_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    215            �            1259    58429    accesos_usuario    TABLE     z  CREATE TABLE public.accesos_usuario (
    id_accesos integer NOT NULL,
    id_usuario integer NOT NULL,
    estado boolean DEFAULT true,
    motivo character varying,
    id_acc_usuario integer NOT NULL,
    id_paciente integer,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
 #   DROP TABLE public.accesos_usuario;
       public         heap    postgres    false            �            1259    58435 "   accesos_usuario_id_acc_usuario_seq    SEQUENCE     �   ALTER TABLE public.accesos_usuario ALTER COLUMN id_acc_usuario ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.accesos_usuario_id_acc_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    217            �            1259    58436    asistente_doctor    TABLE     >  CREATE TABLE public.asistente_doctor (
    id_us_doc integer NOT NULL,
    id_usuario integer NOT NULL,
    id_doctor integer NOT NULL,
    estado boolean DEFAULT true,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
 $   DROP TABLE public.asistente_doctor;
       public         heap    postgres    false            �            1259    58440    asistente_doctor_id_us_doc_seq    SEQUENCE     �   ALTER TABLE public.asistente_doctor ALTER COLUMN id_us_doc ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.asistente_doctor_id_us_doc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    219            �            1259    58441    centro_medico    TABLE     d  CREATE TABLE public.centro_medico (
    id_centro_medico integer NOT NULL,
    centro_medico character varying(50) NOT NULL,
    observacion character varying(100),
    estado boolean DEFAULT true NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
 !   DROP TABLE public.centro_medico;
       public         heap    postgres    false            �            1259    58445 "   centro_medico_id_centro_medico_seq    SEQUENCE     �   ALTER TABLE public.centro_medico ALTER COLUMN id_centro_medico ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.centro_medico_id_centro_medico_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    221            �            1259    58446    cita    TABLE     �  CREATE TABLE public.cita (
    id_cita integer NOT NULL,
    id_paciente integer NOT NULL,
    id_doctor integer NOT NULL,
    id_centro_medico integer NOT NULL,
    id_usuario integer NOT NULL,
    fecha_hora timestamp with time zone,
    estado boolean,
    color character varying,
    id_tipo_consulta integer,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.cita;
       public         heap    postgres    false            �            1259    58451    cita_id_cita_seq    SEQUENCE     �   ALTER TABLE public.cita ALTER COLUMN id_cita ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cita_id_cita_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    223            �            1259    58452    consulta    TABLE       CREATE TABLE public.consulta (
    id_consulta integer NOT NULL,
    motivo character varying,
    descripcion character varying,
    fecha_hora timestamp with time zone,
    estado boolean,
    id_cita integer,
    notas_internas character varying(255),
    notas_externas character varying(255),
    pruebas character varying(255),
    id_especialidad integer,
    id_paciente integer,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.consulta;
       public         heap    postgres    false            �            1259    58457    consulta_id_consulta_seq    SEQUENCE     �   ALTER TABLE public.consulta ALTER COLUMN id_consulta ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.consulta_id_consulta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    225            �            1259    58458    diagnostico    TABLE     �  CREATE TABLE public.diagnostico (
    id_diagnostico integer NOT NULL,
    id_consulta integer NOT NULL,
    descripcion character varying,
    resultado_pruebas character varying,
    observacion character varying,
    estado boolean,
    archivos bytea[],
    ruta_archivos character varying,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.diagnostico;
       public         heap    postgres    false            �            1259    58463    diagnostico_id_diagnostico_seq    SEQUENCE     �   ALTER TABLE public.diagnostico ALTER COLUMN id_diagnostico ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.diagnostico_id_diagnostico_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    227            �            1259    58464    doctor    TABLE     N  CREATE TABLE public.doctor (
    id_doctor integer NOT NULL,
    id_usuario integer NOT NULL,
    exequatur numeric,
    observacion character varying,
    estado boolean DEFAULT true,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.doctor;
       public         heap    postgres    false            �            1259    66615    doctor_centro_medico    TABLE     S  CREATE TABLE public.doctor_centro_medico (
    id_doc_cent integer NOT NULL,
    id_doctor integer NOT NULL,
    id_centro_medico integer NOT NULL,
    estado boolean DEFAULT true NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
 (   DROP TABLE public.doctor_centro_medico;
       public         heap    postgres    false            �            1259    66631 $   doctor_centro_medico_id_doc_cent_seq    SEQUENCE     �   ALTER TABLE public.doctor_centro_medico ALTER COLUMN id_doc_cent ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.doctor_centro_medico_id_doc_cent_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999
    CACHE 1
);
            public          postgres    false    249            �            1259    58470    doctor_especialidad    TABLE     F  CREATE TABLE public.doctor_especialidad (
    id_us_esp integer NOT NULL,
    id_doctor integer NOT NULL,
    id_especialidad integer NOT NULL,
    estado boolean DEFAULT true,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
 '   DROP TABLE public.doctor_especialidad;
       public         heap    postgres    false            �            1259    58474 !   doctor_especialidad_id_us_esp_seq    SEQUENCE     �   ALTER TABLE public.doctor_especialidad ALTER COLUMN id_us_esp ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.doctor_especialidad_id_us_esp_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    230            �            1259    58475    doctor_id_doctor_seq    SEQUENCE     �   ALTER TABLE public.doctor ALTER COLUMN id_doctor ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.doctor_id_doctor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    229            �            1259    58476    especialidad    TABLE     F  CREATE TABLE public.especialidad (
    id_especialidad integer NOT NULL,
    especialidad character varying,
    descripcion character varying,
    estado boolean DEFAULT true,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
     DROP TABLE public.especialidad;
       public         heap    postgres    false            �            1259    58482     especialidad_id_especialidad_seq    SEQUENCE     �   ALTER TABLE public.especialidad ALTER COLUMN id_especialidad ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.especialidad_id_especialidad_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    233            �            1259    58483    notificaciones    TABLE     �  CREATE TABLE public.notificaciones (
    id_notificaciones integer NOT NULL,
    id_usuario integer NOT NULL,
    correo character varying,
    fecha_envio timestamp with time zone,
    contenido character varying,
    estado boolean DEFAULT true,
    id_destinatario integer,
    tipo_destinatario character varying,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
 "   DROP TABLE public.notificaciones;
       public         heap    postgres    false            �            1259    58489 $   notificaciones_id_notificaciones_seq    SEQUENCE     �   ALTER TABLE public.notificaciones ALTER COLUMN id_notificaciones ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.notificaciones_id_notificaciones_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    235            �            1259    58490    paciente    TABLE       CREATE TABLE public.paciente (
    id_paciente integer NOT NULL,
    nombre character varying(50),
    apellido character varying(50),
    cedula character varying(20),
    fecha_nacimiento date,
    correo character varying(30),
    sexo character varying(15),
    telefono numeric(15,0),
    nacionalidad character varying(30),
    ciudad character varying(30),
    direccion character varying(100),
    menor boolean,
    observacion character varying(100),
    nombre_familiar character varying(50),
    cedula_familiar character varying(20),
    correo_familiar character varying(30),
    telefono_familiar character varying(15),
    celular_familiar character varying(15),
    estado boolean DEFAULT true,
    celular character varying,
    peso character varying,
    altura character varying,
    alergia character varying,
    enfermedad character varying,
    sustancia character varying,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.paciente;
       public         heap    postgres    false            �            1259    58496    paciente_id_paciente_seq    SEQUENCE     �   ALTER TABLE public.paciente ALTER COLUMN id_paciente ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.paciente_id_paciente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    237            �            1259    58497    receta    TABLE       CREATE TABLE public.receta (
    id_receta integer NOT NULL,
    medicamento character varying,
    cantidad character varying,
    frecuencia character varying,
    tiempo character varying,
    fecha_receta date,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    uso character varying,
    observacion character varying(100),
    estado boolean DEFAULT true,
    id_paciente integer NOT NULL,
    id_doctor integer NOT NULL
);
    DROP TABLE public.receta;
       public         heap    postgres    false            �            1259    58502    receta_id_receta_seq    SEQUENCE     �   ALTER TABLE public.receta ALTER COLUMN id_receta ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.receta_id_receta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    239            �            1259    58503    tipo_consulta    TABLE     D  CREATE TABLE public.tipo_consulta (
    id_tipo_consulta integer NOT NULL,
    consulta character varying,
    descripcion character varying,
    estado boolean DEFAULT true,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
 !   DROP TABLE public.tipo_consulta;
       public         heap    postgres    false            �            1259    58509 "   tipo_consulta_id_tipo_consulta_seq    SEQUENCE     �   ALTER TABLE public.tipo_consulta ALTER COLUMN id_tipo_consulta ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tipo_consulta_id_tipo_consulta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    241            �            1259    58510    tipo_usuario    TABLE     "  CREATE TABLE public.tipo_usuario (
    id_tipo_usuario integer NOT NULL,
    usuario character varying(50),
    estado boolean DEFAULT true,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
     DROP TABLE public.tipo_usuario;
       public         heap    postgres    false            �            1259    58514     tipo_usuario_id_tipo_usuario_seq    SEQUENCE     �   ALTER TABLE public.tipo_usuario ALTER COLUMN id_tipo_usuario ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tipo_usuario_id_tipo_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    243            �            1259    58515    usuario    TABLE     J  CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    id_tipo_usuario integer NOT NULL,
    nombre character varying,
    apellido character varying,
    cedula character varying,
    fecha_nacimiento date,
    sexo character varying,
    correo character varying,
    password character varying,
    usuario character varying,
    estado boolean DEFAULT true,
    celular character varying,
    telefono character varying,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.usuario;
       public         heap    postgres    false            �            1259    58521    usuario_centro_medico    TABLE     K  CREATE TABLE public.usuario_centro_medico (
    id_us_cent integer NOT NULL,
    id_usuario integer NOT NULL,
    id_centro_medico integer NOT NULL,
    estado boolean DEFAULT true,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
 )   DROP TABLE public.usuario_centro_medico;
       public         heap    postgres    false            �            1259    58525 $   usuario_centro_medico_id_us_cent_seq    SEQUENCE     �   ALTER TABLE public.usuario_centro_medico ALTER COLUMN id_us_cent ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.usuario_centro_medico_id_us_cent_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    246            �            1259    58526    usuario_id_usuario_seq    SEQUENCE     �   ALTER TABLE public.usuario ALTER COLUMN id_usuario ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.usuario_id_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    245            �          0    58424    accesos 
   TABLE DATA           s   COPY public.accesos (id_acessos, modulo, estado, id_especialidad, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    215   �       �          0    58429    accesos_usuario 
   TABLE DATA           �   COPY public.accesos_usuario (id_accesos, id_usuario, estado, motivo, id_acc_usuario, id_paciente, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    217   5�       �          0    58436    asistente_doctor 
   TABLE DATA           y   COPY public.asistente_doctor (id_us_doc, id_usuario, id_doctor, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    219   Q�       �          0    58441    centro_medico 
   TABLE DATA           �   COPY public.centro_medico (id_centro_medico, centro_medico, observacion, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    221   �       �          0    58446    cita 
   TABLE DATA           �   COPY public.cita (id_cita, id_paciente, id_doctor, id_centro_medico, id_usuario, fecha_hora, estado, color, id_tipo_consulta, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    223   ��       �          0    58452    consulta 
   TABLE DATA           �   COPY public.consulta (id_consulta, motivo, descripcion, fecha_hora, estado, id_cita, notas_internas, notas_externas, pruebas, id_especialidad, id_paciente, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    225   ��       �          0    58458    diagnostico 
   TABLE DATA           �   COPY public.diagnostico (id_diagnostico, id_consulta, descripcion, resultado_pruebas, observacion, estado, archivos, ruta_archivos, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    227   ��       �          0    58464    doctor 
   TABLE DATA           |   COPY public.doctor (id_doctor, id_usuario, exequatur, observacion, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    229   ��       �          0    66615    doctor_centro_medico 
   TABLE DATA           �   COPY public.doctor_centro_medico (id_doc_cent, id_doctor, id_centro_medico, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    249   4�       �          0    58470    doctor_especialidad 
   TABLE DATA           �   COPY public.doctor_especialidad (id_us_esp, id_doctor, id_especialidad, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    230   z�       �          0    58476    especialidad 
   TABLE DATA              COPY public.especialidad (id_especialidad, especialidad, descripcion, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    233   ��       �          0    58483    notificaciones 
   TABLE DATA           �   COPY public.notificaciones (id_notificaciones, id_usuario, correo, fecha_envio, contenido, estado, id_destinatario, tipo_destinatario, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    235   Y�       �          0    58490    paciente 
   TABLE DATA           d  COPY public.paciente (id_paciente, nombre, apellido, cedula, fecha_nacimiento, correo, sexo, telefono, nacionalidad, ciudad, direccion, menor, observacion, nombre_familiar, cedula_familiar, correo_familiar, telefono_familiar, celular_familiar, estado, celular, peso, altura, alergia, enfermedad, sustancia, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    237   "�       �          0    58497    receta 
   TABLE DATA           �   COPY public.receta (id_receta, medicamento, cantidad, frecuencia, tiempo, fecha_receta, fecha_creacion, fecha_actualizacion, uso, observacion, estado, id_paciente, id_doctor) FROM stdin;
    public          postgres    false    239   M�       �          0    58503    tipo_consulta 
   TABLE DATA           }   COPY public.tipo_consulta (id_tipo_consulta, consulta, descripcion, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    241   ��       �          0    58510    tipo_usuario 
   TABLE DATA           m   COPY public.tipo_usuario (id_tipo_usuario, usuario, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    243   r�       �          0    58515    usuario 
   TABLE DATA           �   COPY public.usuario (id_usuario, id_tipo_usuario, nombre, apellido, cedula, fecha_nacimiento, sexo, correo, password, usuario, estado, celular, telefono, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    245   ��       �          0    58521    usuario_centro_medico 
   TABLE DATA           �   COPY public.usuario_centro_medico (id_us_cent, id_usuario, id_centro_medico, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    246   ��       �           0    0    accesos_id_acessos_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.accesos_id_acessos_seq', 18, true);
          public          postgres    false    216            �           0    0 "   accesos_usuario_id_acc_usuario_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.accesos_usuario_id_acc_usuario_seq', 15, true);
          public          postgres    false    218            �           0    0    asistente_doctor_id_us_doc_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.asistente_doctor_id_us_doc_seq', 40, true);
          public          postgres    false    220            �           0    0 "   centro_medico_id_centro_medico_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.centro_medico_id_centro_medico_seq', 2, true);
          public          postgres    false    222            �           0    0    cita_id_cita_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.cita_id_cita_seq', 71, true);
          public          postgres    false    224            �           0    0    consulta_id_consulta_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.consulta_id_consulta_seq', 23, true);
          public          postgres    false    226            �           0    0    diagnostico_id_diagnostico_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.diagnostico_id_diagnostico_seq', 11, true);
          public          postgres    false    228            �           0    0 $   doctor_centro_medico_id_doc_cent_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.doctor_centro_medico_id_doc_cent_seq', 2, true);
          public          postgres    false    250            �           0    0 !   doctor_especialidad_id_us_esp_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.doctor_especialidad_id_us_esp_seq', 210, true);
          public          postgres    false    231            �           0    0    doctor_id_doctor_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.doctor_id_doctor_seq', 45, true);
          public          postgres    false    232            �           0    0     especialidad_id_especialidad_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.especialidad_id_especialidad_seq', 19, true);
          public          postgres    false    234            �           0    0 $   notificaciones_id_notificaciones_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.notificaciones_id_notificaciones_seq', 11, true);
          public          postgres    false    236            �           0    0    paciente_id_paciente_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.paciente_id_paciente_seq', 13, true);
          public          postgres    false    238            �           0    0    receta_id_receta_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.receta_id_receta_seq', 49, true);
          public          postgres    false    240            �           0    0 "   tipo_consulta_id_tipo_consulta_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.tipo_consulta_id_tipo_consulta_seq', 3, true);
          public          postgres    false    242            �           0    0     tipo_usuario_id_tipo_usuario_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.tipo_usuario_id_tipo_usuario_seq', 3, true);
          public          postgres    false    244            �           0    0 $   usuario_centro_medico_id_us_cent_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.usuario_centro_medico_id_us_cent_seq', 3, true);
          public          postgres    false    247            �           0    0    usuario_id_usuario_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 67, true);
          public          postgres    false    248            �           2606    58528    accesos accesos_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.accesos
    ADD CONSTRAINT accesos_pkey PRIMARY KEY (id_acessos);
 >   ALTER TABLE ONLY public.accesos DROP CONSTRAINT accesos_pkey;
       public            postgres    false    215            �           2606    58530 "   accesos_usuario accesos_usuario_pk 
   CONSTRAINT     l   ALTER TABLE ONLY public.accesos_usuario
    ADD CONSTRAINT accesos_usuario_pk PRIMARY KEY (id_acc_usuario);
 L   ALTER TABLE ONLY public.accesos_usuario DROP CONSTRAINT accesos_usuario_pk;
       public            postgres    false    217            �           2606    58532 &   asistente_doctor asistente_doctor_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.asistente_doctor
    ADD CONSTRAINT asistente_doctor_pkey PRIMARY KEY (id_us_doc);
 P   ALTER TABLE ONLY public.asistente_doctor DROP CONSTRAINT asistente_doctor_pkey;
       public            postgres    false    219            �           2606    58534     centro_medico centro_medico_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.centro_medico
    ADD CONSTRAINT centro_medico_pkey PRIMARY KEY (id_centro_medico);
 J   ALTER TABLE ONLY public.centro_medico DROP CONSTRAINT centro_medico_pkey;
       public            postgres    false    221            �           2606    58536    cita cita_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.cita
    ADD CONSTRAINT cita_pkey PRIMARY KEY (id_cita);
 8   ALTER TABLE ONLY public.cita DROP CONSTRAINT cita_pkey;
       public            postgres    false    223            �           2606    58538    consulta consulta_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT consulta_pkey PRIMARY KEY (id_consulta);
 @   ALTER TABLE ONLY public.consulta DROP CONSTRAINT consulta_pkey;
       public            postgres    false    225            �           2606    58540    diagnostico diagnostico_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.diagnostico
    ADD CONSTRAINT diagnostico_pkey PRIMARY KEY (id_diagnostico);
 F   ALTER TABLE ONLY public.diagnostico DROP CONSTRAINT diagnostico_pkey;
       public            postgres    false    227            �           2606    66620 .   doctor_centro_medico doctor_centro_medico_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public.doctor_centro_medico
    ADD CONSTRAINT doctor_centro_medico_pkey PRIMARY KEY (id_doc_cent);
 X   ALTER TABLE ONLY public.doctor_centro_medico DROP CONSTRAINT doctor_centro_medico_pkey;
       public            postgres    false    249            �           2606    58542 ,   doctor_especialidad doctor_especialidad_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.doctor_especialidad
    ADD CONSTRAINT doctor_especialidad_pkey PRIMARY KEY (id_us_esp);
 V   ALTER TABLE ONLY public.doctor_especialidad DROP CONSTRAINT doctor_especialidad_pkey;
       public            postgres    false    230            �           2606    58544    doctor doctor_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_pkey PRIMARY KEY (id_doctor);
 <   ALTER TABLE ONLY public.doctor DROP CONSTRAINT doctor_pkey;
       public            postgres    false    229            �           2606    58546    especialidad especialidad_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.especialidad
    ADD CONSTRAINT especialidad_pkey PRIMARY KEY (id_especialidad);
 H   ALTER TABLE ONLY public.especialidad DROP CONSTRAINT especialidad_pkey;
       public            postgres    false    233            �           2606    58548 "   notificaciones notificaciones_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.notificaciones
    ADD CONSTRAINT notificaciones_pkey PRIMARY KEY (id_notificaciones);
 L   ALTER TABLE ONLY public.notificaciones DROP CONSTRAINT notificaciones_pkey;
       public            postgres    false    235            �           2606    58550    paciente paciente_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.paciente
    ADD CONSTRAINT paciente_pkey PRIMARY KEY (id_paciente);
 @   ALTER TABLE ONLY public.paciente DROP CONSTRAINT paciente_pkey;
       public            postgres    false    237            �           2606    58552    receta receta_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.receta
    ADD CONSTRAINT receta_pkey PRIMARY KEY (id_receta);
 <   ALTER TABLE ONLY public.receta DROP CONSTRAINT receta_pkey;
       public            postgres    false    239            �           2606    58554     tipo_consulta tipo_consulta_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.tipo_consulta
    ADD CONSTRAINT tipo_consulta_pkey PRIMARY KEY (id_tipo_consulta);
 J   ALTER TABLE ONLY public.tipo_consulta DROP CONSTRAINT tipo_consulta_pkey;
       public            postgres    false    241            �           2606    58556    tipo_usuario tipo_usuario_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.tipo_usuario
    ADD CONSTRAINT tipo_usuario_pkey PRIMARY KEY (id_tipo_usuario);
 H   ALTER TABLE ONLY public.tipo_usuario DROP CONSTRAINT tipo_usuario_pkey;
       public            postgres    false    243            �           2606    58558 0   usuario_centro_medico usuario_centro_medico_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.usuario_centro_medico
    ADD CONSTRAINT usuario_centro_medico_pkey PRIMARY KEY (id_us_cent);
 Z   ALTER TABLE ONLY public.usuario_centro_medico DROP CONSTRAINT usuario_centro_medico_pkey;
       public            postgres    false    246            �           2606    58560    usuario usuario_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public            postgres    false    245                       2620    66685    accesos set_fecha_actualizacion    TRIGGER     �   CREATE TRIGGER set_fecha_actualizacion BEFORE UPDATE ON public.accesos FOR EACH ROW EXECUTE FUNCTION public.update_fecha_actualizacion();
 8   DROP TRIGGER set_fecha_actualizacion ON public.accesos;
       public          postgres    false    215    251                       2620    66682 '   accesos_usuario set_fecha_actualizacion    TRIGGER     �   CREATE TRIGGER set_fecha_actualizacion BEFORE UPDATE ON public.accesos_usuario FOR EACH ROW EXECUTE FUNCTION public.update_fecha_actualizacion();
 @   DROP TRIGGER set_fecha_actualizacion ON public.accesos_usuario;
       public          postgres    false    217    251                       2620    66679 (   asistente_doctor set_fecha_actualizacion    TRIGGER     �   CREATE TRIGGER set_fecha_actualizacion BEFORE UPDATE ON public.asistente_doctor FOR EACH ROW EXECUTE FUNCTION public.update_fecha_actualizacion();
 A   DROP TRIGGER set_fecha_actualizacion ON public.asistente_doctor;
       public          postgres    false    219    251                       2620    66676 %   centro_medico set_fecha_actualizacion    TRIGGER     �   CREATE TRIGGER set_fecha_actualizacion BEFORE UPDATE ON public.centro_medico FOR EACH ROW EXECUTE FUNCTION public.update_fecha_actualizacion();
 >   DROP TRIGGER set_fecha_actualizacion ON public.centro_medico;
       public          postgres    false    221    251                       2620    66673    cita set_fecha_actualizacion    TRIGGER     �   CREATE TRIGGER set_fecha_actualizacion BEFORE UPDATE ON public.cita FOR EACH ROW EXECUTE FUNCTION public.update_fecha_actualizacion();
 5   DROP TRIGGER set_fecha_actualizacion ON public.cita;
       public          postgres    false    251    223                       2620    66670     consulta set_fecha_actualizacion    TRIGGER     �   CREATE TRIGGER set_fecha_actualizacion BEFORE UPDATE ON public.consulta FOR EACH ROW EXECUTE FUNCTION public.update_fecha_actualizacion();
 9   DROP TRIGGER set_fecha_actualizacion ON public.consulta;
       public          postgres    false    251    225                       2620    66667 #   diagnostico set_fecha_actualizacion    TRIGGER     �   CREATE TRIGGER set_fecha_actualizacion BEFORE UPDATE ON public.diagnostico FOR EACH ROW EXECUTE FUNCTION public.update_fecha_actualizacion();
 <   DROP TRIGGER set_fecha_actualizacion ON public.diagnostico;
       public          postgres    false    251    227                       2620    66664    doctor set_fecha_actualizacion    TRIGGER     �   CREATE TRIGGER set_fecha_actualizacion BEFORE UPDATE ON public.doctor FOR EACH ROW EXECUTE FUNCTION public.update_fecha_actualizacion();
 7   DROP TRIGGER set_fecha_actualizacion ON public.doctor;
       public          postgres    false    229    251            %           2620    66688 ,   doctor_centro_medico set_fecha_actualizacion    TRIGGER     �   CREATE TRIGGER set_fecha_actualizacion BEFORE UPDATE ON public.doctor_centro_medico FOR EACH ROW EXECUTE FUNCTION public.update_fecha_actualizacion();
 E   DROP TRIGGER set_fecha_actualizacion ON public.doctor_centro_medico;
       public          postgres    false    249    251                       2620    66661 +   doctor_especialidad set_fecha_actualizacion    TRIGGER     �   CREATE TRIGGER set_fecha_actualizacion BEFORE UPDATE ON public.doctor_especialidad FOR EACH ROW EXECUTE FUNCTION public.update_fecha_actualizacion();
 D   DROP TRIGGER set_fecha_actualizacion ON public.doctor_especialidad;
       public          postgres    false    230    251                       2620    66658 $   especialidad set_fecha_actualizacion    TRIGGER     �   CREATE TRIGGER set_fecha_actualizacion BEFORE UPDATE ON public.especialidad FOR EACH ROW EXECUTE FUNCTION public.update_fecha_actualizacion();
 =   DROP TRIGGER set_fecha_actualizacion ON public.especialidad;
       public          postgres    false    233    251                       2620    66655 &   notificaciones set_fecha_actualizacion    TRIGGER     �   CREATE TRIGGER set_fecha_actualizacion BEFORE UPDATE ON public.notificaciones FOR EACH ROW EXECUTE FUNCTION public.update_fecha_actualizacion();
 ?   DROP TRIGGER set_fecha_actualizacion ON public.notificaciones;
       public          postgres    false    251    235                       2620    66652     paciente set_fecha_actualizacion    TRIGGER     �   CREATE TRIGGER set_fecha_actualizacion BEFORE UPDATE ON public.paciente FOR EACH ROW EXECUTE FUNCTION public.update_fecha_actualizacion();
 9   DROP TRIGGER set_fecha_actualizacion ON public.paciente;
       public          postgres    false    237    251                        2620    66649    receta set_fecha_actualizacion    TRIGGER     �   CREATE TRIGGER set_fecha_actualizacion BEFORE UPDATE ON public.receta FOR EACH ROW EXECUTE FUNCTION public.update_fecha_actualizacion();
 7   DROP TRIGGER set_fecha_actualizacion ON public.receta;
       public          postgres    false    251    239            !           2620    66646 %   tipo_consulta set_fecha_actualizacion    TRIGGER     �   CREATE TRIGGER set_fecha_actualizacion BEFORE UPDATE ON public.tipo_consulta FOR EACH ROW EXECUTE FUNCTION public.update_fecha_actualizacion();
 >   DROP TRIGGER set_fecha_actualizacion ON public.tipo_consulta;
       public          postgres    false    251    241            "           2620    66643 $   tipo_usuario set_fecha_actualizacion    TRIGGER     �   CREATE TRIGGER set_fecha_actualizacion BEFORE UPDATE ON public.tipo_usuario FOR EACH ROW EXECUTE FUNCTION public.update_fecha_actualizacion();
 =   DROP TRIGGER set_fecha_actualizacion ON public.tipo_usuario;
       public          postgres    false    243    251            #           2620    66635    usuario set_fecha_actualizacion    TRIGGER     �   CREATE TRIGGER set_fecha_actualizacion BEFORE UPDATE ON public.usuario FOR EACH ROW EXECUTE FUNCTION public.update_fecha_actualizacion();
 8   DROP TRIGGER set_fecha_actualizacion ON public.usuario;
       public          postgres    false    245    251            $           2620    66640 -   usuario_centro_medico set_fecha_actualizacion    TRIGGER     �   CREATE TRIGGER set_fecha_actualizacion BEFORE UPDATE ON public.usuario_centro_medico FOR EACH ROW EXECUTE FUNCTION public.update_fecha_actualizacion();
 F   DROP TRIGGER set_fecha_actualizacion ON public.usuario_centro_medico;
       public          postgres    false    246    251                       2606    58561    consulta consulta_id_cita_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT consulta_id_cita_fkey FOREIGN KEY (id_cita) REFERENCES public.cita(id_cita);
 H   ALTER TABLE ONLY public.consulta DROP CONSTRAINT consulta_id_cita_fkey;
       public          postgres    false    223    4834    225            �           2606    58566    accesos fk_especialidad    FK CONSTRAINT     �   ALTER TABLE ONLY public.accesos
    ADD CONSTRAINT fk_especialidad FOREIGN KEY (id_especialidad) REFERENCES public.especialidad(id_especialidad);
 A   ALTER TABLE ONLY public.accesos DROP CONSTRAINT fk_especialidad;
       public          postgres    false    4844    215    233                       2606    66695    receta fk_id_doctor    FK CONSTRAINT     �   ALTER TABLE ONLY public.receta
    ADD CONSTRAINT fk_id_doctor FOREIGN KEY (id_doctor) REFERENCES public.doctor(id_doctor) ON DELETE CASCADE;
 =   ALTER TABLE ONLY public.receta DROP CONSTRAINT fk_id_doctor;
       public          postgres    false    229    4840    239                       2606    66690    receta fk_id_paciente    FK CONSTRAINT     �   ALTER TABLE ONLY public.receta
    ADD CONSTRAINT fk_id_paciente FOREIGN KEY (id_paciente) REFERENCES public.paciente(id_paciente) ON DELETE CASCADE;
 ?   ALTER TABLE ONLY public.receta DROP CONSTRAINT fk_id_paciente;
       public          postgres    false    237    239    4848                       2606    58571    cita fk_tipo_consulta    FK CONSTRAINT     �   ALTER TABLE ONLY public.cita
    ADD CONSTRAINT fk_tipo_consulta FOREIGN KEY (id_tipo_consulta) REFERENCES public.tipo_consulta(id_tipo_consulta);
 ?   ALTER TABLE ONLY public.cita DROP CONSTRAINT fk_tipo_consulta;
       public          postgres    false    223    241    4852            �           2606    58576    accesos_usuario id_accesos_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.accesos_usuario
    ADD CONSTRAINT id_accesos_pk FOREIGN KEY (id_accesos) REFERENCES public.accesos(id_acessos);
 G   ALTER TABLE ONLY public.accesos_usuario DROP CONSTRAINT id_accesos_pk;
       public          postgres    false    217    215    4826                       2606    66626 %   doctor_centro_medico id_centro_medico    FK CONSTRAINT     �   ALTER TABLE ONLY public.doctor_centro_medico
    ADD CONSTRAINT id_centro_medico FOREIGN KEY (id_centro_medico) REFERENCES public.centro_medico(id_centro_medico);
 O   ALTER TABLE ONLY public.doctor_centro_medico DROP CONSTRAINT id_centro_medico;
       public          postgres    false    221    249    4832                       2606    58591 )   usuario_centro_medico id_centro_medico_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_centro_medico
    ADD CONSTRAINT id_centro_medico_pk FOREIGN KEY (id_centro_medico) REFERENCES public.centro_medico(id_centro_medico);
 S   ALTER TABLE ONLY public.usuario_centro_medico DROP CONSTRAINT id_centro_medico_pk;
       public          postgres    false    4832    221    246                       2606    58596    cita id_centro_medico_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.cita
    ADD CONSTRAINT id_centro_medico_pk FOREIGN KEY (id_centro_medico) REFERENCES public.centro_medico(id_centro_medico);
 B   ALTER TABLE ONLY public.cita DROP CONSTRAINT id_centro_medico_pk;
       public          postgres    false    223    221    4832                       2606    58601    diagnostico id_consulta_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.diagnostico
    ADD CONSTRAINT id_consulta_pk FOREIGN KEY (id_consulta) REFERENCES public.consulta(id_consulta);
 D   ALTER TABLE ONLY public.diagnostico DROP CONSTRAINT id_consulta_pk;
       public          postgres    false    225    227    4836                       2606    66621    doctor_centro_medico id_doctor    FK CONSTRAINT     �   ALTER TABLE ONLY public.doctor_centro_medico
    ADD CONSTRAINT id_doctor FOREIGN KEY (id_doctor) REFERENCES public.doctor(id_doctor);
 H   ALTER TABLE ONLY public.doctor_centro_medico DROP CONSTRAINT id_doctor;
       public          postgres    false    249    4840    229                        2606    58611    asistente_doctor id_doctor_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.asistente_doctor
    ADD CONSTRAINT id_doctor_fk FOREIGN KEY (id_doctor) REFERENCES public.doctor(id_doctor);
 G   ALTER TABLE ONLY public.asistente_doctor DROP CONSTRAINT id_doctor_fk;
       public          postgres    false    229    219    4840                       2606    58616    cita id_doctor_pk    FK CONSTRAINT     z   ALTER TABLE ONLY public.cita
    ADD CONSTRAINT id_doctor_pk FOREIGN KEY (id_doctor) REFERENCES public.doctor(id_doctor);
 ;   ALTER TABLE ONLY public.cita DROP CONSTRAINT id_doctor_pk;
       public          postgres    false    223    4840    229            
           2606    58621     doctor_especialidad id_doctor_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.doctor_especialidad
    ADD CONSTRAINT id_doctor_pk FOREIGN KEY (id_doctor) REFERENCES public.doctor(id_doctor);
 J   ALTER TABLE ONLY public.doctor_especialidad DROP CONSTRAINT id_doctor_pk;
       public          postgres    false    230    4840    229                       2606    58626 &   doctor_especialidad id_especialidad_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.doctor_especialidad
    ADD CONSTRAINT id_especialidad_pk FOREIGN KEY (id_especialidad) REFERENCES public.especialidad(id_especialidad);
 P   ALTER TABLE ONLY public.doctor_especialidad DROP CONSTRAINT id_especialidad_pk;
       public          postgres    false    230    233    4844                       2606    58631    cita id_paciente_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.cita
    ADD CONSTRAINT id_paciente_pk FOREIGN KEY (id_paciente) REFERENCES public.paciente(id_paciente);
 =   ALTER TABLE ONLY public.cita DROP CONSTRAINT id_paciente_pk;
       public          postgres    false    4848    237    223                       2606    58636    usuario id_tipo_usuario_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT id_tipo_usuario_pk FOREIGN KEY (id_tipo_usuario) REFERENCES public.tipo_usuario(id_tipo_usuario);
 D   ALTER TABLE ONLY public.usuario DROP CONSTRAINT id_tipo_usuario_pk;
       public          postgres    false    4854    245    243            	           2606    58641    doctor id_usuario    FK CONSTRAINT     }   ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT id_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);
 ;   ALTER TABLE ONLY public.doctor DROP CONSTRAINT id_usuario;
       public          postgres    false    229    4856    245                       2606    58646    asistente_doctor id_usuario_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.asistente_doctor
    ADD CONSTRAINT id_usuario_fk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);
 H   ALTER TABLE ONLY public.asistente_doctor DROP CONSTRAINT id_usuario_fk;
       public          postgres    false    4856    245    219                       2606    58651 #   usuario_centro_medico id_usuario_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_centro_medico
    ADD CONSTRAINT id_usuario_pk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);
 M   ALTER TABLE ONLY public.usuario_centro_medico DROP CONSTRAINT id_usuario_pk;
       public          postgres    false    246    245    4856            �           2606    58656    accesos_usuario id_usuario_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.accesos_usuario
    ADD CONSTRAINT id_usuario_pk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);
 G   ALTER TABLE ONLY public.accesos_usuario DROP CONSTRAINT id_usuario_pk;
       public          postgres    false    4856    217    245                       2606    58661    cita id_usuario_pk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.cita
    ADD CONSTRAINT id_usuario_pk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);
 <   ALTER TABLE ONLY public.cita DROP CONSTRAINT id_usuario_pk;
       public          postgres    false    223    245    4856                       2606    58666    notificaciones id_usuario_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.notificaciones
    ADD CONSTRAINT id_usuario_pk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);
 F   ALTER TABLE ONLY public.notificaciones DROP CONSTRAINT id_usuario_pk;
       public          postgres    false    245    4856    235            �     x���KN�0����@���WwJV%;6S�E�R�8΂Cq
.�[�bV,fm�����������'��p���(�@ /�,+�:�|+�VV�J�FtE��i&��h~��I'�A�3�իH^�ټ/���ZW�`�z���5����6h���$�-���76!��`8��	�I`���&�U0�{�˟�0Zc�;���I���1�A�k�/(a5e,潶��t�"ͬ�I/ɿ44.��r���5�7ʻ��C\��/��-4Qn���Iƚ���u�e�7��>"      �     x���An� E��)�@"29ĨȆ&N�4 =ͤҨU�d�����BA�=�w����n�҅[��ngo0���������$�$u7�6����i3�����,��"�,�J��]a=���}�u-_��0_!�v\��}�TR�����.��'�,N�q8�#�-D����~��dt%Q�7?M<���HE�m�FIE����mF
[iy�Q��Ͳ�a���6җ��+.���'FRZ�;i��s_ø�����F����6s�4��4ѵ      �   �   x����1�3�"���[K�H�
�m�(�9���T0.Ѯ� �/��p���5��n��� 6X&l�ɉr.VY��Y��e�Ln�g��dPLb$�7�,��6�5b�jLKa�d.���x��,���_�,������'f`���6ۥR�'���Z�o�      �      x�3�t�9�6/39Q�)1�J!8�$_AM��� 5931'3%1%���/3/�4/�������D��P��L��������@������H���,��sj^IQ����)���
a
 �ԼĢ�|�`=G*����� ��6�      �   �   x���KN�@D��S�c��9'�&@�	Y����$��K��SuWBs`dMD	�'-�1�����>N��yz^t�3��4��ι�����#(Я�0I ��<���n� ĠRq���8�X�䘢�R{�B��4�_n�qƇ5g��m4'��B�������UR1�VQr�_���l�f%׌������f��e�d�Mٸ�k)��.�����R�O�?�(ℵ���H�I���� ��&      �   +  x����r� ���)��%ۺuڦ�L��49�%�0�@���mz졧>�_�QbYV�vl{ƀi���G��vҵ�Ce�u�_B)V�Q@��S�����5�*�旁z�����n�d����
݊n�>�#כ�������od=xY#|B8�FO�8-ؼH�IJ�������Z���ת�|�H�����)�*����ur%�pck{��z�S��2�����EJ��'|6�,&�׫G��S%WH��ED�@�TR3^Y��q��Qa;,"{�-F�9do���rv%Le�PS
�|QP�4���a���P~ �����Ī��2B��:#z-��0˶Is�~t�qb	����5��EW����R���:%����r�=� JkZe:�.!�P��p�ђ9~�eF>hhD�B��e,4H�3�nԶD�d{e�De+�`��w�\��n�)��ߕ��xٲH�eɂ����m�����;#����9uRG#t�RZ�R�v��n}�W��kiD�|[�Ui��)LM��`�~g�M��ȖSy����\��gQ�HQ!�~�o٪�9a��kmz��6�^8o0G��I,F���$�U�6H{pXmM�_�x�$�#ý�853ҏ3
�Ԭ��'|�B�lBȂ1�E��I�쵝���S���1�+� q-��R�O�}� ���K�4r��wҷ9Z��ǰ�g�1p�ݡ�?9v�����@O�=Z,��X��eOk���I�T�i�*�3V�6}�ɳ���p���ȷ�(Q����e�0'��Wc<��x��&GGG�b��(      �   �   x�}��N�0�g�)�:7!v�e+b�*D�(�m|�ڑ*�8��<B^K ��t��}:GJ�q�0bo�F��l�O�4`4����
d<���؁�1g���/�͓��Y>�;�N06z�Ӈ?���H!qD�:��̊��KLYҙ��;�R�3���i{cI;�+lz�b
�XxE�GʻQv�y�Fv�Í\5�Z6�Uj�.�t�V���{��A쑓�F}��U�������T��]+��B��4��š*���_m�      �   A  x����q1D�*����!tE��_���q�'"=ݼA�.(��)���R}I|���cz�MQ���?�T�1��$3F�5�Z���fc!Mx�rA\h����ؖ��51Z���d�b�(W�h�$a06�>�Q�7�S�����*��/����i-�	SX�G,`!&�7X��X��/�ffCae�ؾ����_�S�(�W��-�D�l�d���6ْ��Pc'j�rv�ƴSP����2�o7P[{G{��Uӡʞ䆚��,i�"r�����&�;�z%!}�S��%��=.�Q���4�&��������Ф      �   6   x�3�41�4�,�4202�54�50W00�26�21�362074�50�/����� ��L      �     x����m�0�3U�6`�?Q�k�2�?2��A.s6�@)J�R��#���٥�rB;�-�yi��q��M�i�3RL�:�%���Cb�F�Afz��}qUI�!.�� W2Vd�I"1b�%F��u��f�@��f�A�1{8H �A�H$iL,��22���Bׁ!e�(��d�h�ˣ��qe,�+�������qd�I1�F%oøH��`��6�T�����?����v���h���	d�F�`_ GpU}��z�>��{�V}!|������(�)�      �   �  x��W�n�8=+_�p�I�Mo�n7X��[�m/cj�0�H�$�c9����J�#�I�PN�Lq8oޛ��qqnko��y u�.f��:m�����$U���"�T����ˤk�����5�#e���]�[�Ռ����,)��4�pͷX-�ԁj�;�# �9��K*9�ݪh�REۓ}Ps��珊����'�����TM�����gG�ӷg������Ճ��w
���⒁����$ns����=�5�\�i��6A'K���#�W[�=�+r|��j�J��;�վ���,9��A���L]�p�O	xG+C���a�tW�ϙ�	~�0��Ұ)M3�Vv��+���5i��C)�V�x���43���2�/�P�R���	2r/�I���#"X�b�	u�2p'� ���o�<@��n_��*�!�Ŝ�P�gŅӏ9\C��_DB�͝�zD!����-�T�r��{�ㆦ>�L�ȅë�pۓ�Y0��|�df����Mm S�Pv�MB^5*��dR|@:��c�W�ؒ��9a�����O�oA��܃��͸���A�	��=mv�-�ɴ������Xl/)��
`h�/ֺ{�hl��ua)��,Lk-���(o����@؂�˖�.<T�wI5��[I�Z|�E,��>����NR��I��G7�3��H8U��,XJ�7�J����m<�׬nF�n�%�j�6e�\�-�ӹ_ѿ`ºq��i��}S�����\�**+�@Y��ܨ�Cm*��
A���F������gك!ͥi�yC�=,�0����5���8��P���V�N��G�3�!�r�����WМl�kl&���P��j����Q$�&T|b�6�sv����.G�k*�d��N�	1VX�w���!�c꣏�Ԣ=D��܊��-����n�ԄN�9�ڏ �����V��)����7�l�	xV�Ǿ�̦U�ཽ�b+����Hi���,�4@e�d<
��K��Ks��Vn��Y?������ms/��A�J�x�5R�,�j�W��{�2\���'�q?f�
�H��!�F?+�$����#���@\V=?�i'�\[X]Bѳh��]�*�	3����Y&/{�VY�q%ލN�=M���I���n
�������������L��JaMV�]�bA.�z8k�� #      �   �  x������0@��W�lTilْ(K{롅R�؋b�A`I��lw�o�=��c��B�asҠ��͌X&��x���}zwp�v�	.C�厱E@�RPJ8;Zd���0��a���>�gCVgG�X��D�
���.e1V���/���&�6�5v�p4��0��*����Ї�X��).L��m�"���G�����K'.�����6�
K�Ѕ��
kRVՕ�a�t���vIP�������R�PVδ:�q:	�~2��v��*X'�DP��L;1D�O���d�8x�%��#`c}��f3X�s(q��C�&��矝�mrf�i���%��4u�Ͽ����;�*�pk�L�4��!�Wt"�A~�4��\��.��l��:J�(�S�?�N�%ka�}y�]�E�7x��9cky� �`�
��֕�	w�Ϳ�<�� rkƆ      �     x��W�r�6>�O�05�!Чh�6��v<�L�\ 
�ᐄCRI�[��r�#�ź I�-%�H#�Ap�]|���5��\76�ֵ����ڵ_��ѝF)a��\�Y�!$!2�U�BÂ�7���-'���o�25L"Er�e�D���ֶеFg�i�7��:-a���zt�*\I��_Gn`w!(�"��]�2�� �C�e��	�	�����l�s�1����Q���0�禞�G���X}ӈ��q�5#D<a)��w �R�)�]`.��C�v�q��T�`��o6��TF�z���rR�����д���-�q�ʹ,ܭ+
��E�جrug<,4gY�I�a�~)e�9�]� &��R�^C�ʴvn�����Li5��֋%�s����w�5��e�4S���@qI����Q�RC�@��1K<7�̬��>�R�I&=>,!9l���sSW�
��dL��(t��]�H#F�zV:��U\��^���h��p
�K������)!����l�to!^�xpq��C�q`����=�m�,�d�k�܋4[3�ۭ���Z/@�C�lg�mI��,v�C�ID%>��ʖ]�s->\@"A{$��pa	��m0ޅ���>tn6�oyP�)�(	��c�'v��*�� ���Ѡ������\�yc�9Br%2O�\���@|.6m�b�N�g��?���5�ҕO{��ߗ@]�uy���uB.$�O<�b�TH/P#`�Po�sg���_z�K݇	�J�N̫�c�Mw�\
� ˽��5?0��D�z"���[��Ӫ��8�9)A"����ɩ�s_�A���$�)��Hh�JS�_���C��P��ۏƗy� 
8&�`�����Ѡ<�@P�@^��Z~�M�5 �Trhv@od�Ew`�{�=b�<�_"��Ӧ����[�v��k;�;���\�����S��M40Ș8i��=,!�2�Y�>h�y�h��*�n�'c�'v����s7}����^��n�UB����++���СE����ec+��4P�c4=�]3�0������8����a8F�@鮮7���05�����<e>ͣa�H��gj
R�����փ�u������HJ��C��QXc�%��M"|�^�ٓ��,~����oޮ�*�x�M�i�߷���5pm�5�Bw�=��x��*�ز���'�`�(���	> s�aV��9�P��qk����nX�wPX
��il��K�n�}���ڌu��}����Jeyö���Q*t֔����/>�����05�	W� >&GGG�8�)      �   {  x���ώ�0���S������S�b� !q��M�b�&Uڢ��S�b8�&���B��J�~Q��7�g8Y�������7(�6��3R�p��mW�ȶ�B���L�%�KfG%0�w�P�Q1�d�������o��onMA�����o��|��Vu{�k�e\��<2�0�!�b����c�J�9�o�����:�O���m?�����*�#3#J�0wJ8��dR#���j�	.$Ym�v��}Wyh*\�&Ȧ&@�6�. q�vPe3��(�^��k����U�P�₪5d�-v{_�'<��t�K�d��a:��2��?�Z(�f�C'LC>��/���*<[���MǺ-�n&������V���A�����~5�����R}����>�L;��ebbUJL�>]&�D;����;<�,P���Ykl��Pƒ�\������TO����C�dx�̴�1�\=Ýn*>7���h5�J%x"u�#��'�Gr���ęK�su�	��8���i�-�Q�̨n��NhʤU8�kiu�5�H�jjTX�"�5Q�\楸�CI�Zb�+R�\Y�վ��f��S�Hj�G`���uh�0����Q��}1���U\i�	�H��}����/�ΆM      �   �  x��T�N�@��b��8%:ڄ"]$R���g�z��zO��PRPѥ���������뙝�o�^|>e�3}�Z)��U"ǴӤ8o/wYHu\��^(	uQ����D4�#��vx��
}ˑ�^
�yЙ]5����؎~k�C�c?�'3�(
;}dʞ�[ �^��=P���TevwY%R^|Z�`PC������RJ�r]Е����^w��F�['��g�ss�gu�R+7>�^+6�m-'��{�����sk=����C���y�i�^��?SY^�����ؔ�͗�����.ˣa`r-M�i|� �v��Al�j/\-���s����5�a�0������Q�Wb
�e0��.�u}k4טH�Xq*��Y$��@�(��0͊�?�����G�u��q�c��O���"j<����F�i��*)ИU[6�+�ǻ���f�RQ�Cjhx�zm?l����=p"����=�7ጷ����`��O|"nr��c�g�F2ʸX�m�1�L�[A�{.�G�R_���-�;��Q
g�$M��;I�p��#p�:����jȴ���E���~�h�#I��]A�y�'dl���iͶ�HP�O��+��9q'~?��5NS�kv���Q�I�;��X.�m�o      �   [   x�3�tL����,.)JL�/�,�4202�54�50S02�2��2��3�0715�50�/�e�钟\B�1Ɯ��@�敤* �W�Y�O��1z\\\ �_6�      �   �  x��Y�n�H>3O������i�'#�x��{i��R�~��0��<�^l���lJ�j��Sͪ���꯾.R����զl�ʾt�]�4{�w��,焒�憬I��,�l�\�.{F�<��O��V�U�5������s�4e<3$��S�X�kJ�D��f�Z�W�sa`����h�/��_���/_3�Z(�����P�����? d9�p���zBF���}�Mծn�ƶ/e�m��Pz�F��t@���0�}D�m�q6:���ᑄ�l��ːcl���)�[Y]b+`j���D��cg�Ӯ;Lp�(�0�Pf|��`�	�0�\r	�W]v�ؗ/� ,�L�gB ֐}�ޛ[�NBf�Qm܄!E��y������|n�=��P�m�~���e�F.hH6�\��1{���v>����<!�9!��K2��M����C����H̔�]XD�$�w]1�ӹY�=lmؠ>!������y_>����[�>E1B��d��3٣�.�����r�鉙�$J�_y�������f_J�6t������b�S�r#���g�����˦l�8��{�de�kʧ�Ȟ�]]��;�\�]1���q��%҂��7Ra�a�Gȅ��g�mWw��:�Uk�h����5�̘�eI�1�?~��϶?T�39�&�crf�^�yu�I�?��-���>� ��
��u�E�즯�ǲ^��������˺>~oW�*��s�`)Þ�k&��~�¹�6y��;g�=�I��Ǽ�za���x˝T~`{ض�_�-@���Fƿo�4_�*TA��m��##MP�$G�(I��`�@uC�/^D.�@b���
��y���)AR�ȮNs\C�s�d^LK���j$�o�A��`k�|�1#r����T���0ۘP���\��e�:�fN�g�����XBq�.��*�]s�>`-�}Qz�s�br��$E~��]{�N�Û���(�s��	Gb�K`������uH����D�4sjF�$��'~���^x�`�#��H�f!Ojd��k�=� ГE��p�����H�Ŀ�a�2����ud.��rk�Ĳ�*P��6U'����o�'5v�pU��f��L	U���R�SӨ�q�ƀ�Z�2���ӍXC	�.I�����ag|Q$�>�I:水��d��z���#}��xK��I;��/Q�B���Me�Y��gy~��<�y�����t��ƌg�e��*��2`s�^���Q�1"o�C_�С��<Y�0-B�ݒ�����,;�Bn���`Q�eȒ��CUG��r�f�P��!��#:$����u<`�pP��]"E�#�#%|:����cg�_q��������]���"�����S��� ����.�Ii�D��eʀփ7N�?$�tft��u��WWW(Đ����m"�8�K�t���#��?�Bċȇ\J1���������e8�o��\�����~ʇ[�qI�ױ�:�Y�%]Զ+8��P.�Q��Pi:^t'�	|���~ʦ�S��#6��3�窆���?P7w���(�'�ఽ��.�	J��v�-k�R,�����쟶.�ܿJ�?h$��:���<Y<1�^g����,P+(�B��e���ʹ��I�6ض/vuWA���u:�'}�1S�9�Yݤw��0��IU���
������V�x��B�U�� ��Y�t�����;66Ka�J�� �۽��c�l�
ؠN3�(CR���'����uZ��^�Rg�j�Y�NM.�z�Q�Qk���s�[�N�*��h��T����.t�+/VL�qr�(ϑm��٪�iC�㟷��2.��|z����5�n�\�."�s�?��
?���`p&Y9S�pц�r>o�&�Z�v������i��]ܥ=\�-ݾ$�������c���m�pb��
\k�D� ���+\ws����D�x2L�r/���pC1Ճ��r�����<���5�4�=��1��q�_B��e�B���7m[���'&����"P_tR�C:�}���of}Ͱ���%���3F�{��X�>��� ��(���eH?o����TP3F��$�n��KoW�������"�h�`���g��!I/�F�"�\PS`[X���B�����p�!.4Mq�"��kA�8#����5׌]��U�e���u͚IvC����55����',��IUw�3����a��2��-,��)�f�jE�[�_�{����u�      �   6   x�3�43�4�,�4202�54�50W00�26�21�362074�50�/����� �`Q     