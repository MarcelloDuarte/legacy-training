-- MySQL dump 10.13  Distrib 5.6.25, for osx10.10 (x86_64)
--
-- Host: localhost    Database: joindin
-- ------------------------------------------------------
-- Server version	5.6.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `blog_cats`
--

DROP TABLE IF EXISTS `blog_cats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_cats` (
  `name` varchar(100) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_cats`
--

LOCK TABLES `blog_cats` WRITE;
/*!40000 ALTER TABLE `blog_cats` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_cats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_comments`
--

DROP TABLE IF EXISTS `blog_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_comments` (
  `title` varchar(100) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `content` mediumtext,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `blog_post_id` int(11) DEFAULT NULL,
  `author_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_post` (`blog_post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_comments`
--

LOCK TABLES `blog_comments` WRITE;
/*!40000 ALTER TABLE `blog_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_post_cat`
--

DROP TABLE IF EXISTS `blog_post_cat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_post_cat` (
  `post_id` int(11) DEFAULT NULL,
  `cat_id` int(11) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_post_cat`
--

LOCK TABLES `blog_post_cat` WRITE;
/*!40000 ALTER TABLE `blog_post_cat` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_post_cat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_posts`
--

DROP TABLE IF EXISTS `blog_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_posts` (
  `title` varchar(250) DEFAULT NULL,
  `content` mediumtext,
  `date_posted` int(11) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `views` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `date_posted` (`date_posted`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_posts`
--

LOCK TABLES `blog_posts` WRITE;
/*!40000 ALTER TABLE `blog_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `cat_title` varchar(200) DEFAULT NULL,
  `cat_desc` mediumtext,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `name` varchar(50) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=248 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_verification_tokens`
--

DROP TABLE IF EXISTS `email_verification_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_verification_tokens` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_verification_tokens`
--

LOCK TABLES `email_verification_tokens` WRITE;
/*!40000 ALTER TABLE `email_verification_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_verification_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_comments`
--

DROP TABLE IF EXISTS `event_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_comments` (
  `event_id` int(11) DEFAULT NULL,
  `comment` mediumtext,
  `date_made` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `active` int(11) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(100) DEFAULT NULL,
  `comment_type` varchar(100) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_event` (`event_id`),
  KEY `idx_userid` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=199 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_comments`
--

LOCK TABLES `event_comments` WRITE;
/*!40000 ALTER TABLE `event_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_themes`
--

DROP TABLE IF EXISTS `event_themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_themes` (
  `theme_name` varchar(200) DEFAULT NULL,
  `theme_desc` text,
  `active` int(11) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `css_file` varchar(200) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`),
  KEY `idx_event` (`active`,`event_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_themes`
--

LOCK TABLES `event_themes` WRITE;
/*!40000 ALTER TABLE `event_themes` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_themes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_track`
--

DROP TABLE IF EXISTS `event_track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_track` (
  `event_id` int(11) DEFAULT NULL,
  `track_name` varchar(300) DEFAULT NULL,
  `track_desc` mediumtext,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `track_color` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_event` (`event_id`)
) ENGINE=MyISAM AUTO_INCREMENT=77 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_track`
--

LOCK TABLES `event_track` WRITE;
/*!40000 ALTER TABLE `event_track` DISABLE KEYS */;
INSERT INTO `event_track` VALUES (52,'Inviqa','Backend Legacy',76,'');
/*!40000 ALTER TABLE `event_track` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `event_name` varchar(200) DEFAULT NULL,
  `url_friendly_name` varchar(255) DEFAULT NULL,
  `event_start` int(11) DEFAULT NULL,
  `event_end` int(11) DEFAULT NULL,
  `event_lat` decimal(20,16) DEFAULT NULL,
  `event_long` decimal(20,16) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `event_loc` mediumtext,
  `event_desc` mediumtext,
  `active` int(11) DEFAULT NULL,
  `event_stub` varchar(30) DEFAULT NULL,
  `event_icon` varchar(30) DEFAULT NULL,
  `pending` int(11) DEFAULT NULL,
  `event_hashtag` varchar(100) DEFAULT NULL,
  `event_href` varchar(600) DEFAULT NULL,
  `event_cfp_start` int(11) DEFAULT NULL,
  `event_cfp_end` int(11) DEFAULT NULL,
  `event_voting` varchar(1) DEFAULT NULL,
  `private` varchar(1) DEFAULT NULL,
  `event_tz_cont` varchar(30) DEFAULT NULL,
  `event_tz_place` varchar(70) DEFAULT NULL,
  `event_contact_name` varchar(200) DEFAULT NULL,
  `event_contact_email` varchar(200) DEFAULT NULL,
  `event_cfp_url` varchar(200) DEFAULT NULL,
  `comment_count` int(10) unsigned NOT NULL DEFAULT '0',
  `talk_count` int(10) unsigned NOT NULL DEFAULT '0',
  `track_count` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `url_friendly_name` (`url_friendly_name`),
  UNIQUE KEY `idx_unique_stub` (`event_stub`),
  KEY `idx_dates` (`event_start`,`event_end`),
  KEY `idx_active` (`active`,`pending`) USING BTREE,
  KEY `idx_cfp_dates` (`event_cfp_start`,`event_cfp_end`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES ('Reclaim the Legacy',NULL,1439848800,1439935199,0.0000000000000000,0.0000000000000000,52,'Skillsmatter','test',1,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'N','Europe','Amsterdam','test','test@test.com',NULL,0,2,0);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invite_list`
--

DROP TABLE IF EXISTS `invite_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invite_list` (
  `eid` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `accepted` varchar(1) DEFAULT NULL,
  `date_added` int(11) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invite_list`
--

LOCK TABLES `invite_list` WRITE;
/*!40000 ALTER TABLE `invite_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `invite_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lang`
--

DROP TABLE IF EXISTS `lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lang` (
  `lang_name` varchar(200) DEFAULT NULL,
  `lang_abbr` varchar(20) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang`
--

LOCK TABLES `lang` WRITE;
/*!40000 ALTER TABLE `lang` DISABLE KEYS */;
/*!40000 ALTER TABLE `lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meta_data`
--

DROP TABLE IF EXISTS `meta_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meta_data` (
  `entry` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meta_data`
--

LOCK TABLES `meta_data` WRITE;
/*!40000 ALTER TABLE `meta_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `meta_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_access_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consumer_key` varchar(30) NOT NULL,
  `access_token` varchar(16) NOT NULL,
  `access_token_secret` varchar(32) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_used_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_access_tokens`
--

LOCK TABLES `oauth_access_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_consumers`
--

DROP TABLE IF EXISTS `oauth_consumers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_consumers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consumer_key` varchar(30) NOT NULL,
  `consumer_secret` varchar(10) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  `application` varchar(255) DEFAULT NULL,
  `description` text,
  `callback_url` varchar(500) DEFAULT NULL,
  `enable_password_grant` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_consumers`
--

LOCK TABLES `oauth_consumers` WRITE;
/*!40000 ALTER TABLE `oauth_consumers` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_consumers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset_tokens` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patch_history`
--

DROP TABLE IF EXISTS `patch_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patch_history` (
  `patch_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `patch_number` int(11) DEFAULT NULL,
  `date_patched` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`patch_history_id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patch_history`
--

LOCK TABLES `patch_history` WRITE;
/*!40000 ALTER TABLE `patch_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `patch_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pending_talk_claims`
--

DROP TABLE IF EXISTS `pending_talk_claims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pending_talk_claims` (
  `talk_id` int(11) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `speaker_id` int(11) DEFAULT NULL,
  `date_added` int(11) DEFAULT NULL,
  `claim_id` int(11) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`),
  KEY `idx_talkid` (`talk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pending_talk_claims`
--

LOCK TABLES `pending_talk_claims` WRITE;
/*!40000 ALTER TABLE `pending_talk_claims` DISABLE KEYS */;
/*!40000 ALTER TABLE `pending_talk_claims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `tag_value` varchar(200) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags_events`
--

DROP TABLE IF EXISTS `tags_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags_events` (
  `event_id` int(11) DEFAULT NULL,
  `tag_id` int(11) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`),
  KEY `idx_eventid` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags_events`
--

LOCK TABLES `tags_events` WRITE;
/*!40000 ALTER TABLE `tags_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `talk_cat`
--

DROP TABLE IF EXISTS `talk_cat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `talk_cat` (
  `talk_id` int(11) DEFAULT NULL,
  `cat_id` int(11) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`),
  KEY `idx_talk` (`talk_id`),
  KEY `idx_talk_cat` (`talk_id`,`cat_id`)
) ENGINE=MyISAM AUTO_INCREMENT=205 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `talk_cat`
--

LOCK TABLES `talk_cat` WRITE;
/*!40000 ALTER TABLE `talk_cat` DISABLE KEYS */;
/*!40000 ALTER TABLE `talk_cat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `talk_comments`
--

DROP TABLE IF EXISTS `talk_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `talk_comments` (
  `talk_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `comment` mediumtext,
  `date_made` int(11) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `private` int(11) DEFAULT NULL,
  `active` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `comment_type` varchar(10) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_talk` (`talk_id`,`rating`),
  KEY `idx_userid` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=502 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `talk_comments`
--

LOCK TABLES `talk_comments` WRITE;
/*!40000 ALTER TABLE `talk_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `talk_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `talk_speaker`
--

DROP TABLE IF EXISTS `talk_speaker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `talk_speaker` (
  `talk_id` int(11) NOT NULL,
  `speaker_name` varchar(200) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `speaker_id` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `talk_id` (`talk_id`) USING BTREE,
  KEY `idx_speakerid` (`speaker_id`)
) ENGINE=MyISAM AUTO_INCREMENT=300 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `talk_speaker`
--

LOCK TABLES `talk_speaker` WRITE;
/*!40000 ALTER TABLE `talk_speaker` DISABLE KEYS */;
/*!40000 ALTER TABLE `talk_speaker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `talk_track`
--

DROP TABLE IF EXISTS `talk_track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `talk_track` (
  `talk_id` int(11) DEFAULT NULL,
  `track_id` int(11) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`),
  KEY `idx_talktracks` (`talk_id`,`track_id`) USING BTREE,
  KEY `idx_tracks` (`track_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `talk_track`
--

LOCK TABLES `talk_track` WRITE;
/*!40000 ALTER TABLE `talk_track` DISABLE KEYS */;
/*!40000 ALTER TABLE `talk_track` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `talks`
--

DROP TABLE IF EXISTS `talks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `talks` (
  `talk_title` text,
  `url_friendly_talk_title` varchar(255) DEFAULT NULL,
  `speaker` text,
  `slides_link` text,
  `date_given` int(11) DEFAULT NULL,
  `duration` int(11) NOT NULL,
  `event_id` int(11) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `talk_desc` mediumtext,
  `active` int(11) DEFAULT '1',
  `owner_id` int(11) DEFAULT NULL,
  `lang` int(11) DEFAULT NULL,
  `stub` char(5) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `stub` (`stub`),
  UNIQUE KEY `url_friendly_talk_title` (`url_friendly_talk_title`,`event_id`),
  KEY `idx_event` (`event_id`,`ID`) USING BTREE,
  KEY `stub_2` (`stub`,`active`)
) ENGINE=MyISAM AUTO_INCREMENT=206 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `talks`
--

LOCK TABLES `talks` WRITE;
/*!40000 ALTER TABLE `talks` DISABLE KEYS */;
/*!40000 ALTER TABLE `talks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `twitter_request_tokens`
--

DROP TABLE IF EXISTS `twitter_request_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twitter_request_tokens` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `secret` varchar(255) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `twitter_request_tokens`
--

LOCK TABLES `twitter_request_tokens` WRITE;
/*!40000 ALTER TABLE `twitter_request_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `twitter_request_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `last_login` int(11) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  `admin` int(11) DEFAULT NULL,
  `full_name` varchar(200) DEFAULT NULL,
  `active` int(11) DEFAULT NULL,
  `twitter_username` varchar(20) DEFAULT NULL,
  `request_code` char(8) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_username` (`username`),
  UNIQUE KEY `idx_email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_admin`
--

DROP TABLE IF EXISTS `user_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_admin` (
  `uid` int(11) DEFAULT NULL,
  `rid` int(11) DEFAULT NULL,
  `rtype` varchar(20) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `rcode` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_event` (`rid`)
) ENGINE=MyISAM AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_admin`
--

LOCK TABLES `user_admin` WRITE;
/*!40000 ALTER TABLE `user_admin` DISABLE KEYS */;
INSERT INTO `user_admin` VALUES (0,52,'event',71,'');
/*!40000 ALTER TABLE `user_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_attend`
--

DROP TABLE IF EXISTS `user_attend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_attend` (
  `uid` int(11) DEFAULT NULL,
  `eid` int(11) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_unique_user_event` (`uid`,`eid`),
  KEY `idx_event` (`eid`)
) ENGINE=MyISAM AUTO_INCREMENT=296 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_attend`
--

LOCK TABLES `user_attend` WRITE;
/*!40000 ALTER TABLE `user_attend` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_attend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_talk_star`
--

DROP TABLE IF EXISTS `user_talk_star`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_talk_star` (
  `uid` int(11) NOT NULL,
  `tid` int(11) NOT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `idx_unique_user_talk` (`uid`,`tid`),
  KEY `idx_talk` (`tid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_talk_star`
--

--
-- Dumping routines for database 'joindin'
--
/*!50003 DROP FUNCTION IF EXISTS `get_talk_rating` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_talk_rating`(talk_id INT) RETURNS int(11)
    READS SQL DATA
BEGIN
	DECLARE rating_out INT;
	DECLARE EXIT HANDLER FOR NOT FOUND RETURN NULL;

	SELECT IFNULL(ROUND(AVG(rating)), 0) INTO rating_out
	FROM talk_comments tc
	WHERE
		tc.talk_id = talk_id AND
		tc.rating != 0 AND
		tc.private = 0 AND
		tc.user_id NOT IN
		(
			SELECT IFNULL(ts.speaker_id,0) FROM talk_speaker ts WHERE ts.talk_id = talk_id
			UNION
			SELECT 0
		);

	RETURN rating_out;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-09-14 10:50:01

LOCK TABLES `user_talk_star` WRITE;
/*!40000 ALTER TABLE `user_talk_star` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_talk_star` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-08-18 12:39:57

