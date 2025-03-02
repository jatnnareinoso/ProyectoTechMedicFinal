PGDMP  3    ;            
    |        	   techmedic    16.2    16.2 m    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    32949 	   techmedic    DATABASE     �   CREATE DATABASE techmedic WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Dominican Republic.1252';
    DROP DATABASE techmedic;
                postgres    false            �            1259    32961    accesos    TABLE     �   CREATE TABLE public.accesos (
    id_acessos integer NOT NULL,
    modulo character varying(50),
    estado boolean DEFAULT true
);
    DROP TABLE public.accesos;
       public         heap    postgres    false            �            1259    33044    accesos_usuario    TABLE     �   CREATE TABLE public.accesos_usuario (
    id_acc_usuario integer NOT NULL,
    id_accesos integer NOT NULL,
    id_usuario integer NOT NULL,
    id_centro_medico integer NOT NULL,
    estado boolean DEFAULT true
);
 #   DROP TABLE public.accesos_usuario;
       public         heap    postgres    false            �            1259    41997    asistente_doctor    TABLE     �   CREATE TABLE public.asistente_doctor (
    id_us_doc integer NOT NULL,
    id_usuario integer NOT NULL,
    id_doctor integer NOT NULL,
    estado boolean DEFAULT true
);
 $   DROP TABLE public.asistente_doctor;
       public         heap    postgres    false            �            1259    42013    asistente_doctor_id_us_doc_seq    SEQUENCE     �   ALTER TABLE public.asistente_doctor ALTER COLUMN id_us_doc ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.asistente_doctor_id_us_doc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    245            �            1259    32950    centro_medico    TABLE     �   CREATE TABLE public.centro_medico (
    id_centro_medico integer NOT NULL,
    centro_medico character varying(50) NOT NULL,
    observacion character varying(100),
    estado boolean DEFAULT true NOT NULL
);
 !   DROP TABLE public.centro_medico;
       public         heap    postgres    false            �            1259    33780 "   centro_medico_id_centro_medico_seq    SEQUENCE     �   ALTER TABLE public.centro_medico ALTER COLUMN id_centro_medico ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.centro_medico_id_centro_medico_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    215            �            1259    33143    cita    TABLE     =  CREATE TABLE public.cita (
    id_cita integer NOT NULL,
    id_paciente integer NOT NULL,
    id_doctor integer NOT NULL,
    id_centro_medico integer NOT NULL,
    id_usuario integer NOT NULL,
    fecha_hora timestamp with time zone,
    estado boolean,
    color character varying,
    id_tipo_consulta integer
);
    DROP TABLE public.cita;
       public         heap    postgres    false            �            1259    33781    cita_id_cita_seq    SEQUENCE     �   ALTER TABLE public.cita ALTER COLUMN id_cita ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cita_id_cita_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    226            �            1259    33202    consulta    TABLE     �  CREATE TABLE public.consulta (
    id_consulta integer NOT NULL,
    motivo character varying,
    descripcion character varying,
    fecha_hora timestamp with time zone,
    estado boolean,
    id_cita integer,
    notas_internas character varying(255),
    notas_externas character varying(255),
    pruebas character varying(255),
    resultados_pruebas character varying(255),
    id_especialidad integer
);
    DROP TABLE public.consulta;
       public         heap    postgres    false            �            1259    33782    consulta_id_consulta_seq    SEQUENCE     �   ALTER TABLE public.consulta ALTER COLUMN id_consulta ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.consulta_id_consulta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    228            �            1259    33229    diagnostico    TABLE        CREATE TABLE public.diagnostico (
    id_diagnostico integer NOT NULL,
    id_consulta integer NOT NULL,
    descripcion character varying,
    pruebas character varying,
    observacion character varying,
    fecha_diagnostico date,
    estado boolean
);
    DROP TABLE public.diagnostico;
       public         heap    postgres    false            �            1259    33783    diagnostico_id_diagnostico_seq    SEQUENCE     �   ALTER TABLE public.diagnostico ALTER COLUMN id_diagnostico ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.diagnostico_id_diagnostico_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    229            �            1259    33067    doctor    TABLE     �   CREATE TABLE public.doctor (
    id_doctor integer NOT NULL,
    id_centro_medico integer NOT NULL,
    id_usuario integer NOT NULL,
    exequatur numeric,
    observacion character varying,
    estado boolean DEFAULT true
);
    DROP TABLE public.doctor;
       public         heap    postgres    false            �            1259    33090    doctor_especialidad    TABLE     �   CREATE TABLE public.doctor_especialidad (
    id_us_esp integer NOT NULL,
    id_doctor integer NOT NULL,
    id_especialidad integer NOT NULL,
    estado boolean DEFAULT true
);
 '   DROP TABLE public.doctor_especialidad;
       public         heap    postgres    false            �            1259    33785 !   doctor_especialidad_id_us_esp_seq    SEQUENCE     �   ALTER TABLE public.doctor_especialidad ALTER COLUMN id_us_esp ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.doctor_especialidad_id_us_esp_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    224            �            1259    33784    doctor_id_doctor_seq    SEQUENCE     �   ALTER TABLE public.doctor ALTER COLUMN id_doctor ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.doctor_id_doctor_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    223            �            1259    32983    especialidad    TABLE     �   CREATE TABLE public.especialidad (
    id_especialidad integer NOT NULL,
    especialidad character varying,
    descripcion character varying,
    estado boolean DEFAULT true
);
     DROP TABLE public.especialidad;
       public         heap    postgres    false            �            1259    33786     especialidad_id_especialidad_seq    SEQUENCE     �   ALTER TABLE public.especialidad ALTER COLUMN id_especialidad ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.especialidad_id_especialidad_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    220            �            1259    33170    notificaciones    TABLE     &  CREATE TABLE public.notificaciones (
    id_notificaciones integer NOT NULL,
    id_paciente integer NOT NULL,
    id_cita integer NOT NULL,
    id_usuario integer NOT NULL,
    correo character varying,
    fecha_envio date,
    contenido character varying,
    estado boolean DEFAULT true
);
 "   DROP TABLE public.notificaciones;
       public         heap    postgres    false            �            1259    33787 $   notificaciones_id_notificaciones_seq    SEQUENCE     �   ALTER TABLE public.notificaciones ALTER COLUMN id_notificaciones ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.notificaciones_id_notificaciones_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    227            �            1259    32967    paciente    TABLE     �  CREATE TABLE public.paciente (
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
    sustancia character varying
);
    DROP TABLE public.paciente;
       public         heap    postgres    false            �            1259    33789    paciente_id_paciente_seq    SEQUENCE     �   ALTER TABLE public.paciente ALTER COLUMN id_paciente ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.paciente_id_paciente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    218            �            1259    33241    receta    TABLE     
  CREATE TABLE public.receta (
    id_receta integer NOT NULL,
    id_diagnostico integer NOT NULL,
    medicamentos character varying,
    cantidad character varying,
    dosis character varying,
    dias character varying,
    fecha_receta date,
    imagen bytea
);
    DROP TABLE public.receta;
       public         heap    postgres    false            �            1259    33790    receta_id_receta_seq    SEQUENCE     �   ALTER TABLE public.receta ALTER COLUMN id_receta ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.receta_id_receta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    230            �            1259    32975    tipo_consulta    TABLE     �   CREATE TABLE public.tipo_consulta (
    id_tipo_consulta integer NOT NULL,
    consulta character varying,
    descripcion character varying,
    estado boolean DEFAULT true
);
 !   DROP TABLE public.tipo_consulta;
       public         heap    postgres    false            �            1259    33791 "   tipo_consulta_id_tipo_consulta_seq    SEQUENCE     �   ALTER TABLE public.tipo_consulta ALTER COLUMN id_tipo_consulta ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tipo_consulta_id_tipo_consulta_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    219            �            1259    32956    tipo_usuario    TABLE     �   CREATE TABLE public.tipo_usuario (
    id_tipo_usuario integer NOT NULL,
    usuario character varying(50),
    estado boolean DEFAULT true
);
     DROP TABLE public.tipo_usuario;
       public         heap    postgres    false            �            1259    33792     tipo_usuario_id_tipo_usuario_seq    SEQUENCE     �   ALTER TABLE public.tipo_usuario ALTER COLUMN id_tipo_usuario ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tipo_usuario_id_tipo_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    216            �            1259    33026    usuario    TABLE     �  CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    id_centro_medico integer NOT NULL,
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
    telefono character varying
);
    DROP TABLE public.usuario;
       public         heap    postgres    false            �            1259    33108    usuario_centro_medico    TABLE     �   CREATE TABLE public.usuario_centro_medico (
    id_us_cent integer NOT NULL,
    id_usuario integer NOT NULL,
    id_centro_medico integer NOT NULL,
    estado boolean DEFAULT true
);
 )   DROP TABLE public.usuario_centro_medico;
       public         heap    postgres    false            �            1259    33794 $   usuario_centro_medico_id_us_cent_seq    SEQUENCE     �   ALTER TABLE public.usuario_centro_medico ALTER COLUMN id_us_cent ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.usuario_centro_medico_id_us_cent_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    225            �            1259    33793    usuario_id_usuario_seq    SEQUENCE     �   ALTER TABLE public.usuario ALTER COLUMN id_usuario ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.usuario_id_usuario_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1
);
            public          postgres    false    221            v          0    32961    accesos 
   TABLE DATA           =   COPY public.accesos (id_acessos, modulo, estado) FROM stdin;
    public          postgres    false    217   l�       {          0    33044    accesos_usuario 
   TABLE DATA           k   COPY public.accesos_usuario (id_acc_usuario, id_accesos, id_usuario, id_centro_medico, estado) FROM stdin;
    public          postgres    false    222   ��       �          0    41997    asistente_doctor 
   TABLE DATA           T   COPY public.asistente_doctor (id_us_doc, id_usuario, id_doctor, estado) FROM stdin;
    public          postgres    false    245   ��       t          0    32950    centro_medico 
   TABLE DATA           ]   COPY public.centro_medico (id_centro_medico, centro_medico, observacion, estado) FROM stdin;
    public          postgres    false    215   �                 0    33143    cita 
   TABLE DATA           �   COPY public.cita (id_cita, id_paciente, id_doctor, id_centro_medico, id_usuario, fecha_hora, estado, color, id_tipo_consulta) FROM stdin;
    public          postgres    false    226   ��       �          0    33202    consulta 
   TABLE DATA           �   COPY public.consulta (id_consulta, motivo, descripcion, fecha_hora, estado, id_cita, notas_internas, notas_externas, pruebas, resultados_pruebas, id_especialidad) FROM stdin;
    public          postgres    false    228   i�       �          0    33229    diagnostico 
   TABLE DATA           �   COPY public.diagnostico (id_diagnostico, id_consulta, descripcion, pruebas, observacion, fecha_diagnostico, estado) FROM stdin;
    public          postgres    false    229   �       |          0    33067    doctor 
   TABLE DATA           i   COPY public.doctor (id_doctor, id_centro_medico, id_usuario, exequatur, observacion, estado) FROM stdin;
    public          postgres    false    223   �       }          0    33090    doctor_especialidad 
   TABLE DATA           \   COPY public.doctor_especialidad (id_us_esp, id_doctor, id_especialidad, estado) FROM stdin;
    public          postgres    false    224   !�       y          0    32983    especialidad 
   TABLE DATA           Z   COPY public.especialidad (id_especialidad, especialidad, descripcion, estado) FROM stdin;
    public          postgres    false    220   �       �          0    33170    notificaciones 
   TABLE DATA           �   COPY public.notificaciones (id_notificaciones, id_paciente, id_cita, id_usuario, correo, fecha_envio, contenido, estado) FROM stdin;
    public          postgres    false    227   ��       w          0    32967    paciente 
   TABLE DATA           ?  COPY public.paciente (id_paciente, nombre, apellido, cedula, fecha_nacimiento, correo, sexo, telefono, nacionalidad, ciudad, direccion, menor, observacion, nombre_familiar, cedula_familiar, correo_familiar, telefono_familiar, celular_familiar, estado, celular, peso, altura, alergia, enfermedad, sustancia) FROM stdin;
    public          postgres    false    218   �       �          0    33241    receta 
   TABLE DATA           v   COPY public.receta (id_receta, id_diagnostico, medicamentos, cantidad, dosis, dias, fecha_receta, imagen) FROM stdin;
    public          postgres    false    230    �       x          0    32975    tipo_consulta 
   TABLE DATA           X   COPY public.tipo_consulta (id_tipo_consulta, consulta, descripcion, estado) FROM stdin;
    public          postgres    false    219   �       u          0    32956    tipo_usuario 
   TABLE DATA           H   COPY public.tipo_usuario (id_tipo_usuario, usuario, estado) FROM stdin;
    public          postgres    false    216   ��       z          0    33026    usuario 
   TABLE DATA           �   COPY public.usuario (id_usuario, id_centro_medico, id_tipo_usuario, nombre, apellido, cedula, fecha_nacimiento, sexo, correo, password, usuario, estado, celular, telefono) FROM stdin;
    public          postgres    false    221   ֥       ~          0    33108    usuario_centro_medico 
   TABLE DATA           a   COPY public.usuario_centro_medico (id_us_cent, id_usuario, id_centro_medico, estado) FROM stdin;
    public          postgres    false    225   �       �           0    0    asistente_doctor_id_us_doc_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.asistente_doctor_id_us_doc_seq', 35, true);
          public          postgres    false    246            �           0    0 "   centro_medico_id_centro_medico_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.centro_medico_id_centro_medico_seq', 2, true);
          public          postgres    false    231            �           0    0    cita_id_cita_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.cita_id_cita_seq', 60, true);
          public          postgres    false    232            �           0    0    consulta_id_consulta_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.consulta_id_consulta_seq', 16, true);
          public          postgres    false    233            �           0    0    diagnostico_id_diagnostico_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.diagnostico_id_diagnostico_seq', 1, false);
          public          postgres    false    234            �           0    0 !   doctor_especialidad_id_us_esp_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.doctor_especialidad_id_us_esp_seq', 202, true);
          public          postgres    false    236            �           0    0    doctor_id_doctor_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.doctor_id_doctor_seq', 43, true);
          public          postgres    false    235            �           0    0     especialidad_id_especialidad_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.especialidad_id_especialidad_seq', 16, true);
          public          postgres    false    237            �           0    0 $   notificaciones_id_notificaciones_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.notificaciones_id_notificaciones_seq', 1, false);
          public          postgres    false    238            �           0    0    paciente_id_paciente_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.paciente_id_paciente_seq', 13, true);
          public          postgres    false    239            �           0    0    receta_id_receta_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.receta_id_receta_seq', 1, false);
          public          postgres    false    240            �           0    0 "   tipo_consulta_id_tipo_consulta_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.tipo_consulta_id_tipo_consulta_seq', 3, true);
          public          postgres    false    241            �           0    0     tipo_usuario_id_tipo_usuario_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.tipo_usuario_id_tipo_usuario_seq', 3, true);
          public          postgres    false    242            �           0    0 $   usuario_centro_medico_id_us_cent_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.usuario_centro_medico_id_us_cent_seq', 1, false);
          public          postgres    false    244            �           0    0    usuario_id_usuario_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 64, true);
          public          postgres    false    243            �           2606    33295    accesos accesos_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.accesos
    ADD CONSTRAINT accesos_pkey PRIMARY KEY (id_acessos);
 >   ALTER TABLE ONLY public.accesos DROP CONSTRAINT accesos_pkey;
       public            postgres    false    217            �           2606    33289 $   accesos_usuario accesos_usuario_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.accesos_usuario
    ADD CONSTRAINT accesos_usuario_pkey PRIMARY KEY (id_acc_usuario);
 N   ALTER TABLE ONLY public.accesos_usuario DROP CONSTRAINT accesos_usuario_pkey;
       public            postgres    false    222            �           2606    42002 &   asistente_doctor asistente_doctor_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.asistente_doctor
    ADD CONSTRAINT asistente_doctor_pkey PRIMARY KEY (id_us_doc);
 P   ALTER TABLE ONLY public.asistente_doctor DROP CONSTRAINT asistente_doctor_pkey;
       public            postgres    false    245            �           2606    33750     centro_medico centro_medico_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.centro_medico
    ADD CONSTRAINT centro_medico_pkey PRIMARY KEY (id_centro_medico);
 J   ALTER TABLE ONLY public.centro_medico DROP CONSTRAINT centro_medico_pkey;
       public            postgres    false    215            �           2606    33739    cita cita_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.cita
    ADD CONSTRAINT cita_pkey PRIMARY KEY (id_cita);
 8   ALTER TABLE ONLY public.cita DROP CONSTRAINT cita_pkey;
       public            postgres    false    226            �           2606    33412    consulta consulta_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT consulta_pkey PRIMARY KEY (id_consulta);
 @   ALTER TABLE ONLY public.consulta DROP CONSTRAINT consulta_pkey;
       public            postgres    false    228            �           2606    33726    diagnostico diagnostico_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.diagnostico
    ADD CONSTRAINT diagnostico_pkey PRIMARY KEY (id_diagnostico);
 F   ALTER TABLE ONLY public.diagnostico DROP CONSTRAINT diagnostico_pkey;
       public            postgres    false    229            �           2606    33480 ,   doctor_especialidad doctor_especialidad_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.doctor_especialidad
    ADD CONSTRAINT doctor_especialidad_pkey PRIMARY KEY (id_us_esp);
 V   ALTER TABLE ONLY public.doctor_especialidad DROP CONSTRAINT doctor_especialidad_pkey;
       public            postgres    false    224            �           2606    33703    doctor doctor_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_pkey PRIMARY KEY (id_doctor);
 <   ALTER TABLE ONLY public.doctor DROP CONSTRAINT doctor_pkey;
       public            postgres    false    223            �           2606    33486    especialidad especialidad_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.especialidad
    ADD CONSTRAINT especialidad_pkey PRIMARY KEY (id_especialidad);
 H   ALTER TABLE ONLY public.especialidad DROP CONSTRAINT especialidad_pkey;
       public            postgres    false    220            �           2606    33505 "   notificaciones notificaciones_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.notificaciones
    ADD CONSTRAINT notificaciones_pkey PRIMARY KEY (id_notificaciones);
 L   ALTER TABLE ONLY public.notificaciones DROP CONSTRAINT notificaciones_pkey;
       public            postgres    false    227            �           2606    33680    paciente paciente_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.paciente
    ADD CONSTRAINT paciente_pkey PRIMARY KEY (id_paciente);
 @   ALTER TABLE ONLY public.paciente DROP CONSTRAINT paciente_pkey;
       public            postgres    false    218            �           2606    33557    receta receta_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.receta
    ADD CONSTRAINT receta_pkey PRIMARY KEY (id_receta);
 <   ALTER TABLE ONLY public.receta DROP CONSTRAINT receta_pkey;
       public            postgres    false    230            �           2606    33565     tipo_consulta tipo_consulta_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.tipo_consulta
    ADD CONSTRAINT tipo_consulta_pkey PRIMARY KEY (id_tipo_consulta);
 J   ALTER TABLE ONLY public.tipo_consulta DROP CONSTRAINT tipo_consulta_pkey;
       public            postgres    false    219            �           2606    33669    tipo_usuario tipo_usuario_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.tipo_usuario
    ADD CONSTRAINT tipo_usuario_pkey PRIMARY KEY (id_tipo_usuario);
 H   ALTER TABLE ONLY public.tipo_usuario DROP CONSTRAINT tipo_usuario_pkey;
       public            postgres    false    216            �           2606    33624 0   usuario_centro_medico usuario_centro_medico_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.usuario_centro_medico
    ADD CONSTRAINT usuario_centro_medico_pkey PRIMARY KEY (id_us_cent);
 Z   ALTER TABLE ONLY public.usuario_centro_medico DROP CONSTRAINT usuario_centro_medico_pkey;
       public            postgres    false    225            �           2606    33630    usuario usuario_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public            postgres    false    221            �           2606    50216    consulta consulta_id_cita_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT consulta_id_cita_fkey FOREIGN KEY (id_cita) REFERENCES public.cita(id_cita);
 H   ALTER TABLE ONLY public.consulta DROP CONSTRAINT consulta_id_cita_fkey;
       public          postgres    false    226    4802    228            �           2606    50211    cita fk_tipo_consulta    FK CONSTRAINT     �   ALTER TABLE ONLY public.cita
    ADD CONSTRAINT fk_tipo_consulta FOREIGN KEY (id_tipo_consulta) REFERENCES public.tipo_consulta(id_tipo_consulta);
 ?   ALTER TABLE ONLY public.cita DROP CONSTRAINT fk_tipo_consulta;
       public          postgres    false    226    219    4788            �           2606    33296    accesos_usuario id_accesos_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.accesos_usuario
    ADD CONSTRAINT id_accesos_pk FOREIGN KEY (id_accesos) REFERENCES public.accesos(id_acessos);
 G   ALTER TABLE ONLY public.accesos_usuario DROP CONSTRAINT id_accesos_pk;
       public          postgres    false    4784    217    222            �           2606    33771    doctor id_centro_medico    FK CONSTRAINT     �   ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT id_centro_medico FOREIGN KEY (id_centro_medico) REFERENCES public.centro_medico(id_centro_medico);
 A   ALTER TABLE ONLY public.doctor DROP CONSTRAINT id_centro_medico;
       public          postgres    false    215    4780    223            �           2606    33751    usuario id_centro_medico_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT id_centro_medico_pk FOREIGN KEY (id_centro_medico) REFERENCES public.centro_medico(id_centro_medico);
 E   ALTER TABLE ONLY public.usuario DROP CONSTRAINT id_centro_medico_pk;
       public          postgres    false    215    4780    221            �           2606    33756 )   usuario_centro_medico id_centro_medico_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_centro_medico
    ADD CONSTRAINT id_centro_medico_pk FOREIGN KEY (id_centro_medico) REFERENCES public.centro_medico(id_centro_medico);
 S   ALTER TABLE ONLY public.usuario_centro_medico DROP CONSTRAINT id_centro_medico_pk;
       public          postgres    false    215    225    4780            �           2606    33761 #   accesos_usuario id_centro_medico_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.accesos_usuario
    ADD CONSTRAINT id_centro_medico_pk FOREIGN KEY (id_centro_medico) REFERENCES public.centro_medico(id_centro_medico);
 M   ALTER TABLE ONLY public.accesos_usuario DROP CONSTRAINT id_centro_medico_pk;
       public          postgres    false    215    222    4780            �           2606    33766    cita id_centro_medico_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.cita
    ADD CONSTRAINT id_centro_medico_pk FOREIGN KEY (id_centro_medico) REFERENCES public.centro_medico(id_centro_medico);
 B   ALTER TABLE ONLY public.cita DROP CONSTRAINT id_centro_medico_pk;
       public          postgres    false    215    4780    226            �           2606    33740    notificaciones id_cita_pk    FK CONSTRAINT     |   ALTER TABLE ONLY public.notificaciones
    ADD CONSTRAINT id_cita_pk FOREIGN KEY (id_cita) REFERENCES public.cita(id_cita);
 C   ALTER TABLE ONLY public.notificaciones DROP CONSTRAINT id_cita_pk;
       public          postgres    false    4802    227    226            �           2606    33413    diagnostico id_consulta_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.diagnostico
    ADD CONSTRAINT id_consulta_pk FOREIGN KEY (id_consulta) REFERENCES public.consulta(id_consulta);
 D   ALTER TABLE ONLY public.diagnostico DROP CONSTRAINT id_consulta_pk;
       public          postgres    false    4806    228    229            �           2606    33727    receta id_diagnostico_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.receta
    ADD CONSTRAINT id_diagnostico_pk FOREIGN KEY (id_diagnostico) REFERENCES public.diagnostico(id_diagnostico);
 B   ALTER TABLE ONLY public.receta DROP CONSTRAINT id_diagnostico_pk;
       public          postgres    false    230    4808    229            �           2606    42008    asistente_doctor id_doctor_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.asistente_doctor
    ADD CONSTRAINT id_doctor_fk FOREIGN KEY (id_doctor) REFERENCES public.doctor(id_doctor);
 G   ALTER TABLE ONLY public.asistente_doctor DROP CONSTRAINT id_doctor_fk;
       public          postgres    false    223    245    4796            �           2606    33704    cita id_doctor_pk    FK CONSTRAINT     z   ALTER TABLE ONLY public.cita
    ADD CONSTRAINT id_doctor_pk FOREIGN KEY (id_doctor) REFERENCES public.doctor(id_doctor);
 ;   ALTER TABLE ONLY public.cita DROP CONSTRAINT id_doctor_pk;
       public          postgres    false    4796    226    223            �           2606    33714     doctor_especialidad id_doctor_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.doctor_especialidad
    ADD CONSTRAINT id_doctor_pk FOREIGN KEY (id_doctor) REFERENCES public.doctor(id_doctor);
 J   ALTER TABLE ONLY public.doctor_especialidad DROP CONSTRAINT id_doctor_pk;
       public          postgres    false    4796    224    223            �           2606    33492 &   doctor_especialidad id_especialidad_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.doctor_especialidad
    ADD CONSTRAINT id_especialidad_pk FOREIGN KEY (id_especialidad) REFERENCES public.especialidad(id_especialidad);
 P   ALTER TABLE ONLY public.doctor_especialidad DROP CONSTRAINT id_especialidad_pk;
       public          postgres    false    224    220    4790            �           2606    33681    cita id_paciente_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.cita
    ADD CONSTRAINT id_paciente_pk FOREIGN KEY (id_paciente) REFERENCES public.paciente(id_paciente);
 =   ALTER TABLE ONLY public.cita DROP CONSTRAINT id_paciente_pk;
       public          postgres    false    218    4786    226            �           2606    33691    notificaciones id_paciente_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.notificaciones
    ADD CONSTRAINT id_paciente_pk FOREIGN KEY (id_paciente) REFERENCES public.paciente(id_paciente);
 G   ALTER TABLE ONLY public.notificaciones DROP CONSTRAINT id_paciente_pk;
       public          postgres    false    227    4786    218            �           2606    33670    usuario id_tipo_usuario_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT id_tipo_usuario_pk FOREIGN KEY (id_tipo_usuario) REFERENCES public.tipo_usuario(id_tipo_usuario);
 D   ALTER TABLE ONLY public.usuario DROP CONSTRAINT id_tipo_usuario_pk;
       public          postgres    false    221    216    4782            �           2606    33651    doctor id_usuario    FK CONSTRAINT     }   ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT id_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);
 ;   ALTER TABLE ONLY public.doctor DROP CONSTRAINT id_usuario;
       public          postgres    false    4792    223    221            �           2606    42003    asistente_doctor id_usuario_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.asistente_doctor
    ADD CONSTRAINT id_usuario_fk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);
 H   ALTER TABLE ONLY public.asistente_doctor DROP CONSTRAINT id_usuario_fk;
       public          postgres    false    4792    221    245            �           2606    33631 #   usuario_centro_medico id_usuario_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario_centro_medico
    ADD CONSTRAINT id_usuario_pk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);
 M   ALTER TABLE ONLY public.usuario_centro_medico DROP CONSTRAINT id_usuario_pk;
       public          postgres    false    225    4792    221            �           2606    33636    accesos_usuario id_usuario_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.accesos_usuario
    ADD CONSTRAINT id_usuario_pk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);
 G   ALTER TABLE ONLY public.accesos_usuario DROP CONSTRAINT id_usuario_pk;
       public          postgres    false    221    222    4792            �           2606    33641    cita id_usuario_pk    FK CONSTRAINT     ~   ALTER TABLE ONLY public.cita
    ADD CONSTRAINT id_usuario_pk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);
 <   ALTER TABLE ONLY public.cita DROP CONSTRAINT id_usuario_pk;
       public          postgres    false    226    221    4792            �           2606    33656    notificaciones id_usuario_pk    FK CONSTRAINT     �   ALTER TABLE ONLY public.notificaciones
    ADD CONSTRAINT id_usuario_pk FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);
 F   ALTER TABLE ONLY public.notificaciones DROP CONSTRAINT id_usuario_pk;
       public          postgres    false    4792    221    227            v      x������ � �      {      x������ � �      �   e   x����0�o<L/��qv���
�{�e$�7�ߪ�6X�v(�M�A�o�W�D'����B?�0:0kX���U�JeT忄>s�[9D�}ϙ��Z�]�!      t   ^   x�3�t�9�6/39Q�)1�J!8�$_AM��� 5931'3%1%���/3/�4/���ˈ�95��(_���ʔ��|�0�@j^bQf�B��#��=... {N X         �  x���Kn�0���)t�$)�'�&H� ��@� =~�v[��	���qF��!!	4�q�0U�
0�cx�i_T#�*�I�	&����zyB������d�$#�
u�b$ȗ%�m��$~���z}��%�'�qmHț����j��z���2�T���ߢ7Ƅ�;C��?6[�U�_u{�4���@v�"t(>J>�l~b�C�����׀:��P���������ٽ����/�9�Cޞ���̓����ݿ���H8�+�F�;�u�z���l�]	W�R~�Bn��x;�lG� ޟ�v��I'<���ZJ��Z%�#}ζlN����O�-ý_2gq�����ݳ
�ao���Vg��T.�LD�n;^�_$�::v�؍�G��7i��lܪ�Q����]_W��[�u��O+Rl�J{mRO�j,��iB�/�*�̅�k�bj�n�?W��$Ƈ1��V��      �   x  x����r�0���)���sLOm�L:����G_�S�-� ��M�=�G��U��e<���V���8dW�0��P�"ӽ��g�R��X	���t)�|�P-��%f��.���B펮��jЇ����P�|�Uh3���"VT���,���g�� �,��Q��kX<9�� ��k�*���H2 ��R���?�f�9��U�hp�|��f�;�/b�'>@�F�u:c�n%����[ѩtl�v$+��0S�S�gպ[���<�?I�o���m�z<�P�2P�]I�;]�G1\˺#��$}��gENn �ȃ,f�r�%m@Da"L�8�zɄ�5��֢>ө�����
��F�-;� պ��8Μ��(�Ƭ����Y���*G�ϝg�0��FjWw�¶�wI|�B�����;�w��Dl�%C'�	�K��m��&Y�Q:�e��ej?
�xh�"Kإ��#x���v�],�cؔ�X��
��My��n��$���v���s��N%�i�O�� �H6���!"e7.�V���5TJ�Nt��Y(Z���Ԡ���+��Iă�����,p���|��1�߆2�F�!q��\���� 7��zH����<�/�,)f      �      x������ � �      |     x�EQ��0{+��aYZ�t���yD-JQ�5W�弄HK��{�$��r�C�Z�k�|ހ�͖�aܒCb��MJ��8?�"���K7��&&���0��YmIؙ����/R��8�xH�Y�t�|r�(�I@�@����`�����:�8��)�e��)Q�Y�I�Ť瓜ϰ�-N;�u/�Y�J�k�9�����ĸ��J01��\~��:��K-w@�2��Ᏹﾃ.`��G
�@׸�I�y]����`U      }   �   x�-�ˑ1C�r0S�ƿ\&�ɿV{�ײ@@tl�ZbM�G��nm�mmL�S�"W��T�p�鐶�Z�ޑ�8�L��m�[&�*09�+m ni�Wt���R?5v>�4� '7q��oq����|]ES$�V���Q�'�
h�E�z:ׯ�nLa����(d�<��݅Y�-��[��M�F�?,���Z�lOD�      y     x��V�n7<����"����đ#�\z9�Qr����>��:?�j�>4�>�̒����n���R<��B7~$�6W˔9G�B�;6���L�ƑI�Jk"1��fYm���GN#޺�f���p��H��З�b��V������?9R�^�c��o8��R�	��$���C47ܳΛ|����b+��7i`�w���_y~m�����k�J���H87L9� ޓ����B���kC̭3�$@_�Qr/���� ��)bE3y���%ަ�,�绅Ӓ�na,-�9=Q�O4/�������bm���T��4�I��OJ�N9���}P򤑷��	jcq�ТҼ�jN��yn"*O��ݩm�Ԭt���͕�������/Aa��g��C/!s�Aha"��7 �:E�i����K0�xHMm�c�Y�94��ay�c��%J���
y;~쨭�tqѼ��h��|-�n��3�Ȏ�>�֠����_i�V�C�QF�K�:<�(K�fu�;�n�x�\��Z�7Z��@������C��B���Q����!F�V�y@ԷJ�y�Ϗ.v�jz䩁�����D;u�B��'hѪ�sm����A�M�h���h=��J_1j�� �/^r�q�z��	}_��KAT��Z���N�:p5�ǫ�g(�qgdg\�D�e� �<e\Cm/�Eڗ��gh��tT
0Ѵ%��Ꞇ2�WA)˭L�K:��;No���i����ƯLK��s�-�t�K^"��x?�؅��at����y�����n�Q����y�z+x2��1��	5�6bJ��4<�R��ª�9�)'�p��?C��f�)$6$�'՚�c��T�'�Lp�~Wд	e�A?7q�'��.�]+�f���4ﯣ����=��斕�^Y�)q��\����z�"�U�T_5W�2�'_�vqj��G��}�!��d7�k~3����6Ӽ��IG�df��CE���y+�U0 HJ���������������      �      x������ � �      w   �  x��V�R9}_���n#i��ewS�ℂ�ݪ����0"s!3�$𶟳y��cۭc��

�����}���$3׆ɴ�=%�>�M��+߶�wD1��έ�2"cf&ܐ
�p�B;l��\(O��"�����!�,7�q��kS�:�v��ѿ�b���|�@NK8��[�R´UZZ#��8]k΍V�OQ�`�k����s�'a�|=o}��b�����������E>��{�	%2�^%�a�>t�L
+�ʹ 5~��i<�
X����KV^~��"��>�D: 3-��)�9�un|�Z-�e����ݰk'Y�@[�%�������[wL/}�.�+�iSM;��o�p�6tzL��}C@�C�K8���u��]�h�̾�{��#]�i��c�3�ԝ��g����+���2�FB�yn̄�	���]nؒ@�\W,˱虑��$�sR�Ӷ
s�����z�	 �\��2F��j�����*dĕ��ZԵ���/G~��i��4������зT1�h�}� ���� .2 �P ��|٫�.W��9P���]�O)�|\Z֦[���y"sC,ۜUf%��%�\H��S++r�Z��G���g�Ϛ6�elh��?@�3��8)�0���.ӆ��5�C��i���ӳ�}Y�~�������w_N����ڣKr3�M�s�̷��*\m�
�E�g�)��A�L��g(��UFΖ����Z=�ϙ:u׭��5c�_��������q�"��N��߳6PDdh�`�;a���ZO�����r�{@nH�k�����h&�d�����'���������^VZN���BWAG�����ʡ�|{!m	چ@�e���m�K.��)ThI瞞{�\4He3����R9�"�q7Vs	j�M��­�+��1�j�&!x�Kpm<:�H+5��L��e�> �8tU�����|c�����Ok�i�,c�q,K0,�{@�Ri}���F��o7�#[�C�Ҩ��L�.��!��WFU��!W�����-`�F9�qIp(�����J�ɷ��0}�>2�
h{���d٧"NZ+6t5̚�-ZI��ud}��l�mX,�`�Vg(�\[��	$���w�6����{����r̹����mӿ�z֘\���5�����	�G�v�	�-n��*p�>Vq۲�m�*�W����[sT
]��L��^(%:�r�j��>�b-�trtt�?mlw�      �      x������ � �      x   `  x�mT;r�0��S��$9B�"]f�2͊\3�hl�ƥW���byR{�I�~�o���[�VCa��SW�F�頦x��_��S�EȄ�,��LS����d4�q�q~�K;�^3{�
�u��G�%$�_��?j%e=�S�sKY8�S�$<���j^�H�ZW����J&�_cI#Sr���>h~�Jơ�;���wR� �@�th���.�+�Og(������'��l�1�z۞�d.<zO"�����*�/gс�F��K����s?	�r��bS�_�gMi�@ȗڇ�;��s��`�B�W��9�P�ڼ!Xk���*.i=�e�
�F�� BH4+���q��Kt�h�1q�s�<��0T������),j�ӄ����@
4.����6�cDG^����>����m*:6+����)�� �N�;B�f�7�'�Y�D�>-<�1yF<�><��W�4K)"��םSƤq���~V(�]��A�4�O
�=u���Ė��1O)\s�Vڤ0�/�!��R��SP� jYņ�4.�4��x?MY��z� ���I{��@
2�L�y�.M��\x�H�6�x�z���d���������l6� �*�      u   9   x�3�tL����,.)JL�/�,�2�t�O.3�9��2�y%�
e%�e�@�=... ��I      z     x��X�n�6>�O�/�E�OǙ����b��B�L�<�iH�	2o3�r��b[���v���l���*~�U�L����K�����)>���tG;��T��тU�ni�e��h�T��xF�4�����6�w��峫�0��k�Eah��`�sª��a:�^ܻ�}E�kYr�\�-��ɭl���?���RP	v��p���s���~s�w�qm���6�%m�-�,6Q�F��pZ�͟�}!e��4�����>?�v�����[*/l����0��i�-h��ے��6��qi���,������^
Iy�x)�R��Ne1<q�ҙ�q�eI�/�n�*���`FUDjo������X�il�/��d1�|��UƤ�
AZ��r! ��`�x�R�h���ПF7�)�ބ�6
c��:�g1��e���b � ��	J9#*���=Ab�����O	�Fj^����~D�C�_���忳�
EK��.�T��v!�d7�n��n��3�_�����:��&j��h��<�2�`2��P��Uq��;{���'�N�����=Y�#ee�RG�p���x�jc�2�&N�>t���5l��$�L6$"� l�Ӂ*�0k��U���0Wq�����z��6�������9�+Ɉ0���b��xj�%�U��" �4 ޜl��0�g��>��\˘����`�fl�G�nnZm�X��ѵ��[�	|�T/�.��ɠ�\-۰a�ګ�>��ŗ��!+�b��	�J�Eq�} &@"
F�sޏ3��W�1V1�J�G�����A���<�~��A?�� �����iWHR�=^�>�
�&ֶ������쵪����9ء�#�m�v�d�@r\�28�1�� B��n<�`��:�v�f_��u�]�>JE 
�Tb^D#����Н�MH��;����X��>p{S!����i�`5���}\H�� ���iTL�~DH��An�9{��XJ�C�	�U��/Hj��@�d"h=:��N�T��
��RJ�HP�|v���}�hWQhZb�E�,HO��~"h��~!˲��ߜKId�<n���v�xo����E�cF N���%xu�a��[~碩A&�kD0z�
>�2��G�a׾a�Y0y�7i8�M�[�T�+3�&dD�<�����k����I�o[Yf�9,���`㫮���qC`��/�0fnK	�x?:�~+~^&yط%�
�.���"&ҟԊ��rΰ�%�&�?!����j��4ANedߍ漏
���ٸ�%b��Qz��'�!�.0�a�X	��a�iS�s�sO�2�{��
��lv5�t=u*$�=R���翎����//��c�o�@�,7�����p[b#�~v�����k� �؀�U�'���p���l����B�*�����'�@$�{w��feP��˪��e����vS)9_*�;��e:�/ú�ok!��y���[�/�}����9��\�[�~-g����/���e���-�m�j/�n�a��ep�u$�����ش��͙�V�� q&םUTؿ��,��e+�| 9MX�W������m�ٛ���:A�ױ�����D���2=γ�X�6�0P����O�4ۛ�w�];��$Į�`��C�^��y�M׌nu��I����;��g���_�殁�c��_@b*|���+F����/l-ca����po�a���%�C	�Ed����#jd�+��_l��C(�o
���[
��vp)8|28�j�*�B���A��i/�Z�E�vcu����(���6z�o�>� u����V�.J{��\�.;�x�̤B�1��lHB�yg���%�g����1�y��J����~�" ��,��_k�^����[�5��F���A�R@�e<����o�W/���iߕ.�3B���k�I+\�\��L3�����d����#���^Z���b:~^��]����at�?�P��/
���t>ٮ���й	�c�Ц�/:y>��d�4��f��N\�C���!��LOh      ~      x������ � �     