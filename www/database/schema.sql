/*
 Navicat Premium Dump SQL

 Source Server         : appsalon
 Source Server Type    : MySQL
 Source Server Version : 100625 (10.6.25-MariaDB-ubu2204)
 Source Host           : localhost:3306
 Source Schema         : appsalon

 Target Server Type    : MySQL
 Target Server Version : 100625 (10.6.25-MariaDB-ubu2204)
 File Encoding         : 65001

 Date: 09/04/2026 10:14:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for citas
-- ----------------------------
DROP TABLE IF EXISTS `citas`;
CREATE TABLE `citas`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `usuarioId` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `citas_usuarios_fk`(`usuarioId` ASC) USING BTREE,
  CONSTRAINT `citas_usuarios_fk` FOREIGN KEY (`usuarioId`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of citas
-- ----------------------------
INSERT INTO `citas` VALUES (22, '2026-04-20', '10:45:00', 4);
INSERT INTO `citas` VALUES (23, '2026-04-10', '10:25:00', 4);

-- ----------------------------
-- Table structure for citasServicios
-- ----------------------------
DROP TABLE IF EXISTS `citasServicios`;
CREATE TABLE `citasServicios`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `citaId` int NULL DEFAULT NULL,
  `servicioId` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_cita_servicio`(`citaId` ASC) USING BTREE,
  INDEX `fk_servicio_cita`(`servicioId` ASC) USING BTREE,
  CONSTRAINT `fk_cita_servicio` FOREIGN KEY (`citaId`) REFERENCES `citas` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `fk_servicio_cita` FOREIGN KEY (`servicioId`) REFERENCES `servicios` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of citasServicios
-- ----------------------------
INSERT INTO `citasServicios` VALUES (9, NULL, 1);
INSERT INTO `citasServicios` VALUES (10, NULL, 2);
INSERT INTO `citasServicios` VALUES (11, NULL, 3);
INSERT INTO `citasServicios` VALUES (12, NULL, 6);
INSERT INTO `citasServicios` VALUES (13, NULL, 5);
INSERT INTO `citasServicios` VALUES (14, 22, 1);
INSERT INTO `citasServicios` VALUES (15, 22, 3);
INSERT INTO `citasServicios` VALUES (16, 22, 5);
INSERT INTO `citasServicios` VALUES (17, 22, 4);
INSERT INTO `citasServicios` VALUES (18, 23, 8);
INSERT INTO `citasServicios` VALUES (19, 23, 5);

-- ----------------------------
-- Table structure for servicios
-- ----------------------------
DROP TABLE IF EXISTS `servicios`;
CREATE TABLE `servicios`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `precio` decimal(5, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of servicios
-- ----------------------------
INSERT INTO `servicios` VALUES (1, 'Corte de Cabello Niño', 70.00);
INSERT INTO `servicios` VALUES (2, 'Corte de Cabello Hombre', 80.00);
INSERT INTO `servicios` VALUES (3, 'Corte de Barba', 60.00);
INSERT INTO `servicios` VALUES (4, 'Peinado Mujer', 80.00);
INSERT INTO `servicios` VALUES (5, 'Peinado Hombre', 60.00);
INSERT INTO `servicios` VALUES (6, 'Tinte', 300.00);
INSERT INTO `servicios` VALUES (7, 'Uñas', 400.00);
INSERT INTO `servicios` VALUES (8, 'Lavado de Cabello', 50.00);
INSERT INTO `servicios` VALUES (9, 'Tratamiento Capilar', 150.00);
INSERT INTO `servicios` VALUES (10, ' Tinte para cabello', 100.00);

-- ----------------------------
-- Table structure for usuarios
-- ----------------------------
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `apellido` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `telefono` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `admin` tinyint(1) NULL DEFAULT NULL,
  `confirmado` tinyint(1) NULL DEFAULT NULL,
  `token` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `password` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usuarios
-- ----------------------------
INSERT INTO `usuarios` VALUES (4, 'Javier ', 'Hernandez', 'correo@correo.com', '78985412', 0, 1, '', '$2y$10$2euX28cNvjntBlklYcY0QO7dyf4U4CB5M6q.JYKEwuhphWSbCxip.');
INSERT INTO `usuarios` VALUES (5, 'Eduardo', 'Sanchez', 'admin@admin.com', '22369587', 1, 1, '', '$2y$10$079o/tUzU9OyjsMuNVlbxutGt9TzuIte0fpnvoI3vGSCAA8.aV/KS');
INSERT INTO `usuarios` VALUES (7, ' Elizabeth', 'Ruiz', 'elizabeth@gmail.com', '78985632', 0, 1, '', '$2y$10$2TAhwONArYJajfdGhP2AyumlMtEIYlBqrWhj8hUgz7Vfo83gjJrgS');

SET FOREIGN_KEY_CHECKS = 1;
