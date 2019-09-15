/*
 Navicat Premium Data Transfer

 Source Server         : 3306
 Source Server Type    : MySQL
 Source Server Version : 50051
 Source Host           : localhost:3306
 Source Schema         : zapato

 Target Server Type    : MySQL
 Target Server Version : 50051
 File Encoding         : 65001

 Date: 13/06/2019 10:20:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cargo
-- ----------------------------
DROP TABLE IF EXISTS `cargo`;
CREATE TABLE `cargo`  (
  `idcargo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcionCargo` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `statusCargo` tinyint(4) NOT NULL,
  PRIMARY KEY USING BTREE (`idcargo`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cargo
-- ----------------------------
INSERT INTO `cargo` VALUES (1, 'VENDEDOR', 1);
INSERT INTO `cargo` VALUES (2, 'JEFE', 1);
INSERT INTO `cargo` VALUES (3, 'CLIENTE', 1);

-- ----------------------------
-- Table structure for color
-- ----------------------------
DROP TABLE IF EXISTS `color`;
CREATE TABLE `color`  (
  `idcolor` int(11) NOT NULL AUTO_INCREMENT,
  `color` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `statusColor` tinyint(4) NOT NULL,
  PRIMARY KEY USING BTREE (`idcolor`)
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of color
-- ----------------------------
INSERT INTO `color` VALUES (1, 'NEGRO', 1);
INSERT INTO `color` VALUES (2, 'BLANCO', 1);

-- ----------------------------
-- Table structure for compra
-- ----------------------------
DROP TABLE IF EXISTS `compra`;
CREATE TABLE `compra`  (
  `folioCompra` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `fechaCompra` date NOT NULL,
  `totalCompra` float NOT NULL,
  `clavePersonal` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY USING BTREE (`folioCompra`),
  INDEX `fk_compra_personal1_idx` USING BTREE(`clavePersonal`),
  CONSTRAINT `fk_compra_personal1` FOREIGN KEY (`clavePersonal`) REFERENCES `personal` (`clavePersonal`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'InnoDB free: 9216 kB; (`clavePersonal`) REFER `zapato/personal`(`clavePersonal`)' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of compra
-- ----------------------------
INSERT INTO `compra` VALUES ('COMPRA1', '2019-06-10', 2500, 'LONG3212');
INSERT INTO `compra` VALUES ('COMPRA2', '2019-06-11', 1200, 'LONG3212');
INSERT INTO `compra` VALUES ('COMPRA3', '2019-06-13', 1500, 'LONG3212');

-- ----------------------------
-- Table structure for detallecompra
-- ----------------------------
DROP TABLE IF EXISTS `detallecompra`;
CREATE TABLE `detallecompra`  (
  `idDetalleCompra` int(11) NOT NULL AUTO_INCREMENT,
  `cantidadCompra` float NOT NULL,
  `precioCompra` float NOT NULL,
  `folioCompra` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `codigoZapato` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY USING BTREE (`idDetalleCompra`),
  INDEX `fk_detalleCompra_zapatos1_idx` USING BTREE(`codigoZapato`),
  INDEX `fk_detalleCompra_compra1_idx` USING BTREE(`folioCompra`),
  CONSTRAINT `fk_detalleCompra_zapatos1` FOREIGN KEY (`codigoZapato`) REFERENCES `zapato` (`codigoZapato`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_detalleCompra_compra1` FOREIGN KEY (`folioCompra`) REFERENCES `compra` (`folioCompra`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'InnoDB free: 9216 kB; (`codigoZapato`) REFER `zapato/zapato`(`codigoZapato`); (`' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of detallecompra
-- ----------------------------
INSERT INTO `detallecompra` VALUES (1, 5, 300, 'COMPRA1', 'ZAP1RJE');
INSERT INTO `detallecompra` VALUES (16, 4, 300, 'COMPRA2', 'ZAPATO2');
INSERT INTO `detallecompra` VALUES (17, 5, 300, 'COMPRA3', 'ZAPATO3');

-- ----------------------------
-- Table structure for detalleformapago
-- ----------------------------
DROP TABLE IF EXISTS `detalleformapago`;
CREATE TABLE `detalleformapago`  (
  `idDetalleFormaPago` int(11) NOT NULL AUTO_INCREMENT,
  `monto` float NOT NULL,
  `folioVenta` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `idFormaPago` int(11) NOT NULL,
  PRIMARY KEY USING BTREE (`idDetalleFormaPago`),
  INDEX `fk_detalleFormaPago_venta1_idx` USING BTREE(`folioVenta`),
  INDEX `fk_detalleFormaPago_formaPago1_idx` USING BTREE(`idFormaPago`),
  CONSTRAINT `fk_detalleFormaPago_venta1` FOREIGN KEY (`folioVenta`) REFERENCES `venta` (`folioVenta`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_detalleFormaPago_formaPago1` FOREIGN KEY (`idFormaPago`) REFERENCES `formapago` (`idFormaPago`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'InnoDB free: 9216 kB; (`folioVenta`) REFER `zapato/venta`(`folioVenta`); (`idFor' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of detalleformapago
-- ----------------------------
INSERT INTO `detalleformapago` VALUES (1, 500, 'VENTA1', 1);
INSERT INTO `detalleformapago` VALUES (2, 400, 'VENTA1', 2);
INSERT INTO `detalleformapago` VALUES (3, 600, 'VENTA3', 1);
INSERT INTO `detalleformapago` VALUES (4, 300, 'VENTA3', 2);

-- ----------------------------
-- Table structure for detalleventa
-- ----------------------------
DROP TABLE IF EXISTS `detalleventa`;
CREATE TABLE `detalleventa`  (
  `idDetalleVenta` int(11) NOT NULL AUTO_INCREMENT,
  `cantidadVenta` int(11) NULL DEFAULT NULL,
  `precioVendido` float NULL DEFAULT NULL,
  `folioVenta` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `codigoZapato` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY USING BTREE (`idDetalleVenta`),
  INDEX `fk_detalleVenta_zapatos1_idx` USING BTREE(`codigoZapato`),
  INDEX `fk_detalleVenta_venta1_idx` USING BTREE(`folioVenta`),
  CONSTRAINT `fk_detalleVenta_zapatos1` FOREIGN KEY (`codigoZapato`) REFERENCES `zapato` (`codigoZapato`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_detalleVenta_venta1` FOREIGN KEY (`folioVenta`) REFERENCES `venta` (`folioVenta`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'InnoDB free: 9216 kB; (`codigoZapato`) REFER `zapato/zapato`(`codigoZapato`); (`' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of detalleventa
-- ----------------------------
INSERT INTO `detalleventa` VALUES (1, 3, 300, 'VENTA1', 'ZAP1RJE');
INSERT INTO `detalleventa` VALUES (3, 2, 390, 'VENTA3', 'ZAPATO2');
INSERT INTO `detalleventa` VALUES (6, 1, 390, 'VENTA4', 'ZAPATO2');
INSERT INTO `detalleventa` VALUES (7, 1, 390, 'VENTA5', 'ZAPATO3');

-- ----------------------------
-- Table structure for formapago
-- ----------------------------
DROP TABLE IF EXISTS `formapago`;
CREATE TABLE `formapago`  (
  `idFormaPago` int(11) NOT NULL AUTO_INCREMENT,
  `descripcionPago` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `statusPago` tinyint(4) NOT NULL,
  PRIMARY KEY USING BTREE (`idFormaPago`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of formapago
-- ----------------------------
INSERT INTO `formapago` VALUES (1, 'EFECTIVO', 1);
INSERT INTO `formapago` VALUES (2, 'TARJETA', 1);
INSERT INTO `formapago` VALUES (3, 'CREDITO', 1);

-- ----------------------------
-- Table structure for garantia
-- ----------------------------
DROP TABLE IF EXISTS `garantia`;
CREATE TABLE `garantia`  (
  `idgarantia` int(11) NOT NULL AUTO_INCREMENT,
  `descripcionGarantia` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `idtipoGarantia` int(11) NOT NULL,
  `clavePersonal` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `folioVenta` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY USING BTREE (`idgarantia`),
  INDEX `fk_garantia_tipoGarantia1_idx` USING BTREE(`idtipoGarantia`),
  INDEX `fk_garantia_personal1_idx` USING BTREE(`clavePersonal`),
  INDEX `fk_garantia_venta1_idx` USING BTREE(`folioVenta`),
  CONSTRAINT `fk_garantia_venta1` FOREIGN KEY (`folioVenta`) REFERENCES `venta` (`folioVenta`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_garantia_personal1` FOREIGN KEY (`clavePersonal`) REFERENCES `personal` (`clavePersonal`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_garantia_tipoGarantia1` FOREIGN KEY (`idtipoGarantia`) REFERENCES `tipogarantia` (`idtipoGarantia`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'InnoDB free: 9216 kB; (`folioVenta`) REFER `zapato/venta`(`folioVenta`); (`clave' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of garantia
-- ----------------------------
INSERT INTO `garantia` VALUES (1, 'MAL-COSTURA', 1, 'LONG3212', 'VENTA1');
INSERT INTO `garantia` VALUES (2, 'ROTO', 2, 'LONG3212', 'VENTA3');

-- ----------------------------
-- Table structure for marca
-- ----------------------------
DROP TABLE IF EXISTS `marca`;
CREATE TABLE `marca`  (
  `idmarca` int(11) NOT NULL AUTO_INCREMENT,
  `marca` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `statusMarca` tinyint(4) NOT NULL,
  PRIMARY KEY USING BTREE (`idmarca`)
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of marca
-- ----------------------------
INSERT INTO `marca` VALUES (1, 'PATITO', 1);
INSERT INTO `marca` VALUES (2, 'PATITO2', 1);
INSERT INTO `marca` VALUES (4, 'LADY', 1);

-- ----------------------------
-- Table structure for material
-- ----------------------------
DROP TABLE IF EXISTS `material`;
CREATE TABLE `material`  (
  `idmaterial` int(11) NOT NULL AUTO_INCREMENT,
  `material` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `statusMaterial` tinyint(4) NOT NULL,
  PRIMARY KEY USING BTREE (`idmaterial`)
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of material
-- ----------------------------
INSERT INTO `material` VALUES (1, 'PIEL', 1);
INSERT INTO `material` VALUES (2, 'SINTETICO', 1);

-- ----------------------------
-- Table structure for personal
-- ----------------------------
DROP TABLE IF EXISTS `personal`;
CREATE TABLE `personal`  (
  `clavePersonal` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nombre` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `apellidoUno` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `apellidoDos` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `usuario` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `contrasena` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `statusPersonal` tinyint(4) NOT NULL,
  `idcargo` int(11) NOT NULL,
  PRIMARY KEY USING BTREE (`clavePersonal`),
  INDEX `fk_personal_cargo1_idx` USING BTREE(`idcargo`),
  CONSTRAINT `fk_personal_cargo1` FOREIGN KEY (`idcargo`) REFERENCES `cargo` (`idcargo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'InnoDB free: 9216 kB; (`idcargo`) REFER `zapato/cargo`(`idcargo`)' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of personal
-- ----------------------------
INSERT INTO `personal` VALUES ('ALT32TGD', 'ALAM', 'SUAREZ', 'ZAVALA', 'ALIM', 'ALIM1234', 1, 1);
INSERT INTO `personal` VALUES ('LONG3212', 'NOE', 'LOPEZ', 'GONZALES', 'NOE', 'AMIGOXD16', 1, 1);

-- ----------------------------
-- Table structure for tipogarantia
-- ----------------------------
DROP TABLE IF EXISTS `tipogarantia`;
CREATE TABLE `tipogarantia`  (
  `idtipoGarantia` int(11) NOT NULL AUTO_INCREMENT,
  `descripciontipoGarantia` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY USING BTREE (`idtipoGarantia`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tipogarantia
-- ----------------------------
INSERT INTO `tipogarantia` VALUES (1, 'CAMBIO');
INSERT INTO `tipogarantia` VALUES (2, 'DEVOLUCION');
INSERT INTO `tipogarantia` VALUES (3, 'CAMBIO1');

-- ----------------------------
-- Table structure for tipozapato
-- ----------------------------
DROP TABLE IF EXISTS `tipozapato`;
CREATE TABLE `tipozapato`  (
  `idtipoZapato` int(11) NOT NULL AUTO_INCREMENT,
  `descripcionZapato` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY USING BTREE (`idtipoZapato`)
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tipozapato
-- ----------------------------
INSERT INTO `tipozapato` VALUES (1, 'ZAPATILLA');
INSERT INTO `tipozapato` VALUES (2, 'ZAPATOVESTIR');

-- ----------------------------
-- Table structure for venta
-- ----------------------------
DROP TABLE IF EXISTS `venta`;
CREATE TABLE `venta`  (
  `folioVenta` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `fechaVenta` date NOT NULL,
  `totalVenta` float NOT NULL,
  `clavePersonal` varchar(8) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY USING BTREE (`folioVenta`),
  INDEX `fk_venta_personal1_idx` USING BTREE(`clavePersonal`),
  CONSTRAINT `fk_venta_personal1` FOREIGN KEY (`clavePersonal`) REFERENCES `personal` (`clavePersonal`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'InnoDB free: 9216 kB; (`clavePersonal`) REFER `zapato/personal`(`clavePersonal`)' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of venta
-- ----------------------------
INSERT INTO `venta` VALUES ('VENTA1', '2019-06-10', 900, 'LONG3212');
INSERT INTO `venta` VALUES ('VENTA3', '2019-06-11', 780, 'LONG3212');
INSERT INTO `venta` VALUES ('VENTA4', '2019-06-12', 390, 'LONG3212');
INSERT INTO `venta` VALUES ('VENTA5', '2019-06-13', 390, 'LONG3212');

-- ----------------------------
-- Table structure for zapato
-- ----------------------------
DROP TABLE IF EXISTS `zapato`;
CREATE TABLE `zapato`  (
  `codigoZapato` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `estilo` int(11) NOT NULL,
  `precioVenta` float NOT NULL,
  `porcentajeGanancia` float NOT NULL,
  `talla` int(11) NOT NULL,
  `existencia` int(11) NOT NULL,
  `statusZapato` tinyint(4) NOT NULL DEFAULT 1,
  `idtipoZapato` int(11) NOT NULL,
  `idmarca` int(11) NOT NULL,
  `idcolor` int(11) NOT NULL,
  `idmaterial` int(11) NOT NULL,
  PRIMARY KEY USING BTREE (`codigoZapato`),
  INDEX `fk_zapato_marca1_idx` USING BTREE(`idmarca`),
  INDEX `fk_zapato_color1_idx` USING BTREE(`idcolor`),
  INDEX `fk_zapato_material1_idx` USING BTREE(`idmaterial`),
  INDEX `fk_zapato_tipoZapato1_idx` USING BTREE(`idtipoZapato`),
  CONSTRAINT `fk_zapato_tipoZapato1` FOREIGN KEY (`idtipoZapato`) REFERENCES `tipozapato` (`idtipoZapato`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_zapato_color1` FOREIGN KEY (`idcolor`) REFERENCES `color` (`idcolor`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_zapato_marca1` FOREIGN KEY (`idmarca`) REFERENCES `marca` (`idmarca`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_zapato_material1` FOREIGN KEY (`idmaterial`) REFERENCES `material` (`idmaterial`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'InnoDB free: 9216 kB; (`idtipoZapato`) REFER `zapato/tipozapato`(`idtipoZapato`)' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of zapato
-- ----------------------------
INSERT INTO `zapato` VALUES ('ZAP1RJE', 320, 0, 0.3, 25, 4, 1, 1, 1, 1, 1);
INSERT INTO `zapato` VALUES ('ZAPATO2', 320, 390, 0.3, 26, 2, 1, 1, 1, 1, 1);
INSERT INTO `zapato` VALUES ('ZAPATO3', 340, 390, 0.3, 26, 4, 1, 1, 1, 1, 1);

-- ----------------------------
-- Procedure structure for actualizar_cargo
-- ----------------------------
DROP PROCEDURE IF EXISTS `actualizar_cargo`;
delimiter ;;
CREATE PROCEDURE `actualizar_cargo`(PidCargo INT,
									PdescripcionCargo VARCHAR(45),
									PstatusCargo TINYINT(4))
BEGIN 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT "Operacion abortada" As "Advertencia";
		ROLLBACK;
	END;

	SET AUTOCOMMIT = 0;
	IF EXISTS (SELECT idcargo FROM cargo WHERE cargo.idcargo=PidCargo LIMIT 1) THEN
	
	UPDATE cargo SET descripcionCargo = PdescripcionCargo, statusCargo = 					 PstatusCargo WHERE cargo.idcargo = PidCargo;
	COMMIT;
	SELECT "SE ACTUALIZO CORRECTAMENTE" AS "AVISO";
	ELSE 
		SELECT "NO EXISTE CARGO" As "AVISO";
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for actualizar_color
-- ----------------------------
DROP PROCEDURE IF EXISTS `actualizar_color`;
delimiter ;;
CREATE PROCEDURE `actualizar_color`(PidColor INT,
									Pcolor VARCHAR(255),
									PstatusColor TINYINT(4))
BEGIN 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT "Operacion abortada" As "Advertencia";
		ROLLBACK;
	END;

	SET AUTOCOMMIT = 0;
	IF EXISTS (SELECT idcolor FROM color WHERE color.idcolor=PidColor LIMIT 1) THEN
	
	UPDATE color SET color.color = Pcolor, statusColor = 		
	PstatusColor WHERE color.idcolor = PidColor;
	
	COMMIT;
	SELECT "SE ACTUALIZO CORRECTAMENTE" AS "AVISO";
	ELSE 
		SELECT "NO EXISTE CARGO" As "AVISO";
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for actualizar_detalleCompra
-- ----------------------------
DROP PROCEDURE IF EXISTS `actualizar_detalleCompra`;
delimiter ;;
CREATE PROCEDURE `actualizar_detalleCompra`(PidDetalleCompra INT,
								 PcantidadCompra FLOAT,
								 PprecioCompra FLOAT)
BEGIN 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			SELECT "Operacion abortada" As "Advertencia";
			ROLLBACK;
		END;
SET AUTOCOMMIT = 0;

	IF EXISTS (SELECT idDetalleCompra FROM detallecompra WHERE detallecompra.idDetalleCompra=PidDetalleCompra LIMIT 1) THEN
	
	UPDATE detallecompra SET detallecompra.cantidadCompra = PcantidadCompra,
													 detallecompra.precioCompra = PprecioCompra
													 WHERE detallecompra.idDetalleCompra
													 =PidDetalleCompra;
													 
	UPDATE compra SET compra.totalCompra = (SELECT cantidadCompra FROM detallecompra WHERE
										detallecompra.idDetalleCompra=PidDetalleCompra) *
										(SELECT precioCompra FROM detallecompra WHERE
										detallecompra.idDetalleCompra=PidDetalleCompra)
										WHERE compra.folioCompra=
										(SELECT folioCompra FROM detallecompra WHERE
										detallecompra.idDetalleCompra=PidDetalleCompra);
										
	UPDATE zapato SET zapato.existencia = PcantidadCompra
										WHERE zapato.codigoZapato = (SELECT codigoZapato FROM detallecompra WHERE
										detallecompra.idDetalleCompra=PidDetalleCompra);
										
										COMMIT;
										SELECT "SE ACTUALIZO CORRECTAMENTE" AS "AVISO";
	ELSE 
		SELECT "NO EXISTE CARGO" As "AVISO";
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for actualizar_detalleVenta
-- ----------------------------
DROP PROCEDURE IF EXISTS `actualizar_detalleVenta`;
delimiter ;;
CREATE PROCEDURE `actualizar_detalleVenta`(PidDetalleVenta INT,
								 PcantidadVenta FLOAT)
BEGIN 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			SELECT "Operacion abortada" As "Advertencia";
			ROLLBACK;
		END;
SET AUTOCOMMIT = 0;

	IF EXISTS (SELECT idDetalleVenta FROM detalleventa WHERE detalleventa.idDetalleVenta=PidDetalleVenta LIMIT 1) THEN
	
	UPDATE detalleventa SET detalleventa.cantidadVenta = PcantidadVenta
													 WHERE detalleventa.idDetalleVenta
													 =PidDetalleVenta;
													 
	UPDATE venta SET venta.totalVenta = (SELECT cantidadVenta FROM detalleventa WHERE
										detalleventa.idDetalleVenta=PidDetalleVenta) *
										(SELECT precioVendido FROM detalleventa WHERE
										detalleventa.idDetalleVenta=PidDetalleVenta)
										WHERE venta.folioVenta=
										(SELECT folioVenta FROM detalleventa WHERE
										detalleventa.idDetalleVenta=PidDetalleVenta);
										
	UPDATE zapato SET zapato.existencia = zapato.existencia - (SELECT cantidadVenta FROM detalleventa WHERE
										detalleventa.idDetalleVenta=PidDetalleVenta)
										WHERE zapato.codigoZapato = (SELECT codigoZapato FROM detalleventa WHERE
										detalleventa.idDetalleVenta=PidDetalleVenta);
										
										COMMIT;
										SELECT "SE ACTUALIZO CORRECTAMENTE" AS "AVISO";
	ELSE 
		SELECT "NO EXISTE CARGO" As "AVISO";
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for actualizar_formapago
-- ----------------------------
DROP PROCEDURE IF EXISTS `actualizar_formapago`;
delimiter ;;
CREATE PROCEDURE `actualizar_formapago`(PidFormaPago INT,
									PdescripcionPago VARCHAR(45),
									PstatusPago TINYINT(4))
BEGIN 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT "Operacion abortada" As "Advertencia";
		ROLLBACK;
	END;

	SET AUTOCOMMIT = 0;
	IF EXISTS (SELECT idFormaPago FROM formapago WHERE formapago.idFormaPago
	=PidFormaPago LIMIT 1) THEN
	
	UPDATE formapago SET formapago.descripcionPago = PdescripcionPago,
	statusPago=PstatusPago WHERE formapago.idFormaPago = PidFormaPago;
	
	COMMIT;
	SELECT "SE ACTUALIZO CORRECTAMENTE" AS "AVISO";
	ELSE 
		SELECT "NO EXISTE CARGO" As "AVISO";
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for actualizar_marca
-- ----------------------------
DROP PROCEDURE IF EXISTS `actualizar_marca`;
delimiter ;;
CREATE PROCEDURE `actualizar_marca`(PidMarca INT,
									Pmarca VARCHAR(255),
									PstatusMarca TINYINT(4))
BEGIN 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT "Operacion abortada" As "Advertencia";
		ROLLBACK;
	END;

	SET AUTOCOMMIT = 0;
	IF EXISTS (SELECT idmarca FROM marca WHERE marca.idmarca=PidMarca LIMIT 1) THEN
	
	UPDATE marca SET marca.marca = Pmarca, statusMarca = 		
	PstatusMarca WHERE marca.idmarca = PidMarca;
	
	COMMIT;
	SELECT "SE ACTUALIZO CORRECTAMENTE" AS "AVISO";
	ELSE 
		SELECT "NO EXISTE CARGO" As "AVISO";
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for actualizar_material
-- ----------------------------
DROP PROCEDURE IF EXISTS `actualizar_material`;
delimiter ;;
CREATE PROCEDURE `actualizar_material`(PidMaterial INT,
									Pmaterial VARCHAR(45),
									PstatusMaterial TINYINT(4))
BEGIN 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT "Operacion abortada" As "Advertencia";
		ROLLBACK;
	END;

	SET AUTOCOMMIT = 0;
	IF EXISTS (SELECT idmaterial FROM material WHERE material.idmaterial=PidMaterial LIMIT 1) THEN
	
	UPDATE material SET material.material = Pmaterial, statusMaterial = 		
	PstatusMaterial WHERE material.idmaterial = PidMaterial;
	
	COMMIT;
	SELECT "SE ACTUALIZO CORRECTAMENTE" AS "AVISO";
	ELSE 
		SELECT "NO EXISTE CARGO" As "AVISO";
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for actualizar_personal
-- ----------------------------
DROP PROCEDURE IF EXISTS `actualizar_personal`;
delimiter ;;
CREATE PROCEDURE `actualizar_personal`(PclavePersonal VARCHAR(8),
								 Pnombre VARCHAR(30),
								 PapellidoUno VARCHAR(45),
								 PapellidoDos VARCHAR(45),
								 Pusuario VARCHAR(45),
								 Pcontrasena VARCHAR(45),
								 PstatusPersonal TINYINT(4),
								 Pidcargo INT)
BEGIN 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT "Operacion abortada" As "Advertencia";
		ROLLBACK;
	END;

	SET AUTOCOMMIT = 0;
	
	IF EXISTS (SELECT clavePersonal FROM personal WHERE personal.clavePersonal=PclavePersonal LIMIT 1) THEN
	
	UPDATE personal SET personal.nombre = Pnombre,
										personal.apellidoUno = PapellidoUno,
										personal.apellidoDos = PapellidoDos,
										personal.usuario = Pusuario,
										personal.contrasena = Pcontrasena,
										personal.statusPersonal = PstatusPersonal,
										personal.idcargo = Pidcargo
										WHERE personal.clavePersonal=PclavePersonal;
	
										COMMIT;
										SELECT "SE ACTUALIZO CORRECTAMENTE" AS "AVISO";
	ELSE 
		SELECT "NO EXISTE CARGO" As "AVISO";
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for actualizar_tipoGarantia
-- ----------------------------
DROP PROCEDURE IF EXISTS `actualizar_tipoGarantia`;
delimiter ;;
CREATE PROCEDURE `actualizar_tipoGarantia`(PidtipoGarantia INT,
									PdescripcionGarantia VARCHAR(255))
BEGIN 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT "Operacion abortada" As "Advertencia";
		ROLLBACK;
	END;

	SET AUTOCOMMIT = 0;
	IF EXISTS (SELECT idtipoGarantia FROM tipogarantia WHERE tipogarantia.idtipoGarantia=PidtipoGarantia LIMIT 1) THEN
	
	UPDATE tipogarantia SET tipogarantia.descripciontipoGarantia = PdescripcionGarantia
	WHERE tipogarantia.idtipoGarantia = PidtipoGarantia;
	
	COMMIT;
	SELECT "SE ACTUALIZO CORRECTAMENTE" AS "AVISO";
	ELSE 
		SELECT "NO EXISTE CARGO" As "AVISO";
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for actualizar_tipoZapato
-- ----------------------------
DROP PROCEDURE IF EXISTS `actualizar_tipoZapato`;
delimiter ;;
CREATE PROCEDURE `actualizar_tipoZapato`(PidtipoZapato INT,
									PdescripcionZapato VARCHAR(45))
BEGIN 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT "Operacion abortada" As "Advertencia";
		ROLLBACK;
	END;

	SET AUTOCOMMIT = 0;
	IF EXISTS (SELECT idtipoZapato FROM tipozapato WHERE tipozapato.idtipoZapato=PidtipoZapato LIMIT 1) THEN
	
	UPDATE tipozapato SET tipozapato.descripcionZapato = PdescripcionZapato
	WHERE tipoZapato.idtipoZapato = PidtipoZapato;
	
	COMMIT;
	SELECT "SE ACTUALIZO CORRECTAMENTE" AS "AVISO";
	ELSE 
		SELECT "NO EXISTE CARGO" As "AVISO";
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for actualizar_zapato
-- ----------------------------
DROP PROCEDURE IF EXISTS `actualizar_zapato`;
delimiter ;;
CREATE PROCEDURE `actualizar_zapato`(PcodigoZapato VARCHAR(20),
								 Pestilo INT,
								 PporcentajeGanancia FLOAT,
								 Ptalla INT,
								 PstatusZapato TINYINT,
								 PidtipoZapato INT,
								 Pidmarca INT,
								 Pidcolor INT,
								 Pidmaterial INT)
BEGIN 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT "Operacion abortada" As "Advertencia";
		ROLLBACK;
	END;

	SET AUTOCOMMIT = 0;
	
	IF EXISTS (SELECT codigoZapato FROM zapato WHERE zapato.codigoZapato=PcodigoZapato LIMIT 1) THEN
	
	UPDATE zapato SET zapato.estilo = Pestilo,
										zapato.porcentajeGanancia = PporcentajeGanancia,
										zapato.talla = Ptalla,
										zapato.statusZapato = PstatusZapato,
										zapato.idtipoZapato = PidtipoZapato,
										zapato.idmarca = Pidmarca,
										zapato.idcolor = Pidcolor,
										zapato.idmaterial = Pidmaterial
										WHERE zapato.codigoZapato=PcodigoZapato;
	
										COMMIT;
										SELECT "SE ACTUALIZO CORRECTAMENTE" AS "AVISO";
	ELSE 
		SELECT "NO EXISTE CARGO" As "AVISO";
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for eliminar_detalleVenta
-- ----------------------------
DROP PROCEDURE IF EXISTS `eliminar_detalleVenta`;
delimiter ;;
CREATE PROCEDURE `eliminar_detalleVenta`(PidDetalleVenta INT)
BEGIN 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			SELECT "Operacion abortada" As "Advertencia";
			ROLLBACK;
		END;
SET AUTOCOMMIT = 0;

	IF EXISTS (SELECT idDetalleVenta FROM detalleventa WHERE detalleventa.
	idDetalleVenta=PidDetalleVenta LIMIT 1) THEN
		
		UPDATE venta SET venta.totalVenta = 0
		WHERE venta.folioVenta=(SELECT folioVenta
		FROM detalleventa WHERE detalleventa.idDetalleVenta = PidDetalleVenta);
		
		UPDATE zapato SET zapato.existencia = zapato.existencia + (SELECT detalleventa.cantidadVenta FROM
		detalleventa WHERE detalleventa.idDetalleventa = PidDetalleVenta)
										WHERE zapato.codigoZapato = (SELECT codigoZapato FROM detalleventa WHERE
										detalleventa.idDetalleVenta=PidDetalleVenta);
										
		DELETE FROM detalleventa WHERE idDetalleVenta = PidDetalleVenta;								
		
	
		COMMIT;
		SELECT "SE ELIMINO CORRECTAMENTE" AS "AVISO";
	ELSE 
		SELECT "NO EXISTE Venta" As "AVISO";
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for inserta_cargo
-- ----------------------------
DROP PROCEDURE IF EXISTS `inserta_cargo`;
delimiter ;;
CREATE PROCEDURE `inserta_cargo`(Pcargo VARCHAR(50))
BEGIN 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT "Operacion abortada" As "Advertencia";
		ROLLBACK;
	END;

	SET AUTOCOMMIT = 0;
	IF EXISTS (SELECT descripcionCargo FROM cargo
	WHERE cargo.descripcionCargo=Pcargo) THEN
	
	SELECT "DATO DUPLICADO" AS "AVISO";
	ELSE 
	INSERT cargo VALUES(null,UPPER(TRIM(Pcargo)),1);
		COMMIT;
		SELECT "se completo la transaccion" As "AVISO";

	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for inserta_color
-- ----------------------------
DROP PROCEDURE IF EXISTS `inserta_color`;
delimiter ;;
CREATE PROCEDURE `inserta_color`(Pcolor VARCHAR(50))
BEGIN 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT "Operacion abortada" As "Advertencia";
		ROLLBACK;
	END;

	SET AUTOCOMMIT = 0;
	IF EXISTS (SELECT color FROM color 
	WHERE color.color=Pcolor) THEN
	
	SELECT "DATO DUPLICADO" AS "AVISO";
	ELSE 
	INSERT color VALUES(null,UPPER(TRIM(Pcolor)),1);
		COMMIT;
		SELECT "se completo la transaccion" As "AVISO";

	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for inserta_compra
-- ----------------------------
DROP PROCEDURE IF EXISTS `inserta_compra`;
delimiter ;;
CREATE PROCEDURE `inserta_compra`(PfolioCompra VARCHAR(20),
				PfechaCompra DATE,
				PtotalCompra FLOAT,
				Pusuario VARCHAR(45))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT "Operacion abortada" As "Advertencia";
		ROLLBACK;
	END;
	SET AUTOCOMMIT = 0;
	IF EXISTS (SELECT folioCompra FROM compra 
	WHERE compra.folioCompra=PfolioCompra) THEN
	
	
	SELECT "DATO DUPLICADO" AS "AVISO";
	ELSE
		IF EXISTS (SELECT usuario FROM
		personal WHERE personal.usuario=Pusuario AND personal.statusPersonal=1 LIMIT 1) THEN
			
			INSERT compra VALUES(UPPER(TRIM(PfolioCompra)),
						UPPER(TRIM(PfechaCompra)),
						UPPER(TRIM(PtotalCompra)),
						UPPER(
						TRIM(
						(SELECT clavePersonal FROM
						personal WHERE personal.usuario=Pusuario
						AND personal.statusPersonal=1 LIMIT 1))));
	
			COMMIT;
			SELECT "se completo la transaccion" As "AVISO";
			END IF;
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for inserta_detalleCompra
-- ----------------------------
DROP PROCEDURE IF EXISTS `inserta_detalleCompra`;
delimiter ;;
CREATE PROCEDURE `inserta_detalleCompra`(PcantidadCompra FLOAT,
									PprecioCompra FLOAT,
									PfolioCompra VARCHAR(20),
									PcodigoZapato VARCHAR(20))
BEGIN
     DECLARE ganancia FLOAT;
    
     DECLARE  EXIT HANDLER FOR SQLEXCEPTION
     BEGIN
     ROLLBACK;
     SELECT "Operacion Abortada" AS "ADVERTENCIA";
     END;
     SET AUTOCOMMIT=0;
		 
		 IF EXISTS (SELECT folioCompra FROM compra
        WHERE compra.folioCompra=PfolioCompra LIMIT 1) THEN
				
			IF EXISTS (SELECT codigoZapato FROM zapato
               WHERE zapato.codigoZapato=PcodigoZapato LIMIT 1) THEN
							 
				IF PcantidadCompra > 0 THEN
					IF PprecioCompra > 0 THEN
						INSERT detallecompra VALUES(null,
							PcantidadCompra,
							PprecioCompra,     
							PfolioCompra,
							PcodigoZapato);
							
			SELECT zapato.porcentajeGanancia INTO ganancia FROM zapato
			WHERE zapato.codigoZapato=PcodigoZapato;

			UPDATE zapato Set zapato.existencia = zapato.existencia + 						PcantidadCompra,
							zapato.precioVenta = PprecioCompra +		   		
							PprecioCompra * ganancia WHERE
							zapato.codigoZapato = PcodigoZapato;
			
			COMMIT;
			SELECT "Se completo la Transaccion" AS "AVISO";
			
END IF;
END IF;
END IF;
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for inserta_detalleFormaPago
-- ----------------------------
DROP PROCEDURE IF EXISTS `inserta_detalleFormaPago`;
delimiter ;;
CREATE PROCEDURE `inserta_detalleFormaPago`(Pmonto FLOAT,
	PfolioVenta VARCHAR(20),
	PidFormaPago INT)
BEGIN
	DECLARE  EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			ROLLBACK;
			SELECT "Operacion Abortada" AS "ADVERTENCIA";
		END;
	SET AUTOCOMMIT=0;	
	
	IF EXISTS (SELECT folioVenta FROM venta WHERE 
	venta.folioVenta=PfolioVenta) THEN
	
		IF EXISTS (SELECT idFormaPago FROM formapago WHERE
		formapago.idFormaPago=PidFormaPago AND formapago.statusPago=1 
		LIMIT 1) THEN
	
			IF Pmonto > 0 THEN
			
				INSERT detalleformapago VALUES(
											null,
											Pmonto,
											PfolioVenta,
											PidFormaPago);
												
				COMMIT;
				SELECT "Se completo la Transaccion" AS "AVISO";
			END IF;
		END IF;
	END IF;	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for inserta_detalleVenta
-- ----------------------------
DROP PROCEDURE IF EXISTS `inserta_detalleVenta`;
delimiter ;;
CREATE PROCEDURE `inserta_detalleVenta`(PcantidadVenta INT,
					PfolioVenta VARCHAR(20),  
					PcodigoZapato VARCHAR(20))
BEGIN

	DECLARE  EXIT HANDLER FOR SQLEXCEPTION
     	BEGIN
     	ROLLBACK;
     	SELECT "Operacion Abortada" AS "ADVERTENCIA";
     	END;
     	SET AUTOCOMMIT=0;

	IF EXISTS (SELECT codigoZapato FROM zapato
		   WHERE zapato.codigoZapato=PcodigoZapato AND 
			 zapato.statusZapato=1 AND zapato.existencia>0) THEN
	
	INSERT detalleventa VALUES(null,
			PcantidadVenta,
			(SELECT precioVenta FROM zapato 
			WHERE zapato.codigoZapato=PcodigoZapato),
			PfolioVenta,
			PcodigoZapato);
		
	UPDATE venta SET totalVenta = (SELECT 
	detalleventa.cantidadVenta * detalleventa.precioVendido
	FROM detalleventa WHERE detalleventa.folioVenta = PfolioVenta) WHERE venta.folioVenta=PfolioVenta;
	
	
	UPDATE zapato SET zapato.existencia = 
	zapato.existencia - PcantidadVenta
	WHERE zapato.codigoZapato = PcodigoZapato;
	
	 COMMIT;
	 SELECT "Se completo la Transaccion" AS "AVISO";
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for inserta_formaPago
-- ----------------------------
DROP PROCEDURE IF EXISTS `inserta_formaPago`;
delimiter ;;
CREATE PROCEDURE `inserta_formaPago`(PformaPago VARCHAR(50))
BEGIN 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT "Operacion abortada" As "Advertencia";
		ROLLBACK;
	END;

	SET AUTOCOMMIT = 0;
	IF EXISTS (SELECT descripcionPago FROM formapago
	WHERE formapago.descripcionPago=PformaPago) THEN
	
	SELECT "DATO DUPLICADO" AS "AVISO";
	ELSE 
	INSERT formapago VALUES(null,UPPER(TRIM(PformaPago)),1);
		COMMIT;
		SELECT "se completo la transaccion" As "AVISO";

	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for inserta_garantia
-- ----------------------------
DROP PROCEDURE IF EXISTS `inserta_garantia`;
delimiter ;;
CREATE PROCEDURE `inserta_garantia`(PdescripcionGarantia VARCHAR(255),
	PidtipoGarantia INT,
	PclavePersonal VARCHAR(8),
	PfolioVenta VARCHAR(20))
BEGIN
	DECLARE  EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			ROLLBACK;
			SELECT "Operacion Abortada" AS "ADVERTENCIA";
		END;
	SET AUTOCOMMIT=0;	
	
	IF EXISTS (SELECT folioVenta FROM venta WHERE 
	venta.folioVenta=PfolioVenta) THEN
	
		IF EXISTS (SELECT clavePersonal FROM personal WHERE
		personal.clavePersonal=PclavePersonal AND personal.statusPersonal=1 
		LIMIT 1) THEN
				INSERT garantia VALUES(
								null,
								PdescripcionGarantia,
								PidtipoGarantia,
								PclavePersonal,
								PfolioVenta);
								
								
												
				COMMIT;
				SELECT "Se completo la Transaccion" AS "AVISO";
		END IF;
	END IF;	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for inserta_marca
-- ----------------------------
DROP PROCEDURE IF EXISTS `inserta_marca`;
delimiter ;;
CREATE PROCEDURE `inserta_marca`(PdescripcionMarca VARCHAR(50))
BEGIN 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT "Operacion abortada" As "Advertencia";
		ROLLBACK;
	END;

	SET AUTOCOMMIT = 0;
	IF EXISTS (SELECT marca FROM marca 
	WHERE marca.marca=PdescripcionMarca) THEN
	
	SELECT "DATO DUPLICADO" AS "AVISO";
	ELSE 
	INSERT marca VALUES(null,UPPER(TRIM(PdescripcionMarca)),1);
		COMMIT;
		SELECT "se completo la transaccion" As "AVISO";

	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for inserta_material
-- ----------------------------
DROP PROCEDURE IF EXISTS `inserta_material`;
delimiter ;;
CREATE PROCEDURE `inserta_material`(Pmaterial VARCHAR(50))
BEGIN 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT "Operacion abortada" As "Advertencia";
		ROLLBACK;
	END;

	SET AUTOCOMMIT = 0;
	IF EXISTS (SELECT material FROM material 
	WHERE material.material=Pmaterial) THEN
	
	SELECT "DATO DUPLICADO" AS "AVISO";
	ELSE 
	INSERT material VALUES(null,UPPER(TRIM(Pmaterial)),1);
		COMMIT;
		SELECT "se completo la transaccion" As "AVISO";

	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for inserta_personal
-- ----------------------------
DROP PROCEDURE IF EXISTS `inserta_personal`;
delimiter ;;
CREATE PROCEDURE `inserta_personal`(PclavePersonal VARCHAR(8),
	Pnombre VARCHAR(30),
	Papellido1 VARCHAR(30),
	Papellido2 VARCHAR(30),
	Pusuario VARCHAR(15),
	Pcontrasenia VARCHAR(8),
	Pidcargo VARCHAR(255))
BEGIN
	DECLARE  EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT "Operacion Abortada" AS "ADVERTENCIA";
	END;
	SET AUTOCOMMIT=0;
	IF EXISTS (SELECT usuario FROM personal WHERE 
	personal.usuario=Pusuario) THEN
		SELECT "ya existe" AS "Advertencia";
	ELSE
		IF EXISTS (SELECT idcargo FROM
		cargo WHERE cargo.idcargo=Pidcargo AND cargo.statusCargo=1 LIMIT
		1) THEN
		
		INSERT personal VALUES(
			PclavePersonal,
			UPPER(TRIM(Pnombre)),
			UPPER(TRIM(Papellido1)),
			UPPER(TRIM(Papellido2)),
			TRIM(Pusuario),
			Pcontrasenia,
			1,
			Pidcargo);
			
			COMMIT;
			SELECT "Se completo la Transaccion" AS "AVISO";
		END IF;
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for inserta_tipoGarantia
-- ----------------------------
DROP PROCEDURE IF EXISTS `inserta_tipoGarantia`;
delimiter ;;
CREATE PROCEDURE `inserta_tipoGarantia`(PtipoGarantia VARCHAR(50))
BEGIN 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT "Operacion abortada" As "Advertencia";
		ROLLBACK;
	END;

	SET AUTOCOMMIT = 0;
	IF EXISTS (SELECT descripciontipoGarantia FROM tipogarantia
	WHERE tipogarantia.descripciontipoGarantia=PtipoGarantia) THEN
	
	SELECT "DATO DUPLICADO" AS "AVISO";
	ELSE 
	INSERT tipogarantia VALUES(null,UPPER(TRIM(PtipoGarantia)));
		COMMIT;
		SELECT "se completo la transaccion" As "AVISO";

	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for inserta_tipoZapato
-- ----------------------------
DROP PROCEDURE IF EXISTS `inserta_tipoZapato`;
delimiter ;;
CREATE PROCEDURE `inserta_tipoZapato`(PtipoZapato VARCHAR(50))
BEGIN 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT "Operacion abortada" As "Advertencia";
		ROLLBACK;
	END;

	SET AUTOCOMMIT = 0;
	IF EXISTS (SELECT descripcionZapato FROM tipozapato
	WHERE tipozapato.descripcionZapato=PtipoZapato) THEN
	
	SELECT "DATO DUPLICADO" AS "AVISO";
	ELSE 
	INSERT tipozapato VALUES(null,UPPER(TRIM(PtipoZapato)));
		COMMIT;
		SELECT "se completo la transaccion" As "AVISO";

	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for inserta_venta
-- ----------------------------
DROP PROCEDURE IF EXISTS `inserta_venta`;
delimiter ;;
CREATE PROCEDURE `inserta_venta`(PfolioVenta VARCHAR(20),
	Pusuario VARCHAR(8))
BEGIN
	DECLARE  EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		SELECT "Operacion Abortada" AS "ADVERTENCIA";
	END;
	SET AUTOCOMMIT=0;
	IF EXISTS (SELECT folioVenta FROM venta WHERE 
	venta.folioVenta=PfolioVenta) THEN
		SELECT "ya existe" AS "Advertencia";
	ELSE
		IF EXISTS (SELECT usuario FROM
		personal WHERE personal.usuario=Pusuario AND personal.statusPersonal=1 LIMIT 1) THEN
		
		INSERT venta VALUES(
			UPPER(TRIM(PfolioVenta)),
			UPPER(TRIM(NOW())),
			0,
			(SELECT ClavePersonal FROM
			personal WHERE personal.usuario=Pusuario
			AND personal.statusPersonal=1 LIMIT 1));
			COMMIT;
			SELECT "Se completo la Transaccion" AS "AVISO";
		END IF;
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for inserta_zapato
-- ----------------------------
DROP PROCEDURE IF EXISTS `inserta_zapato`;
delimiter ;;
CREATE PROCEDURE `inserta_zapato`(PcodigoZapato VARCHAR(20),
			Pestilo INT,
			PporcentajeGanancia FLOAT,
			Ptalla INT,
			PidtipoZapato INT,
			Pidmarca INT,
			Pidcolor INT,
			Pidmaterial INT)
BEGIN
	DECLARE  EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
	ROLLBACK;
		SELECT "Operacion Abortada" AS "ADVERTENCIA";
	END;
	SET AUTOCOMMIT=0;
	
	IF EXISTS (SELECT codigoZapato FROM zapato WHERE 
	zapato.codigoZapato=PcodigoZapato) THEN
		SELECT "ya existe" AS "AVISO";
	ELSE
	IF EXISTS (SELECT idmarca FROM
		marca WHERE marca.idmarca=Pidmarca AND marca.statusMarca=1 LIMIT 1) THEN
		
		IF EXISTS (SELECT idcolor FROM
		color WHERE color.idcolor=Pidcolor AND color.statusColor=1 LIMIT 1) THEN
			
			IF EXISTS (SELECT idmaterial FROM
			material WHERE material.idmaterial=Pidmaterial AND material.statusMaterial=1 LIMIT 1) THEN
			
				IF EXISTS (SELECT idtipoZapato FROM
				tipozapato WHERE tipozapato.idtipoZapato=PidtipoZapato LIMIT 1) THEN
				
					INSERT zapato VALUES(
						PcodigoZapato,
						Pestilo,
						0,
						PporcentajeGanancia,
						Ptalla,
						0,
						1,
						PidtipoZapato,
						Pidmarca,
						Pidcolor,
						Pidmaterial);
						
						COMMIT;
						SELECT "Se completo la Transaccion" AS "AVISO";
						
						END IF;
					END IF;
				END IF;
			END IF;
		END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table compra
-- ----------------------------
DROP TRIGGER IF EXISTS `tigger_inserta_compra`;
delimiter ;;
CREATE TRIGGER `tigger_inserta_compra` AFTER INSERT ON `compra` FOR EACH ROW INSERT bitacorazapato.chismoso VALUES(DEFAULT,'COMPRA',USER(),NOW(),'I','',CONCAT(NEW.folioCompra,',',NEW.fechaCompra,',',NEW.totalCompra,',',NEW.clavePersonal))
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table detallecompra
-- ----------------------------
DROP TRIGGER IF EXISTS `tigger_inserta_detalleCompra`;
delimiter ;;
CREATE TRIGGER `tigger_inserta_detalleCompra` AFTER INSERT ON `detallecompra` FOR EACH ROW INSERT bitacorazapato.chismoso VALUES(DEFAULT,'detallecompra',USER(),NOW(),'I','',CONCAT(NEW.idDetalleCompra,',',NEW.cantidadCompra,',',NEW.precioCompra,',',NEW.folioCompra,',',NEW.codigoZapato))
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table detalleventa
-- ----------------------------
DROP TRIGGER IF EXISTS `tigger_inserta_detalleVenta`;
delimiter ;;
CREATE TRIGGER `tigger_inserta_detalleVenta` AFTER INSERT ON `detalleventa` FOR EACH ROW INSERT bitacorazapato.chismoso VALUES(DEFAULT,'DETALLEVENTA',USER(),NOW(),'I','',CONCAT(NEW.idDetalleVenta,',',NEW.cantidadVenta,',',NEW.precioVendido,',',NEW.folioVenta,',',NEW.codigoZapato))
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table detalleventa
-- ----------------------------
DROP TRIGGER IF EXISTS `tigger_update_detalleVenta`;
delimiter ;;
CREATE TRIGGER `tigger_update_detalleVenta` AFTER UPDATE ON `detalleventa` FOR EACH ROW INSERT bitacorazapato.chismoso VALUES(DEFAULT,'DETALLEVENTA',USER(),NOW(),'U',CONCAT(OLD.idDetalleVenta,',',OLD.cantidadVenta,',',OLD.precioVendido,',',OLD.folioVenta,',',OLD.codigoZapato),CONCAT(NEW.idDetalleVenta,',',NEW.cantidadVenta,',',NEW.precioVendido,',',NEW.folioVenta,',',NEW.codigoZapato))
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table marca
-- ----------------------------
DROP TRIGGER IF EXISTS `tigger_inserta_marca`;
delimiter ;;
CREATE TRIGGER `tigger_inserta_marca` AFTER INSERT ON `marca` FOR EACH ROW INSERT bitacorazapato.chismoso VALUES(DEFAULT,'MARCA',USER(),NOW(),'I','',CONCAT(NEW.idmarca,',',NEW.marca,',',NEW.statusMarca))
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table venta
-- ----------------------------
DROP TRIGGER IF EXISTS `tigger_inserta_venta`;
delimiter ;;
CREATE TRIGGER `tigger_inserta_venta` AFTER INSERT ON `venta` FOR EACH ROW INSERT bitacorazapato.chismoso VALUES(DEFAULT,'VENTA',USER(),NOW(),'I','',CONCAT(NEW.folioVenta,',',NEW.fechaVenta,',',NEW.totalVenta,',',NEW.clavePersonal))
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table venta
-- ----------------------------
DROP TRIGGER IF EXISTS `tigger_update_venta`;
delimiter ;;
CREATE TRIGGER `tigger_update_venta` AFTER UPDATE ON `venta` FOR EACH ROW INSERT bitacorazapato.chismoso VALUES(DEFAULT,'VENTA',USER(),NOW(),'U',CONCAT(OLD.folioVenta,',',OLD.fechaVenta,',',OLD.totalVenta,',',OLD.clavePersonal),CONCAT(NEW.folioVenta,',',NEW.fechaVenta,',',NEW.totalVenta,',',NEW.clavePersonal))
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table zapato
-- ----------------------------
DROP TRIGGER IF EXISTS `tigger_inserta_zapato`;
delimiter ;;
CREATE TRIGGER `tigger_inserta_zapato` AFTER INSERT ON `zapato` FOR EACH ROW INSERT bitacorazapato.chismoso VALUES(DEFAULT,'ZAPATO',USER(),NOW(),'I','',CONCAT(NEW.codigoZapato,',',NEW.estilo,',',NEW.precioVenta,',',NEW.porcentajeGanancia,',',NEW.talla,',',NEW.existencia,',',NEW.statusZapato,',',NEW.idmarca,',',NEW.idcolor,',',NEW.idmaterial))
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table zapato
-- ----------------------------
DROP TRIGGER IF EXISTS `tigger_update_zapato`;
delimiter ;;
CREATE TRIGGER `tigger_update_zapato` AFTER UPDATE ON `zapato` FOR EACH ROW INSERT bitacorazapato.chismoso VALUES(DEFAULT,'ZAPATO',USER(),NOW(),'U',CONCAT(OLD.codigoZapato,',',OLD.estilo,',',OLD.precioVenta,',',OLD.porcentajeGanancia,',',OLD.talla,',',OLD.existencia,',',OLD.statusZapato,',',OLD.idmarca,',',OLD.idcolor,',',OLD.idmaterial),CONCAT(NEW.codigoZapato,',',NEW.estilo,',',NEW.precioVenta,',',NEW.porcentajeGanancia,',',NEW.talla,',',NEW.existencia,',',NEW.statusZapato,',',NEW.idmarca,',',NEW.idcolor,',',NEW.idmaterial))
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
