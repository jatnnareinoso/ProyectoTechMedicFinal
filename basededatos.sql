PGDMP                  
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
            public          postgres    false    235            �            1259    58490    paciente    TABLE     =  CREATE TABLE public.paciente (
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
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    seguro_medico character varying
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
    public          postgres    false    215   A�       �          0    58429    accesos_usuario 
   TABLE DATA           �   COPY public.accesos_usuario (id_accesos, id_usuario, estado, motivo, id_acc_usuario, id_paciente, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    217   ��       �          0    58436    asistente_doctor 
   TABLE DATA           y   COPY public.asistente_doctor (id_us_doc, id_usuario, id_doctor, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    219   -�       �          0    58441    centro_medico 
   TABLE DATA           �   COPY public.centro_medico (id_centro_medico, centro_medico, observacion, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    221   ��       �          0    58446    cita 
   TABLE DATA           �   COPY public.cita (id_cita, id_paciente, id_doctor, id_centro_medico, id_usuario, fecha_hora, estado, color, id_tipo_consulta, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    223   ��       �          0    58452    consulta 
   TABLE DATA           �   COPY public.consulta (id_consulta, motivo, descripcion, fecha_hora, estado, id_cita, notas_internas, notas_externas, pruebas, id_especialidad, id_paciente, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    225   ��       �          0    58458    diagnostico 
   TABLE DATA           �   COPY public.diagnostico (id_diagnostico, id_consulta, descripcion, resultado_pruebas, observacion, estado, archivos, ruta_archivos, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    227   g�       �          0    58464    doctor 
   TABLE DATA           |   COPY public.doctor (id_doctor, id_usuario, exequatur, observacion, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    229   $�       �          0    66615    doctor_centro_medico 
   TABLE DATA           �   COPY public.doctor_centro_medico (id_doc_cent, id_doctor, id_centro_medico, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    249   ��       �          0    58470    doctor_especialidad 
   TABLE DATA           �   COPY public.doctor_especialidad (id_us_esp, id_doctor, id_especialidad, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    230   #�       �          0    58476    especialidad 
   TABLE DATA              COPY public.especialidad (id_especialidad, especialidad, descripcion, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    233   ��       �          0    58483    notificaciones 
   TABLE DATA           �   COPY public.notificaciones (id_notificaciones, id_usuario, correo, fecha_envio, contenido, estado, id_destinatario, tipo_destinatario, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    235   }�       �          0    58490    paciente 
   TABLE DATA           s  COPY public.paciente (id_paciente, nombre, apellido, cedula, fecha_nacimiento, correo, sexo, telefono, nacionalidad, ciudad, direccion, menor, observacion, nombre_familiar, cedula_familiar, correo_familiar, telefono_familiar, celular_familiar, estado, celular, peso, altura, alergia, enfermedad, sustancia, fecha_creacion, fecha_actualizacion, seguro_medico) FROM stdin;
    public          postgres    false    237   B�       �          0    58497    receta 
   TABLE DATA           �   COPY public.receta (id_receta, medicamento, cantidad, frecuencia, tiempo, fecha_receta, fecha_creacion, fecha_actualizacion, uso, observacion, estado, id_paciente, id_doctor) FROM stdin;
    public          postgres    false    239   ��       �          0    58503    tipo_consulta 
   TABLE DATA           }   COPY public.tipo_consulta (id_tipo_consulta, consulta, descripcion, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    241   l�       �          0    58510    tipo_usuario 
   TABLE DATA           m   COPY public.tipo_usuario (id_tipo_usuario, usuario, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    243   �       �          0    58515    usuario 
   TABLE DATA           �   COPY public.usuario (id_usuario, id_tipo_usuario, nombre, apellido, cedula, fecha_nacimiento, sexo, correo, password, usuario, estado, celular, telefono, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    245   q�       �          0    58521    usuario_centro_medico 
   TABLE DATA           �   COPY public.usuario_centro_medico (id_us_cent, id_usuario, id_centro_medico, estado, fecha_creacion, fecha_actualizacion) FROM stdin;
    public          postgres    false    246   W�       �           0    0    accesos_id_acessos_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.accesos_id_acessos_seq', 20, true);
          public          postgres    false    216            �           0    0 "   accesos_usuario_id_acc_usuario_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.accesos_usuario_id_acc_usuario_seq', 17, true);
          public          postgres    false    218            �           0    0    asistente_doctor_id_us_doc_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.asistente_doctor_id_us_doc_seq', 45, true);
          public          postgres    false    220            �           0    0 "   centro_medico_id_centro_medico_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.centro_medico_id_centro_medico_seq', 2, true);
          public          postgres    false    222            �           0    0    cita_id_cita_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.cita_id_cita_seq', 90, true);
          public          postgres    false    224            �           0    0    consulta_id_consulta_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.consulta_id_consulta_seq', 25, true);
          public          postgres    false    226            �           0    0    diagnostico_id_diagnostico_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.diagnostico_id_diagnostico_seq', 13, true);
          public          postgres    false    228            �           0    0 $   doctor_centro_medico_id_doc_cent_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.doctor_centro_medico_id_doc_cent_seq', 4, true);
          public          postgres    false    250            �           0    0 !   doctor_especialidad_id_us_esp_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.doctor_especialidad_id_us_esp_seq', 222, true);
          public          postgres    false    231            �           0    0    doctor_id_doctor_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.doctor_id_doctor_seq', 47, true);
          public          postgres    false    232            �           0    0     especialidad_id_especialidad_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.especialidad_id_especialidad_seq', 21, true);
          public          postgres    false    234            �           0    0 $   notificaciones_id_notificaciones_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.notificaciones_id_notificaciones_seq', 18, true);
          public          postgres    false    236            �           0    0    paciente_id_paciente_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.paciente_id_paciente_seq', 14, true);
          public          postgres    false    238            �           0    0    receta_id_receta_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.receta_id_receta_seq', 57, true);
          public          postgres    false    240            �           0    0 "   tipo_consulta_id_tipo_consulta_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.tipo_consulta_id_tipo_consulta_seq', 3, true);
          public          postgres    false    242            �           0    0     tipo_usuario_id_tipo_usuario_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.tipo_usuario_id_tipo_usuario_seq', 3, true);
          public          postgres    false    244            �           0    0 $   usuario_centro_medico_id_us_cent_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.usuario_centro_medico_id_us_cent_seq', 7, true);
          public          postgres    false    247            �           0    0    usuario_id_usuario_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 71, true);
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
       public          postgres    false    245    4856    235            �   N  x��ԱN�0���y�F��i6�SI����.����q���Ÿ��*��'��3��u��{��������`{�!� ^�j�ج�s�[��J�J�g�?�L��[��#W��
L8�8y��IX��du?\C�j�\?�mN�,��7.�0��$�,������d$r�.��!9	Ĉ/ib�b�gs�F�B�w�.ɐ6�M"�\��4���`�Zo�Ηƙ���+�L	O��E�8\������)X�>����/����kM�x���$k�h{��n�ߘ��z�h�r^�R�BJI�X��Y���ųz���	�򺕪%�͍wS�^�,˾M�a      �   ~  x��S�m�0|�Ul��$�#�CKk��-*�l����Ʋ��A>���kGX4bcN�0�	N��cL�tH@����N(��q-(�5z���6�6k�����²�b!�t9�&Q/�G��Eh�i�w|��	�b�)�i�>��Pn�ڂ1���9�v!��#���9�9�mĥ
���݂�"��k�7�z)����⅛J�L0f��`��%�������Hy�/K+ݖFl���	.���;��;M�,���k�ue�mj���iI�堞��.q
�Xxа��z��v	����'�p��k�CbM��ɪ���z��5������Jz���J;�wE��.�X����B;���'�Bo�W��Z6��M�S�U[�V[���V����Y$      �   �   x����q!г�bJ��X6�_�=y�-_tn�F@���E�b7ps\"K�D�O	����p�Z�	���F�WUɣ�g��Y�����qVUdp��y3Re���P�5�FZU�<��8J�Q��s����9��C��6�G��b|�*J1��2^��3���1mf����"�*_:;;���7m�Gɢ�ꭵo����      �      x�3�t�9�6/39Q�)1�J!8�$_AM��� 5931'3%1%���/3/�4/�������D��P��L��������@������H���,��sj^IQ����)���
a
 �ԼĢ�|�`=G*����� ��6�      �     x���I�1E��)�8J���&�$��㇪lU�c#v�}���d�P���� ��4�p �p���t�������#�9./D���l9S���T�Z� �������>�����h5 ������fr�,r�����aRB~霽WFuV�[��,���=	��y=�I�� ���aśȳx�H�m�5�������/���}��?�$���i\q����].��Th\�aY�6���U�z	����v�l��k�IE%��Qc�	��`���vRm̩fC��^��{�v��+I�U�����g�!�&��)A�\'�m�h��ƛa��~N��i����+ێ����&�4Ą�Tg�Q���: �`��k����35Z��n�II% �he�n㕞�M��'LD�D����&0�p�i�N�&���,{�F�Y����w���~��W�����ZR�/��������K�		�`ÜH�d���j�П�-M��8���.M�������Z� ���c�սf      �   �  x����n�8���S�$Z����[�6�� ���-��T)i���鱇��~��Jl�J��I�胤������U/]'[������P��|P)ᔨ��$�hM�J��e����KQ��~��485��<�?���i:[���kQ�B��V�6"����K����<�ivIcґd�F�ҀԠ7�������t�:PO�z%]e_�J�]/�X_mm�N�6?Ń!,%���p^ĴHyē9g!�7��#WJ.�V��M�V�ʹʚh�n���a�mq$�@��ǃ���;���;�1��((�M��y���3��Gٙrۗ���;ѷR���$���h)��|@iM�L��'�� \a�?�K�ē%s�=+�)������(c�A��VAa[���k*�����
e��o�͍ǥ�w ��⬁G��7b@y�x�qV�4ZP>�\�O�H���FJ�1��r�&�l��~�6������JmW҈�v�U����`j�X��z�k�qVP��cɀ,����c��v��
B�[<'#����m��V��ax���/'�a��s��j;/�=��~/��َ���ϩ��~��P�vO�ڋ|�'*��K�B�M�.�4��|�v���X��V7# �x½�5�J��I��15�<�v�	��_˶��ꄾ�U���[���@n�o�����@��-�j�"���@'aPM���l ��Xz�l# [�*���R+ߡ+�����2Z��懫q<����M~�`��l��ЧC�>��Q3J���Pe{����l�kժp�h�Y;��n�3`��H�(�ӄ�d׳O���Pǝ�y�ǉ�?+"=�`R�M/����wq�v��]��Z#�8I�>�I_q +��OB:99�(L)���joLK&�����[�o��=D�����ia      �   �  x�}��N�0���S�8�;Nv77���P�� 4�g#ǎ��s��c=���)�.˪'[����73�3Q�S=���@���'X��� �!��`��BQ���1Z90\�A;m�}�G��S�h`��H��|���G5}��n�.)�f@�j�xIˎ�K"0M*���h�������ڒr��nC���cC1���.ؗ��7U8�"��K!�yzN E�s8#K(�%�Qe�Z\3��r��Qy-yV�BDO��`�2R��r[��o��T/��UQ䲒�(ROmĿ��7�V���u��	6��0�;����|VK�Ez���{�	���-��޻��
�S��ʳr��K��~����Žh���e�G �׺���x)��a���-ym7��o�[�[��=��.󚗙(��b��]4�ʒ$�5t�?      �   �  x����m1DϳU�/��E������!1� �x5���̐
��EYx��؝�Nq��.�3u˝������a�Mbc��~R�MW<�6a:��$�,#�Ht4$p�������7�.5���#J�(TD��(٫�]�� ��*�*�C�������)�����$eZ�$*/�䔎Ma����lH��K��fT�X��)U�����+$���0���%�I���N����L,#��]P��7K�W稫����i�v(�J�2Em�z��x�P�_���i.�%���2:Uh��>�y��C)��*G�3��(�p}�b>=����5z��V�z估��y�^�����Ϩ��$�8�,�P�D��^}q�r;KH<��<��8> ��T      �   \   x�}̱�0�ڞ"$���<c��h���O:��B��`�Ɏl@�W`�!i���kK��X�"�<��z'��!�{�G�k��5�%_��P�)�&�      �   S  x���ˍ�0�3]���������;�)�{���zD�2�..?���2{i?�w�u��/�3��!�pF�)Y��D'����e���%콸������wRA�d��t�D���.K��b�p��ց<�N�,���Us� v��H�h&X"��-dd�Bׁ&e�����Q�G����*���4X���� S?Hr�	6*ix�E2��Og/�LuH��C�!�SV�ξ�`����T�1��5B{�!��# �D����in���fW�k�My<Ӌi4��_L�6�eU�����t
����3w�+�m��~�Wo���
fY�`�����:����`      �   �  x��WMo�8=˿�?�	l9����`�vl����)�a@�*)H�M�9�P�֫�ؾ�d;r�t�����y�̲m�t�-�'w�rjU{-5e_�p2V$
%�@&«ʻ"�Z��� �x��
c��4�N��	e�*��ލ��"_;��B��6�C�%�R{����b��V�T*�݈��RIۓ�תTV[w��Y>ɏ�Ӄɉ���l2����g�y~0���::�~#_��1T
ȍ���kTmn	㋴���m1�����h9jw(�l�tIV�&����vq�+��ѕ�A#�X���.5R��'��%���U8�~GX$ݕ�Kb�I_&��Rie�B�B�;b���x���m�y�e�UpMw�]�5j��^��>�C]5BB�8q�v~�C �Xl�/�N���q= '��{w��Vj��wu�R>�Ŕ�P��٥��9\C��_DB�̓����B��v��TiO�� ���M}:�.P���mOz��g�z�`&�县%�k������o�yZR1�v���#r���$�ܸj�p�q�P����K���֑{pQ���٤��qP���|@O�]`�w�4�.��J�O,���b0�ˀckݽh$�s��4Af��^I�����o�Ͳ�[�l��y�k*�jD�����{�q,��]�S�
u���g�(�[�g7�+��H8���$X��Ӷ�V���m<�פn�	�n�;��ju���[��S���06�u�ab�=�>�p�~�Q�����Fn���6��e� �E��K|�*6�I�`H�B��	켾��LO�c����y�6�8ޯ-#/��B-��XX�|K��+h�7�56�_q^�P��j����Q$�&�}V<mX���2{X����.Y�-w;F�Xa�sܝ�Z�0��O.l���H|طS+��bb��S:��dj?���bD�����+ߟ9Vo\��}/ڙM��/�s�,�B�0hͥ�aj]n�R/=�x8�Iv��0*��[s��Vn��U?.#����M��kӃzU`��;�X���m^��)�p��d�����,�	�#�]��44�y�a����H\?��%ի�5���j��(z�u�rB��~�x�I���U�x\�w�SvO��y��;��<mg�����/�
S�֎��u&�kɆ�&��.�?� v�6;��������m�|*����x>���͎z������&�&z)�5��'���������E���G��p7�      �   �  x���An�0E��)x���P�H
E��
�� �nh�uH�+�i��� ]��XG�S[�l��.�g�������~<e����2\DW W\P	Ι}���ޗ��7�o]E?Qy�\ҷ��]�*X�4wU�v%b*D"L"c&��L�U9%b��ús��3$K��ҕ���\!r���+��q,Γ��)���}KaY�ue�{�����/�\:X7k[������D�D(��@���,]���D�|s9�$�7ͅG*�!:3FZXڸҢ��׎>���r��,��B	���'މ�vM?�*M.^����L�*�Bz�T�44	�L�~���u5����"or��u�藵��l)N}U��~�K��q9A����ՔLks��P��5�����~A�Uȱ(>�R&\0�����}�����2?ɳM5a$Fx�Q0�Gj�C�0�p}�b=
�% ��� 
&�p�����ָvsƥ���rOs+Jr�s4J �ɩ.�'�zn[FI-F��Q�<8�o\�@��;�L������$n�S�pEjW�(lu�t�!z�M۵-�g��Wnk�Y���2ҏ����Zһ��n�@Ar�_�Gcm�bdV(���P�X�Kz�����ތs�%�LG~%��kb����7)�O�vk/'��7As��<�8�гՁ�%�43Q�aY��=����*��1�A�|a��?Ͻޕ      �   �  x��W�r�6]�_��4x��q۴��d�.:��,�!	���ڻ~J�]d�OЏ�$-J��t*�<I�����s�(G���YU9�.��B�k�Z$�\-�1BȄ�	U�����7���b����JW�M��Q�Pf�!���,:��7�X��A/�i�ko�����Z1cP><���KI��b<l�Q)#�K#t_F��P:!3v�̉`S�i����ǋ#Jѯ�	���U��h�[[端��t�P�&Ч4{8L�L�W��X��:Pƙ�Jg��*>ل��f0R4b׎/('�5�Si���{��"n�̊<܆��B�q���W��ujXf2E"2*��,�����;���T���t���*����KWx{���b	�ޅf��F̻�8��	��4����:���pyx�h��B����u�x��[}��:SLE�؄x�O�m�;w�ՋX1(Mƴ�G�c|� t`�`���S������7�(�h؎/` ���� ���+�����l���=B�Rs��5��8p*��|n�|Y�)Ņ�k�³z[�Hܮ�V��(F�����W�\R*S�x؎/�H%z@!"�Ԗ���Vmh�yJ*A�	:��D�(��M(Gy�ݤɻ �Qo9���f���=PJ �L��gGqF�v|�hDK���%A�Z��-h~�4X�e��~���#�h�E�'�L �'�i�;4k𠽂����V�Җ��IR�xd-l5��͛��n�T>�a;�I��b5`v 1�>N�n�ma�L�]BJŢ�?�i�bg�	���˭�$��!��XG'�3x��b}uL����!IDEb�9�To0����}�{���S�P�[������x����%�]�v�?�����ST?����h����8M*���n��u��,������94��vߨ'$�0Q�b_�&,5���TKj_�/�W��HB=�p�ǹ������ۀa'���U���ޥ[}Jz��4�Eꎆ�8E��*;��	��ڄ_��l8������cW�P*� (T|���5�[���"2��kMլ.�`�mQ8�.���h�oW�J�x�]�y��7/b��p��>k<���{6���+C��n�E�А_B:�*z ��>�t��C:�l��k�����YB�=��٧�ϙ��g�Կ�F�6�;��ɾ{(n�V���e�����
��)�'LO���� �[�Ђ�P�d�%���U��h��(el5_s�)`���g!�|��J)S��m	�ʠ��i���I�g� �ԅ���]ݺ�I>��Q��	�'�N��Ll����S:I����2���QRt�l7e>,��</��No]Ӻ������`�yw�܄IE'���Q�@��$�$�F�z�l1���ѷ5$��?��[L`�O|���&Zħ��+��_��}����k�      �   s  x���_n�6Ɵ�S�����d���6��@���j�Y
d�z���+)ǑD�^c��a��gp~��ȡ����n�*ז )�=FIUn�|��rO��ޏ��9�↱�φ@���r�Q����_Q�������ٵ�C[�aDl8�sO}�|����5���<"qqd*`|43B&F�^p}�K�h�ʄd�b�7R_y8���k�m����/j"������R_cVr+e&�P�b����A�AnwM�uO���>�'H�I��v�� 1nY�ӑ��h�"��z.=L�۾������g�[)<���k���_���
c3M�Y�2�N���;����ڡ��&����c�,����
�
I�MW����/��g�X�/�i���)�������ù�6cSef�r��J�)ӧ��Tb�Le�ߕ^Psꩬ�Kn�\�vB��%8��0�C�/_85.Oy�t�`�a#8�ȭ��QZ�pku�;�T��<y�b���2��k�y|y�T(O칄��Ǟ0���:�@f`f*=�V
�UFE.qq�����#�v\�2-}��I�����o�%-��R�&�"u�e�mUʝkGk]�FR�<36�k_*�s�J�Z����7�͚f�I�y,RW`���ҵ��������l¢a�F�9TZ]@� ��}�=����e��Ը@n��0i��F��G0�&eƠHD��)^A0˼�Wz ����5e�7|.�-E�����u�].�z�n�ǟ��Y�p��R�3ߟ�uJ���� ĉ�HE�7���{��2z��w�ڹ�0WL�Q"q��D�����+�]�tm=�b���o���*.�s���/\~��K�UԖz�(A���j�z5�O�͟�f��m�~�      �   �  x��T�N�@��b��8%:ڄ"]$R���g�z��zO��PRPѥ���������뙝�o�^|>e�3}�Z)��U"ǴӤ8o/wYHu\��^(	uQ����D4�#��vx��
}ˑ�^
�yЙ]5����؎~k�C�c?�'3�(
;}dʞ�[ �^��=P���TevwY%R^|Z�`PC������RJ�r]Е����^w��F�['��g�ss�gu�R+7>�^+6�m-'��{�����sk=����C���y�i�^��?SY^�����ؔ�͗�����.ˣa`r-M�i|� �v��Al�j/\-���s����5�a�0������Q�Wb
�e0��.�u}k4טH�Xq*��Y$��@�(��0͊�?�����G�u��q�c��O���"j<����F�i��*)ИU[6�+�ǻ���f�RQ�Cjhx�zm?l����=p"����=�7ጷ����`��O|"nr��c�g�F2ʸX�m�1�L�[A�{.�G�R_���-�;��Q
g�$M��;I�p��#p�:����jȴ���E���~�h�#I��]A�y�'dl���iͶ�HP�O��+��9q'~?��5NS�kv���Q�I�;��X.�m�o      �   [   x�3�tL����,.)JL�/�,�4202�54�50S02�2��2��3�0715�50�/�e�钟\B�1Ɯ��@�敤* �W�Y�O��1z\\\ �_6�      �   �	  x��Z�n�H>�O����?:���d$@/X`/m���P�@ʙ�M�s��bA/�U�M�)yWY03�1EV7?����*2����6�){����w��v�6#B�,'�d�� vAY���,i��	Wv�b��i�uU�,�mzvr�ό��0M��Rs��abA邨���+i��sa���W���h��o٧�+_3�Z(����m_N����@�,�Xr��,���7e��U��6[�<�uv���2�5n�#Z��G����@��/�pKB-}k�<���7�[g)�m�ol��ق��`�Mzl�G��Yz4@�\-�	�f�Q&�,�b�pW���}W>g�0+��	�XX@�!w�ܡu�������0����Zĭ%�F�Y�DXv�}�6-�z�U����\�l��>.����.8�CpP�'�7'dxI��i�}Wv�"ń�6#�,��<����8��S��{HmH��̯9�1=?�k����]��@"FhfI��9#�.x�'n�{����,�_�u�/����~�o����e�K�ַ�]�un�0�)W�)1��>���r[6��e]Xe���/��m����)^ЕH���tE�߸��YK$�HFB�H���<B.�u7q8�mں�T�c�Wv�i�:�S�ȌV��1���tݾj�1c16�m��z���%n~�l�pm�@�J�Ȋ����g�]�ߗu~]�m:WT<�+����Ub����RƜ�&����_��AN����#$�r?Ľ�3?ϐ�;x�I����E���l�qZ����+8)��B�*��ϝk� qd��	���9%)�<D��?��O C���
��]�:%J��o���4�5�;�aJ�Ŵĵ;|	���$Mgk���1",�G�\b���e��$&~i(�Q��iu~�vJ�g��b�rF�PB1_��F��v{��c-�]Q��z��b,VQ�"߷[8�+����X�'�p�A�[�g>	Gb�K`��M��]��:�x�	�4�jF�&��G~�U�����*�G
:�ہ(�L���(՗2�{@k����
�]��M����1e"�N�f�B��z_3&�e�@y~��j谲��+�;���p�$�A�8	�T�̫K�NM��I:8sj�ȁo�Xm�n�J(�A��\���{�" �����W;�A�i�{W�?������Wig��SԯP#a��2
�Y���<o:���/�����}pc�u~F�
أ�9|+�F�(��7}ӗ*\P8o����-���+�a�!צBl��]�P�eȒm�����r�f�P��!��{\�`N�N��[�F�G(v��	i)���]';A��S;����H����0+B�KB��}���w��\�Ӛ����Q��I��h���]r�N����#�.������}m�@�0D�5%�MXqI�D����:�'��~����x8��!E�3J�8J�hy��o�@Pv<8��?"�6K��$@;VU�D���".�\p�h7�#���n�7i�X�0<�7��]]BC�'��hI�#6��x_ê3J����,2:� �2qI;OBbI�yt���\m�]��WG�B�A ~a\5)O7�:5�bRy��̾[�4򓻯�<�}����ĂP2g��H^����v������R�h3�1#ϫ�>7к�!R��7
T�T�XJ��T�:%��G�ԛ�"r2 �R̜�C�>�»�^�s/�-�P l�$���\�uy�7��WbT��>Ng�92�k����o���==|�H�u`�NJ��n���K��8�����d�O��QB~k�]�|����S�?������hp�9S�pV�	���Yh2��@�k��☪�2����p�⬴+	{�8dß2U|Dv�*Jq.@�s�C3�\AN��)W��3�~�ԅ�FUb�
�f8�
�Ÿ�Q|,'��0���n���	����pi��ztޗ�X!��uӔ�̉�^�
�����i�?ȷ�I�f8������D�s��aP~��=��m����dS�*F���nk\[�%D
�Ψ�����
�� �4�4����|%Ȓ3�1���U�bl	jR)8���j|��2�C��'�0�H�l<3�p��(�G�%���\�t�ȒjEEh��? ����l�M �Oςx�_(�{I�ќ:��vI$�v���~$`~l�A�[ɭI{�ٺl�_�$_�؂?w�V۝X��H| ���V%NTԮ�X1�� %?�WY������d �<{�6/�-_��G���A&�������N�o��_�6�6��y�&V�]L� [Aokz�PN�/��U��0'b���Jx�����<KD*j<��,f�]@�k�xJ�k�����F	RhHc0z��*���E�0L�m��s��������+ɗLIM��W�!�;P,6���ݾ�8���>ć�2��l��>��������e��?�ި@�J�%�j��z������ ���i      �   n   x�}��!Dѳ]�fl��ZRF�W�aw��/=}�B���z%+� ��A����C�>c�N�46.�����1�3�6��r�<�^���Û�8O��~��� m�3�     