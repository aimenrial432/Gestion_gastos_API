-- El siguiente script edita y crea las diferentes tablas para la aplicación web y movil del proyecto

use Gestion_Gastos_Beta;

-- La siguiente sententecia sirve para recrear las tablas de la base de datos si es necesario
 SET FOREIGN_KEY_CHECKS = 0;

-- Se crea la tabla empleados a partir de la de wggbt_users

-- Tabla Empleados mas el usuario administrador----------------

create table bda_Empleados (

	Id_user int primary key auto_increment,
	DNI varchar(9) unique not null,
	Nombre varchar(50) not null,
	Apellido varchar(50) not null,
	E_mail varchar(250) not null,
	Username varchar(50) not null,
	Password_hash varchar(255) not null,
	Fecha_reg datetime, -- Este dato se inserta mediante la función now al registrrar un nuevo empleado
   	Departamento_Id int not null,
	Id_rol int not null,
    Estado tinyint(1)

);

-- Tabla Roles--------------------

create table bda_Roles (
	Id_rol int auto_increment primary key,
    Rol varchar(20) not null

);


-- Tabla conexiones--------------------

create table bda_Conexiones (
	
    Id_conexion int primary key auto_increment,
    Id_user int,
    Fecha datetime not null, -- Registrara las conexiones de los usuarios. Para saber la última conexión
    Ip varchar(50) not null

);

-- Tabla Departamentos----------------

create table bda_Departamentos (
	
    Departamento_Id int auto_increment primary key,
    Nombre_dep varchar(50) not null

);

-- Tabla proyectos---------

create table bda_Proyectos (
	
    Proyecto_Id int auto_increment primary key,
    Descripcion varchar(255) not null,
    Fecha_inicio Date not null,
    Fecha_fin Date

);

-- Tabla integrantes---------------

create table bda_Integrantes (
	
    Proyecto_Id int,
    Id_user int

);

-- Tabla Registro de horas ----------------

CREATE TABLE bda_Registro_horas (
	
    Id_registro int primary key auto_increment,
	Id_user int,
	Dia date not null,
	Semana int(11) not null,
	Horas float not null,
	Proyecto_Id int(11)
    
    );
    
    -- Tabla gastos------------------
   CREATE TABLE bda_Gastos (
   
	Gasto_Id int auto_increment primary key,
    Id_user int,
	Proyecto_Id int,
    Departamento_Id int,
	Fecha_inicio date,
    Fecha_fin date,
    Transporte varchar(50),
    Distancia decimal(7,2),
    Parking decimal (7,2),
    Peaje decimal (7,2),
	Pais varchar(50) ,
	Ciudad varchar(50),
    Costo decimal(7,2)
    
  );
  
  
-- Prymary keys no definidas al crear la tabla

	-- Tabla integrantes
    alter table bda_Integrantes add primary key (Proyecto_Id, Id_user);
  
-- Foreign keys de las tablas creadas

	-- Tabla bda_Empledos
    alter table bda_Empleados add foreign key (Departamento_Id) references bda_Departamentos(Departamento_Id);
    alter table bda_Empleados add foreign key (Id_Rol) references bda_Roles(Id_Rol);
    
    -- Tabla bda_Conexiones
    alter table bda_Conexiones add foreign key (Id_user) references bda_Empleados(Id_user);
    
    -- Tabla bda_Integrantes
    alter table bda_Integrantes add foreign key (Proyecto_Id) references bda_Proyectos (Proyecto_Id);
    alter table bda_Integrantes add foreign key (Id_user) references bda_Empleados (Id_user);
    
    -- Tabla bda_Registro_horas
    alter table bda_Registro_horas add foreign key (Id_user) references bda_Empleados(Id_user);
    alter table bda_Registro_horas add foreign key (Proyecto_Id) references bda_Proyectos(Proyecto_Id);
    
    -- Tabla bda_Gastos
    alter table bda_Gastos add foreign key (Id_user) references bda_Empleados(Id_user);
    alter table bda_Gastos add foreign key (Proyecto_Id) references bda_Proyectos (Proyecto_Id);
	alter table bda_Gastos add foreign key (Departamento_Id) references bda_Departamentos(Departamento_Id);





