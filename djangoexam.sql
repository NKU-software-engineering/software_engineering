/*
 Navicat Premium Data Transfer

 Source Server         : cysql
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : djangoexam

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 31/05/2023 15:02:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissions_group_id_b120cbf9`(`group_id`) USING BTREE,
  INDEX `auth_group_permissions_permission_id_84c5c92e`(`permission_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  INDEX `auth_permission_content_type_id_2f476e4b`(`content_type_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 53 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` VALUES (14, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` VALUES (15, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` VALUES (16, 'Can view user', 4, 'view_user');
INSERT INTO `auth_permission` VALUES (17, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (18, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (19, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (20, 'Can view content type', 5, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (21, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` VALUES (22, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` VALUES (23, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` VALUES (24, 'Can view session', 6, 'view_session');
INSERT INTO `auth_permission` VALUES (25, 'Can add 学生', 7, 'add_student');
INSERT INTO `auth_permission` VALUES (26, 'Can change 学生', 7, 'change_student');
INSERT INTO `auth_permission` VALUES (27, 'Can delete 学生', 7, 'delete_student');
INSERT INTO `auth_permission` VALUES (28, 'Can view 学生', 7, 'view_student');
INSERT INTO `auth_permission` VALUES (29, 'Can add 教师', 8, 'add_teacher');
INSERT INTO `auth_permission` VALUES (30, 'Can change 教师', 8, 'change_teacher');
INSERT INTO `auth_permission` VALUES (31, 'Can delete 教师', 8, 'delete_teacher');
INSERT INTO `auth_permission` VALUES (32, 'Can view 教师', 8, 'view_teacher');
INSERT INTO `auth_permission` VALUES (33, 'Can add 试卷', 9, 'add_testpaper');
INSERT INTO `auth_permission` VALUES (34, 'Can change 试卷', 9, 'change_testpaper');
INSERT INTO `auth_permission` VALUES (35, 'Can delete 试卷', 9, 'delete_testpaper');
INSERT INTO `auth_permission` VALUES (36, 'Can view 试卷', 9, 'view_testpaper');
INSERT INTO `auth_permission` VALUES (37, 'Can add 学生成绩', 10, 'add_record');
INSERT INTO `auth_permission` VALUES (38, 'Can change 学生成绩', 10, 'change_record');
INSERT INTO `auth_permission` VALUES (39, 'Can delete 学生成绩', 10, 'delete_record');
INSERT INTO `auth_permission` VALUES (40, 'Can view 学生成绩', 10, 'view_record');
INSERT INTO `auth_permission` VALUES (41, 'Can add 题库', 11, 'add_questionbank');
INSERT INTO `auth_permission` VALUES (42, 'Can change 题库', 11, 'change_questionbank');
INSERT INTO `auth_permission` VALUES (43, 'Can delete 题库', 11, 'delete_questionbank');
INSERT INTO `auth_permission` VALUES (44, 'Can view 题库', 11, 'view_questionbank');
INSERT INTO `auth_permission` VALUES (45, 'Can add 预订信息', 12, 'add_book');
INSERT INTO `auth_permission` VALUES (46, 'Can change 预订信息', 12, 'change_book');
INSERT INTO `auth_permission` VALUES (47, 'Can delete 预订信息', 12, 'delete_book');
INSERT INTO `auth_permission` VALUES (48, 'Can view 预订信息', 12, 'view_book');
INSERT INTO `auth_permission` VALUES (49, 'Can add 答题记录和评分', 13, 'add_answer_score');
INSERT INTO `auth_permission` VALUES (50, 'Can change 答题记录和评分', 13, 'change_answer_score');
INSERT INTO `auth_permission` VALUES (51, 'Can delete 答题记录和评分', 13, 'delete_answer_score');
INSERT INTO `auth_permission` VALUES (52, 'Can view 答题记录和评分', 13, 'view_answer_score');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES (1, 'pbkdf2_sha256$216000$kbKdwoNVnxh9$h97m2i9f1MloYQCj/iGPuMApJyGwZrLzqiIk2BUfOAU=', '2023-05-30 08:51:29.743997', 1, 'admin', '', '', 'admin@163.com', 1, 1, '2023-05-30 08:50:50.087913');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `auth_user_groups_user_id_6a12ed8b`(`user_id`) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544`(`group_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `auth_user_user_permissions_user_id_a95ead1b`(`user_id`) USING BTREE,
  INDEX `auth_user_user_permissions_permission_id_1fbb5f2c`(`permission_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `content_type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (7, 'exam', 'student');
INSERT INTO `django_content_type` VALUES (8, 'exam', 'teacher');
INSERT INTO `django_content_type` VALUES (9, 'exam', 'testpaper');
INSERT INTO `django_content_type` VALUES (10, 'exam', 'record');
INSERT INTO `django_content_type` VALUES (11, 'exam', 'questionbank');
INSERT INTO `django_content_type` VALUES (12, 'exam', 'book');
INSERT INTO `django_content_type` VALUES (13, 'exam', 'answer_score');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2023-05-29 15:53:09.692159');
INSERT INTO `django_migrations` VALUES (2, 'auth', '0001_initial', '2023-05-29 15:53:09.912620');
INSERT INTO `django_migrations` VALUES (3, 'admin', '0001_initial', '2023-05-29 15:53:11.475861');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2023-05-29 15:53:11.900916');
INSERT INTO `django_migrations` VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2023-05-29 15:53:11.918868');
INSERT INTO `django_migrations` VALUES (6, 'contenttypes', '0002_remove_content_type_name', '2023-05-29 15:53:12.090412');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0002_alter_permission_name_max_length', '2023-05-29 15:53:12.169310');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0003_alter_user_email_max_length', '2023-05-29 15:53:12.281562');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0004_alter_user_username_opts', '2023-05-29 15:53:12.297636');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0005_alter_user_last_login_null', '2023-05-29 15:53:12.379139');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0006_require_contenttypes_0002', '2023-05-29 15:53:12.388281');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0007_alter_validators_add_error_messages', '2023-05-29 15:53:12.403350');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0008_alter_user_username_max_length', '2023-05-29 15:53:12.524354');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0009_alter_user_last_name_max_length', '2023-05-29 15:53:12.634253');
INSERT INTO `django_migrations` VALUES (15, 'auth', '0010_alter_group_name_max_length', '2023-05-29 15:53:12.726511');
INSERT INTO `django_migrations` VALUES (16, 'auth', '0011_update_proxy_permissions', '2023-05-29 15:53:12.740601');
INSERT INTO `django_migrations` VALUES (17, 'auth', '0012_alter_user_first_name_max_length', '2023-05-29 15:53:12.868733');
INSERT INTO `django_migrations` VALUES (18, 'exam', '0001_initial', '2023-05-29 15:53:13.114277');
INSERT INTO `django_migrations` VALUES (19, 'sessions', '0001_initial', '2023-05-29 15:53:14.424274');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('6dzzezjp1yg8lazhn7xkvtmbkqcav7tq', '.eJxVjDsOwyAQBe9CHVl8bAMu0-cMaNkFm3xAMnYV5e7BkouknXlv3szBvi1ur2F1idjEBLv8Mg_4CPkQdIc8lw5L3tbku2PSnbZ2t0LheT23f4EF6tLeQDRqDUHw0RgkRbz3ceilFYg8KgtSo44RjSbhIycVbYhCyEHhKC3ZFj1yGV6h1SQXUhrdYKruWeaU2bSte_h8Ae3kQ90:1q41VE:D623Jq1WtjKpxepKpahRDxDYvdVZdDOZS2hTDR22O2Q', '2023-06-13 15:43:16.817881');
INSERT INTO `django_session` VALUES ('heap12bdqpstfhrdan8ca3r0vmzdxbif', 'eyJ1c2VybmFtZSI6IjIwMTIyODciLCJpc19sb2dpbiI6dHJ1ZX0:1q4DXE:npVkNbMHb7X64VaJiXNPIFv5koBIWsmwutHXdr1ouqY', '2023-06-14 04:34:08.720660');
INSERT INTO `django_session` VALUES ('5uuwlw6cjibhs5pard4ghi8qjsiv4sdj', 'eyJ1c2VybmFtZSI6IjIwMTIyODciLCJpc19sb2dpbiI6dHJ1ZX0:1q4Dti:Wy4Q7bcOUv6PZWdZQX4ygdRZ1St0E3n2FBghXSY5a3Q', '2023-06-14 04:57:22.260798');
INSERT INTO `django_session` VALUES ('wnmhgklyv9z2j52rugz9wd6qlyswn7bx', 'eyJ1c2VybmFtZSI6IjIwMTIyODciLCJpc19sb2dpbiI6dHJ1ZX0:1q4E4W:DJRptuDPpdnYm23wxfoD2eVo_4UAVotw9daYcDVKVaA', '2023-06-14 05:08:32.370856');
INSERT INTO `django_session` VALUES ('izxht9jlpo707hb71iqn7ipcxcuep05w', 'eyJ1c2VybmFtZSI6IjIwMTIyODciLCJpc19sb2dpbiI6dHJ1ZX0:1q4F9I:m4WzYjh1vz3HPUosQViv6ik0nifVUWruPRIWdEB-qLo', '2023-06-14 06:17:32.607195');

-- ----------------------------
-- Table structure for exam_answer_score
-- ----------------------------
DROP TABLE IF EXISTS `exam_answer_score`;
CREATE TABLE `exam_answer_score`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `answer` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `score` int(11) NOT NULL,
  `qid_id` int(11) NOT NULL,
  `sid_id` varchar(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `tid_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `exam_answer_score_qid_id_7b8df6f7`(`qid_id`) USING BTREE,
  INDEX `exam_answer_score_sid_id_af0cc538`(`sid_id`) USING BTREE,
  INDEX `exam_answer_score_tid_id_2aa7aadc`(`tid_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exam_answer_score
-- ----------------------------

-- ----------------------------
-- Table structure for exam_book
-- ----------------------------
DROP TABLE IF EXISTS `exam_book`;
CREATE TABLE `exam_book`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paid` tinyint(1) NOT NULL,
  `sid_id` varchar(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `tid_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `exam_book_sid_id_78e7d34e`(`sid_id`) USING BTREE,
  INDEX `exam_book_tid_id_97e3bdd1`(`tid_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exam_book
-- ----------------------------
INSERT INTO `exam_book` VALUES (1, 1, '2012287', 1);

-- ----------------------------
-- Table structure for exam_questionbank
-- ----------------------------
DROP TABLE IF EXISTS `exam_questionbank`;
CREATE TABLE `exam_questionbank`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `qtype` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `a` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `b` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `c` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `d` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `answer` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `difficulty` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `score` int(11) NOT NULL,
  `paper_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `exam_questionbank_paper_id_0eff0063`(`paper_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exam_questionbank
-- ----------------------------
INSERT INTO `exam_questionbank` VALUES (1, '1+1', '0', '0', '1', '2', '3', 'c', 'easy', 2, 1);

-- ----------------------------
-- Table structure for exam_record
-- ----------------------------
DROP TABLE IF EXISTS `exam_record`;
CREATE TABLE `exam_record`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `grade` double NOT NULL,
  `sid_id` varchar(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `tid_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `exam_record_sid_id_46867e48`(`sid_id`) USING BTREE,
  INDEX `exam_record_tid_id_a64a6f38`(`tid_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exam_record
-- ----------------------------
INSERT INTO `exam_record` VALUES (1, 90, '2012286', 1);

-- ----------------------------
-- Table structure for exam_student
-- ----------------------------
DROP TABLE IF EXISTS `exam_student`;
CREATE TABLE `exam_student`  (
  `sid` varchar(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `sex` tinyint(1) NOT NULL,
  `age` int(11) NOT NULL,
  `email` varchar(254) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `pwd` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`sid`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exam_student
-- ----------------------------
INSERT INTO `exam_student` VALUES ('2012287', '曹烨', 0, 20, 'caoye@163.com', '123456');

-- ----------------------------
-- Table structure for exam_teacher
-- ----------------------------
DROP TABLE IF EXISTS `exam_teacher`;
CREATE TABLE `exam_teacher`  (
  `tid` varchar(12) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `pwd` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tid`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exam_teacher
-- ----------------------------

-- ----------------------------
-- Table structure for exam_testpaper
-- ----------------------------
DROP TABLE IF EXISTS `exam_testpaper`;
CREATE TABLE `exam_testpaper`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `time` int(11) NOT NULL,
  `examtime` datetime(6) NOT NULL,
  `fee` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `title`(`title`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exam_testpaper
-- ----------------------------
INSERT INTO `exam_testpaper` VALUES (1, 'CET6', 30, '2023-05-30 23:21:37.000000', 50);
INSERT INTO `exam_testpaper` VALUES (2, 'CET6-1', 30, '2023-05-30 08:56:58.000000', 50);

SET FOREIGN_KEY_CHECKS = 1;
