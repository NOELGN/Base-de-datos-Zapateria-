/*
 Navicat Premium Data Transfer

 Source Server         : 3306
 Source Server Type    : MySQL
 Source Server Version : 50051
 Source Host           : localhost:3306
 Source Schema         : bitacorazapato

 Target Server Type    : MySQL
 Target Server Version : 50051
 File Encoding         : 65001

 Date: 13/06/2019 10:21:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for chismoso
-- ----------------------------
DROP TABLE IF EXISTS `chismoso`;
CREATE TABLE `chismoso`  (
  `idChismoso` int(11) NOT NULL AUTO_INCREMENT,
  `tabla` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `usuario` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `fechahora` datetime NOT NULL,
  `accion` char(1) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `valAntiguo` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `valNuevo` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY USING BTREE (`idChismoso`)
) ENGINE = MyISAM AUTO_INCREMENT = 53 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chismoso
-- ----------------------------
INSERT INTO `chismoso` VALUES (44, 'MARCA', 'administrador@localhost', '2019-06-13 01:58:14', 'I', '', '4,LADY,1');
INSERT INTO `chismoso` VALUES (45, 'ZAPATO', 'administrador@localhost', '2019-06-13 02:06:36', 'I', '', 'ZAPATO3,340,0,0.3,26,0,1,1,1,1');
INSERT INTO `chismoso` VALUES (46, 'COMPRA', 'comprador@localhost', '2019-06-13 02:23:14', 'I', '', 'COMPRA3,2019-06-13,0,LONG3212');
INSERT INTO `chismoso` VALUES (47, 'detallecompra', 'superDios@localhost', '2019-06-13 02:28:29', 'I', '', '17,5,300,COMPRA3,ZAPATO3');
INSERT INTO `chismoso` VALUES (48, 'ZAPATO', 'superDios@localhost', '2019-06-13 02:28:29', 'U', 'ZAPATO3,340,0,0.3,26,0,1,1,1,1', 'ZAPATO3,340,390,0.3,26,5,1,1,1,1');
INSERT INTO `chismoso` VALUES (49, 'VENTA', 'superDios@localhost', '2019-06-13 02:50:06', 'I', '', 'VENTA5,2019-06-13,0,LONG3212');
INSERT INTO `chismoso` VALUES (50, 'DETALLEVENTA', 'superDios@localhost', '2019-06-13 02:51:47', 'I', '', '7,1,390,VENTA5,ZAPATO3');
INSERT INTO `chismoso` VALUES (51, 'VENTA', 'superDios@localhost', '2019-06-13 02:51:47', 'U', 'VENTA5,2019-06-13,0,LONG3212', 'VENTA5,2019-06-13,390,LONG3212');
INSERT INTO `chismoso` VALUES (52, 'ZAPATO', 'superDios@localhost', '2019-06-13 02:51:47', 'U', 'ZAPATO3,340,390,0.3,26,5,1,1,1,1', 'ZAPATO3,340,390,0.3,26,4,1,1,1,1');

SET FOREIGN_KEY_CHECKS = 1;
