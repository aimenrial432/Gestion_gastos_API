-- phpMyAdmin SQL Dump
-- version 5.0.4deb2ubuntu5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 29-03-2022 a las 09:05:58
-- Versión del servidor: 10.5.15-MariaDB-0ubuntu0.21.10.1
-- Versión de PHP: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `wp_Gestion_Gastos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bda_Conexiones`
--

CREATE TABLE `bda_Conexiones` (
  `Id_conexion` int(11) NOT NULL,
  `Id_user` int(11) DEFAULT NULL,
  `Fecha` datetime NOT NULL,
  `Ip` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `bda_Conexiones`
--

INSERT INTO `bda_Conexiones` (`Id_conexion`, `Id_user`, `Fecha`, `Ip`) VALUES
(1, 5, '2022-01-05 12:05:09', '192.168.233.1'),
(2, 5, '2022-01-05 12:06:11', '192.168.233.1'),
(3, 5, '2022-01-05 12:16:57', '192.168.233.1'),
(4, 5, '2022-01-05 12:34:16', '192.168.233.1'),
(5, 5, '2022-01-06 10:55:05', '192.168.233.1'),
(6, 6, '2022-01-06 10:55:51', '192.168.233.1'),
(7, 6, '2022-01-06 10:56:33', '192.168.233.1'),
(8, 6, '2022-01-06 11:59:06', '192.168.233.1'),
(10, 6, '2022-01-06 16:09:23', '192.168.233.1'),
(11, 5, '2022-01-26 12:38:56', '192.168.233.1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bda_Departamentos`
--

CREATE TABLE `bda_Departamentos` (
  `Departamento_Id` int(11) NOT NULL,
  `Nombre_dep` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `bda_Departamentos`
--

INSERT INTO `bda_Departamentos` (`Departamento_Id`, `Nombre_dep`) VALUES
(1, 'Administración'),
(2, 'Desarrollo'),
(3, 'Mantenimiento'),
(4, 'Transportes');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bda_Empleados`
--

CREATE TABLE `bda_Empleados` (
  `Id_user` int(11) NOT NULL,
  `DNI` varchar(9) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `Apellido` varchar(50) NOT NULL,
  `E_mail` varchar(250) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Password_hash` varchar(255) NOT NULL,
  `Fecha_reg` datetime DEFAULT NULL,
  `Departamento_Id` int(11) NOT NULL,
  `Id_rol` int(11) NOT NULL,
  `Estado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `bda_Empleados`
--

INSERT INTO `bda_Empleados` (`Id_user`, `DNI`, `Nombre`, `Apellido`, `E_mail`, `Username`, `Password_hash`, `Fecha_reg`, `Departamento_Id`, `Id_rol`, `Estado`) VALUES
(5, '12345678', 'Admin', 'wp_Gestion', 'admin.wpGestion@dominioprueba.com', 'admin_wp_GG', '$2y$10$uyJdGXXwbfSxl5dlNYalz.vLCrsNnWc9Ju2HyfpQ18JlUXEUo0j3q', '2022-01-04 14:34:01', 1, 1, 1),
(6, '11223344T', 'Sujeto', 'Pruebas', 'user_pruebas@dominioprueba.com', 'user_pruebas', '$2y$10$Pe2JTxDgMjhbnBmvkSgZcuLBswlv27Vbeea8KhVOGNsvhYvAl/TF6', '2022-01-06 16:08:24', 3, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bda_Gastos`
--

CREATE TABLE `bda_Gastos` (
  `Gasto_Id` int(11) NOT NULL,
  `Id_user` int(11) DEFAULT NULL,
  `Proyecto_Id` int(11) DEFAULT NULL,
  `Departamento_Id` int(11) DEFAULT NULL,
  `Fecha_inicio` date DEFAULT NULL,
  `Fecha_fin` date DEFAULT NULL,
  `Transporte` varchar(50) DEFAULT NULL,
  `Distancia` decimal(7,2) DEFAULT NULL,
  `Parking` decimal(7,2) DEFAULT NULL,
  `Peaje` decimal(7,2) DEFAULT NULL,
  `Pais` varchar(50) DEFAULT NULL,
  `Ciudad` varchar(50) DEFAULT NULL,
  `Costo` decimal(7,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bda_Integrantes`
--

CREATE TABLE `bda_Integrantes` (
  `Proyecto_Id` int(11) NOT NULL,
  `Id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bda_Nothing_Interesting`
--

CREATE TABLE `bda_Nothing_Interesting` (
  `Id_string` int(11) NOT NULL,
  `Id_user` int(11) DEFAULT NULL,
  `Generated_string` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `bda_Nothing_Interesting`
--

INSERT INTO `bda_Nothing_Interesting` (`Id_string`, `Id_user`, `Generated_string`) VALUES
(1, 5, '{/%^F&/`lj)0\"!(Cts)US[=78%!T!\'\"a'),
(2, 6, 'F/yG/|k\"}Hq{&P1^8,^}KiaC\\#1-X>uP'),
(3, 6, '#RcfcRO/10&QE9wlvcOMx5|(\'cWcFU3>');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bda_Proyectos`
--

CREATE TABLE `bda_Proyectos` (
  `Proyecto_Id` int(11) NOT NULL,
  `Descripcion` varchar(255) NOT NULL,
  `Fecha_inicio` date NOT NULL,
  `Fecha_fin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bda_Registro_horas`
--

CREATE TABLE `bda_Registro_horas` (
  `Id_registro` int(11) NOT NULL,
  `Id_user` int(11) DEFAULT NULL,
  `Dia` date NOT NULL,
  `Semana` int(11) NOT NULL,
  `Horas` float NOT NULL,
  `Proyecto_Id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bda_Roles`
--

CREATE TABLE `bda_Roles` (
  `Id_rol` int(11) NOT NULL,
  `Rol` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `bda_Roles`
--

INSERT INTO `bda_Roles` (`Id_rol`, `Rol`) VALUES
(1, 'Administrador'),
(2, 'Empleado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bda_Tarjetas`
--

CREATE TABLE `bda_Tarjetas` (
  `Id_tarjeta` int(11) NOT NULL,
  `Id_user` int(11) DEFAULT NULL,
  `Numero_eu` varchar(16) NOT NULL,
  `Numero_int` varchar(16) NOT NULL,
  `Card_code` varchar(4) NOT NULL,
  `Card_pin` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `bda_Tarjetas`
--

INSERT INTO `bda_Tarjetas` (`Id_tarjeta`, `Id_user`, `Numero_eu`, `Numero_int`, `Card_code`, `Card_pin`) VALUES
(1, 5, '4497362235902658', '49373841485299', '8045', '095'),
(2, 6, '9552520936794979', '32461436618530', '7194', '074');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bda_UsesEurope`
--

CREATE TABLE `bda_UsesEurope` (
  `Id_use` int(11) NOT NULL,
  `Id_tarjeta` int(11) NOT NULL,
  `Fecha_eur` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `bda_UsesEurope`
--

INSERT INTO `bda_UsesEurope` (`Id_use`, `Id_tarjeta`, `Fecha_eur`) VALUES
(1, 2, '2022-01-08 20:11:20'),
(2, 1, '2022-01-08 20:19:35'),
(3, 2, '2022-01-08 20:19:45'),
(4, 1, '2022-01-08 20:19:57'),
(5, 2, '2022-01-08 20:20:05'),
(6, 1, '2022-01-08 20:20:57');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bda_UsesInt`
--

CREATE TABLE `bda_UsesInt` (
  `Id_use` int(11) NOT NULL,
  `Id_tarjeta` int(11) NOT NULL,
  `Fecha_int` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `bda_UsesInt`
--

INSERT INTO `bda_UsesInt` (`Id_use`, `Id_tarjeta`, `Fecha_int`) VALUES
(1, 2, '2022-01-08 20:11:22'),
(2, 1, '2022-01-08 20:19:38'),
(3, 2, '2022-01-08 20:19:47'),
(4, 1, '2022-01-08 20:19:58'),
(5, 2, '2022-01-08 20:20:07'),
(6, 1, '2022-01-08 20:20:59');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `Vista_EmpleadosFK`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `Vista_EmpleadosFK` (
`Id_user` int(11)
,`DNI` varchar(9)
,`Nombre` varchar(50)
,`Apellido` varchar(50)
,`e_mail` varchar(250)
,`Username` varchar(50)
,`Fecha_reg` datetime
,`Departamento_Id` int(11)
,`Nombre_dep` varchar(50)
,`Id_rol` int(11)
,`Rol` varchar(20)
,`Estado` tinyint(1)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `Vista_EmpleadosFK`
--
DROP TABLE IF EXISTS `Vista_EmpleadosFK`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin_wp_GG`@`%` SQL SECURITY DEFINER VIEW `Vista_EmpleadosFK`  AS SELECT `bda_Empleados`.`Id_user` AS `Id_user`, `bda_Empleados`.`DNI` AS `DNI`, `bda_Empleados`.`Nombre` AS `Nombre`, `bda_Empleados`.`Apellido` AS `Apellido`, `bda_Empleados`.`E_mail` AS `e_mail`, `bda_Empleados`.`Username` AS `Username`, `bda_Empleados`.`Fecha_reg` AS `Fecha_reg`, `bda_Empleados`.`Departamento_Id` AS `Departamento_Id`, `bda_Departamentos`.`Nombre_dep` AS `Nombre_dep`, `bda_Empleados`.`Id_rol` AS `Id_rol`, `bda_Roles`.`Rol` AS `Rol`, `bda_Empleados`.`Estado` AS `Estado` FROM ((`bda_Empleados` join `bda_Departamentos` on(`bda_Empleados`.`Departamento_Id` = `bda_Departamentos`.`Departamento_Id`)) join `bda_Roles` on(`bda_Empleados`.`Id_rol` = `bda_Roles`.`Id_rol`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bda_Conexiones`
--
ALTER TABLE `bda_Conexiones`
  ADD PRIMARY KEY (`Id_conexion`),
  ADD KEY `Id_user` (`Id_user`);

--
-- Indices de la tabla `bda_Departamentos`
--
ALTER TABLE `bda_Departamentos`
  ADD PRIMARY KEY (`Departamento_Id`);

--
-- Indices de la tabla `bda_Empleados`
--
ALTER TABLE `bda_Empleados`
  ADD PRIMARY KEY (`Id_user`),
  ADD UNIQUE KEY `DNI` (`DNI`),
  ADD KEY `Departamento_Id` (`Departamento_Id`),
  ADD KEY `Id_rol` (`Id_rol`);

--
-- Indices de la tabla `bda_Gastos`
--
ALTER TABLE `bda_Gastos`
  ADD PRIMARY KEY (`Gasto_Id`),
  ADD KEY `Id_user` (`Id_user`),
  ADD KEY `Proyecto_Id` (`Proyecto_Id`),
  ADD KEY `Departamento_Id` (`Departamento_Id`);

--
-- Indices de la tabla `bda_Integrantes`
--
ALTER TABLE `bda_Integrantes`
  ADD PRIMARY KEY (`Proyecto_Id`,`Id_user`),
  ADD KEY `Id_user` (`Id_user`);

--
-- Indices de la tabla `bda_Nothing_Interesting`
--
ALTER TABLE `bda_Nothing_Interesting`
  ADD PRIMARY KEY (`Id_string`),
  ADD UNIQUE KEY `Generated_key` (`Generated_string`),
  ADD KEY `Id_user` (`Id_user`);

--
-- Indices de la tabla `bda_Proyectos`
--
ALTER TABLE `bda_Proyectos`
  ADD PRIMARY KEY (`Proyecto_Id`);

--
-- Indices de la tabla `bda_Registro_horas`
--
ALTER TABLE `bda_Registro_horas`
  ADD PRIMARY KEY (`Id_registro`),
  ADD KEY `Id_user` (`Id_user`),
  ADD KEY `Proyecto_Id` (`Proyecto_Id`);

--
-- Indices de la tabla `bda_Roles`
--
ALTER TABLE `bda_Roles`
  ADD PRIMARY KEY (`Id_rol`);

--
-- Indices de la tabla `bda_Tarjetas`
--
ALTER TABLE `bda_Tarjetas`
  ADD PRIMARY KEY (`Id_tarjeta`),
  ADD KEY `Id_user` (`Id_user`);

--
-- Indices de la tabla `bda_UsesEurope`
--
ALTER TABLE `bda_UsesEurope`
  ADD PRIMARY KEY (`Id_use`),
  ADD KEY `Id_tarjeta` (`Id_tarjeta`);

--
-- Indices de la tabla `bda_UsesInt`
--
ALTER TABLE `bda_UsesInt`
  ADD PRIMARY KEY (`Id_use`),
  ADD KEY `Id_tarjeta` (`Id_tarjeta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bda_Conexiones`
--
ALTER TABLE `bda_Conexiones`
  MODIFY `Id_conexion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `bda_Departamentos`
--
ALTER TABLE `bda_Departamentos`
  MODIFY `Departamento_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `bda_Empleados`
--
ALTER TABLE `bda_Empleados`
  MODIFY `Id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `bda_Gastos`
--
ALTER TABLE `bda_Gastos`
  MODIFY `Gasto_Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `bda_Nothing_Interesting`
--
ALTER TABLE `bda_Nothing_Interesting`
  MODIFY `Id_string` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `bda_Proyectos`
--
ALTER TABLE `bda_Proyectos`
  MODIFY `Proyecto_Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `bda_Registro_horas`
--
ALTER TABLE `bda_Registro_horas`
  MODIFY `Id_registro` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `bda_Roles`
--
ALTER TABLE `bda_Roles`
  MODIFY `Id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `bda_Tarjetas`
--
ALTER TABLE `bda_Tarjetas`
  MODIFY `Id_tarjeta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `bda_UsesEurope`
--
ALTER TABLE `bda_UsesEurope`
  MODIFY `Id_use` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `bda_UsesInt`
--
ALTER TABLE `bda_UsesInt`
  MODIFY `Id_use` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `bda_Conexiones`
--
ALTER TABLE `bda_Conexiones`
  ADD CONSTRAINT `bda_Conexiones_ibfk_1` FOREIGN KEY (`Id_user`) REFERENCES `bda_Empleados` (`Id_user`);

--
-- Filtros para la tabla `bda_Empleados`
--
ALTER TABLE `bda_Empleados`
  ADD CONSTRAINT `bda_Empleados_ibfk_1` FOREIGN KEY (`Departamento_Id`) REFERENCES `bda_Departamentos` (`Departamento_Id`),
  ADD CONSTRAINT `bda_Empleados_ibfk_2` FOREIGN KEY (`Id_Rol`) REFERENCES `bda_Roles` (`Id_Rol`);

--
-- Filtros para la tabla `bda_Gastos`
--
ALTER TABLE `bda_Gastos`
  ADD CONSTRAINT `bda_Gastos_ibfk_1` FOREIGN KEY (`Id_user`) REFERENCES `bda_Empleados` (`Id_user`),
  ADD CONSTRAINT `bda_Gastos_ibfk_2` FOREIGN KEY (`Proyecto_Id`) REFERENCES `bda_Proyectos` (`Proyecto_Id`),
  ADD CONSTRAINT `bda_Gastos_ibfk_3` FOREIGN KEY (`Departamento_Id`) REFERENCES `bda_Departamentos` (`Departamento_Id`);

--
-- Filtros para la tabla `bda_Integrantes`
--
ALTER TABLE `bda_Integrantes`
  ADD CONSTRAINT `bda_Integrantes_ibfk_1` FOREIGN KEY (`Proyecto_Id`) REFERENCES `bda_Proyectos` (`Proyecto_Id`),
  ADD CONSTRAINT `bda_Integrantes_ibfk_2` FOREIGN KEY (`Id_user`) REFERENCES `bda_Empleados` (`Id_user`);

--
-- Filtros para la tabla `bda_Nothing_Interesting`
--
ALTER TABLE `bda_Nothing_Interesting`
  ADD CONSTRAINT `bda_Nothing_Interesting_ibfk_1` FOREIGN KEY (`Id_user`) REFERENCES `bda_Empleados` (`Id_user`);

--
-- Filtros para la tabla `bda_Registro_horas`
--
ALTER TABLE `bda_Registro_horas`
  ADD CONSTRAINT `bda_Registro_horas_ibfk_1` FOREIGN KEY (`Id_user`) REFERENCES `bda_Empleados` (`Id_user`),
  ADD CONSTRAINT `bda_Registro_horas_ibfk_2` FOREIGN KEY (`Proyecto_Id`) REFERENCES `bda_Proyectos` (`Proyecto_Id`);

--
-- Filtros para la tabla `bda_Tarjetas`
--
ALTER TABLE `bda_Tarjetas`
  ADD CONSTRAINT `bda_Tarjetas_ibfk_1` FOREIGN KEY (`Id_user`) REFERENCES `bda_Empleados` (`Id_user`);

--
-- Filtros para la tabla `bda_UsesEurope`
--
ALTER TABLE `bda_UsesEurope`
  ADD CONSTRAINT `bda_UsesEurope_ibfk_1` FOREIGN KEY (`Id_tarjeta`) REFERENCES `bda_Tarjetas` (`Id_tarjeta`);

--
-- Filtros para la tabla `bda_UsesInt`
--
ALTER TABLE `bda_UsesInt`
  ADD CONSTRAINT `bda_UsesInt_ibfk_1` FOREIGN KEY (`Id_tarjeta`) REFERENCES `bda_Tarjetas` (`Id_tarjeta`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
