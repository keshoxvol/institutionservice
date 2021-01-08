-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 29, 2020 at 10:35 AM
-- Server version: 10.3.22-MariaDB
-- PHP Version: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blue-chips`
--

-- --------------------------------------------------------

--
-- Table structure for table `signals`
--

CREATE TABLE `signals` (
  `stock_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `value` float UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `signals`
--

INSERT INTO `signals` (`stock_id`, `user_id`, `value`) VALUES
(8, 306394615, 437);

-- --------------------------------------------------------

--
-- Table structure for table `stocks`
--

CREATE TABLE `stocks` (
  `stock_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `link` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_price` float NOT NULL DEFAULT 0,
  `current_price` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stocks`
--

INSERT INTO `stocks` (`stock_id`, `name`, `link`, `last_price`, `current_price`) VALUES
(1, 'gazp', 'https://www.google.com/search?sxsrf=ALeKk022U-aVZ3Lz5a3JcBb01TtFPxlgcQ%3A1587243383217&ei=d2mbXpXIDO_mrgSa1Z6oDA&q=%D1%86%D0%B5%D0%BD%D0%B0+%D0%B0%D0%BA%D1%86%D0%B8%D0%B8+%D0%B3%D0%B0%D0%B7%D0%BF%D1%80%D0%BE%D0%BC&oq=%D1%86%D0%B5%D0%BD%D0%B0+%D0%B0%D0%BA%D1%86%D0%B8%D0%B8+&gs_lcp=CgZwc3ktYWIQAxgBMgUIABDLATIFCAAQywEyBQgAEMsBMgUIABDLATIFCAAQywEyBQgAEMsBMgUIABDLATIFCAAQywEyBQgAEMsBMgUIABDLAToECAAQRzoKCAAQywEQRhD6AVDsIViQKGD7L2gAcAR4AIABSYgBiAOSAQE2mAEAoAEBqgEHZ3dzLXdpeg&sclient=psy-ab', 206.79, 207.01),
(2, 'sber', 'https://www.google.com/search?sxsrf=ALeKk00gYckIx_MetRh-15wwgk88LyAlwA%3A1587244999096&ei=x2-bXq2mBaHMrgT_9ovQDQ&q=%D0%B0%D0%BA%D1%86%D0%B8%D0%B8+%D1%81%D0%B1%D0%B5%D1%80%D0%B1%D0%B0%D0%BD%D0%BA&oq=%D0%B0%D0%BA%D1%86%D0%B8%D0%B8+%D1%81%D0%B1%D0%B5%D1%80%D0%B1%D0%B0%D0%BD%D0%BA&gs_lcp=CgZwc3ktYWIQAzIECAAQRzIECAAQRzIECAAQRzIECAAQRzIECAAQRzIECAAQRzIECAAQRzIECAAQR1CDCFiDCGCFCmgAcAJ4AIABAIgBAJIBAJgBAKABAaoBB2d3cy13aXo&sclient=psy-ab&ved=0ahUKEwjtpd6y9PLoAhUhposKHX_7AtoQ4dUDCAw&uact=5', 275.4, 275.84),
(3, 'lkoh', 'https://www.google.com/search?q=%D0%B0%D0%BA%D1%86%D0%B8%D0%B8+%D0%BB%D1%83%D0%BA%D0%BE%D0%B9%D0%BB&oq=%D0%B0%D0%BA%D1%86%D0%B8%D0%B8+%D0%BB%D1%83%D0%BA%D0%BE&aqs=chrome.0.0j69i57j0l6.3484j1j7&sourceid=chrome&ie=UTF-8', 5122.5, 5128.5),
(4, 'mgnt', 'https://www.google.com/search?sxsrf=ALeKk020FUcntQud9b7BY5B-Z4qbqz7OzQ%3A1587245077567&ei=FXCbXseFIomcrgTr1pLIAw&q=%D0%B0%D0%BA%D1%86%D0%B8%D0%B8+mgnt&oq=%D0%B0%D0%BA%D1%86%D0%B8%D0%B8+mgnt&gs_lcp=CgZwc3ktYWIQAzIKCAAQywEQRhD6ATIGCAAQFhAeOgQIABBHOgkIIxAnEBMQnQI6BQgAEMsBOgcIABAKEMsBOggIABAWEAoQHlC-aFj7c2DydGgAcAJ4AYAB-wKIAcYFkgEFNS4zLTGYAQCgAQGqAQdnd3Mtd2l6&sclient=psy-ab&ved=0ahUKEwiH5JPY9PLoAhUJjosKHWurBDkQ4dUDCAw&uact=5', 5648.5, 5647.5),
(5, 'nvtk', 'https://www.google.com/search?q=%D0%B0%D0%BA%D1%86%D0%B8%D0%B8+%D0%BD%D0%BE%D0%B2%D0%B0%D1%82%D1%8D%D0%BA&oq=%D0%B0%D0%BA%D1%86%D0%B8%D0%B8+%D0%BD%D0%BE%D0%B2%D0%B0%D1%82%D1%8D%D0%BA&aqs=chrome..69i57j0l7.5043j1j7&sourceid=chrome&ie=UTF-8', 1242.8, 1243.2),
(6, 'sngs', 'https://www.google.com/search?sxsrf=ALeKk01rSGTjZAZVlqicw5VFIncjmHd8QA%3A1587245187384&ei=g3CbXoKCF-rlrgT2pb-4Cg&q=sngs&oq=sngs&gs_lcp=CgZwc3ktYWIQAzIGCAAQChBDMgIIADICCAAyBAgAEAoyAggAMgQIABAKMgQIABAKMgQIABAKMgQIABAKMgQIABAKOgQIABBHOgQIIxAnOgcIIxDqAhAnOgUIABCRAjoECAAQQ1CPLFjZa2CibWgCcAR4AIABSIgBkQOSAQE2mAEAoAEBqgEHZ3dzLXdperABCg&sclient=psy-ab&ved=0ahUKEwjCz8KM9fLoAhXqsosKHfbSD6cQ4dUDCAw&uact=5', 35.4, 35.42),
(7, 'gmkn', 'https://www.google.com/search?sxsrf=ALeKk02ZbXRffPQG3bDezwekgPaS-rLr0w%3A1587245242780&ei=unCbXtOYL6iprgTv_6NI&q=%D0%BD%D0%BE%D1%80%D0%BD%D0%B8%D0%BA%D0%B5%D0%BB%D1%8C+%D0%B0%D0%BA%D1%86%D0%B8%D0%B8&oq=%D0%BD%D0%BE%D1%80%D0%BD%D0%B8%D0%BA%D0%B5%D0%BB%D1%8C+%D0%B0&gs_lcp=CgZwc3ktYWIQARgAMgwIIxAnEJ0CEEYQ-gEyBQgAEMsBMgUIABDLATIFCAAQywEyBQgAEMsBMgUIABDLATIFCAAQywEyBQgAEMsBMgUIABDLATIFCAAQywE6BAgAEEdQsApYwg5gjxNoAHADeACAAekCiAGuA5IBBTEuMy0xmAEAoAEBqgEHZ3dzLXdpeg&sclient=psy-ab', 23654, 23648),
(8, 'rosn', 'https://www.google.com/search?sxsrf=ALeKk03oimy8WPMp-GD-BkEfGVbQ2KQLrg%3A1587245246214&ei=vnCbXtzZDKL6qwH6wq7YDg&q=%D1%80%D0%BE%D1%81%D0%BD%D0%B5%D1%84%D1%82%D1%8C+%D0%B0%D0%BA%D1%86%D0%B8%D0%B8&oq=hjcyt&gs_lcp=CgZwc3ktYWIQAxgBMgsIABAKEAEQywEQKjIJCAAQChABEMsBMgkIABAKEAEQywEyCQgAEAoQARDLATIJCAAQChABEMsBMgkIABAKEAEQywEyCQgAEAoQARDLATIJCAAQChABEMsBMgkIABAKEAEQywEyCQgAEAoQARDLAToECAAQRzoECCMQJzoFCAAQkQI6AggAOgYIABAKECo6BAgAEAo6BAgAEB46BggAEAoQHlDNlgRYrpsEYK2kBGgAcAF4AIABU4gBuwKSAQE1mAEAoAEBqgEHZ3dzLXdpeg&sclient=psy-ab', 437.4, 438.05),
(9, 'nlmk', 'https://www.google.com/search?sxsrf=ALeKk02goxVc3PZqeOtuwSV96FzV4OAd-g%3A1587245317113&ei=BXGbXu3CBoeprgT4wK7IBQ&q=%D0%BD%D0%BB%D0%BC%D0%BA+%D0%B0%D0%BA%D1%86%D0%B8%D0%B8&oq=%D0%BD%D0%BB%D0%BC&gs_lcp=CgZwc3ktYWIQARgAMgwIIxAnEJ0CEEYQ-gEyBAgjECcyAggAMgIIADICCAAyAggAMgIIADIECAAQHjIECAAQHjIECAAQHjoECAAQRzoECAAQQzoHCCMQ6gIQJzoGCCMQJxATULNsWPmLAWDQlgFoAXABeAGAAd8HiAG1D5IBCzEuMy0xLjAuMS4xmAEAoAEBqgEHZ3dzLXdperABCg&sclient=psy-ab', 219.68, 219.72),
(10, 'tatn', 'https://www.google.com/search?sxsrf=ALeKk03hsWAETQTkUveyK3ywbtkE4ImXGQ%3A1587245337277&ei=GXGbXp-_EM_2qwG6gqv4Bg&q=tatn+%D0%B0%D0%BA%D1%86%D0%B8%D0%B8&oq=tatn+&gs_lcp=CgZwc3ktYWIQAxgAMgUIABDLATIFCAAQywEyBQgAEMsBMgIIADIFCAAQywEyBQgAEMsBMgUIABDLATIFCAAQywEyBQgAEMsBMgUIABDLAToECAAQRzoECCMQJzoFCAAQkQI6BAgAEEM6BwgjEOoCECc6BAgAEApQ2egBWKT1AWDg-gFoAnACeACAAU6IAdgDkgEBN5gBAKABAaoBB2d3cy13aXqwAQo&sclient=psy-ab', 507.1, 507),
(11, 'mtss', 'https://www.google.com/search?sxsrf=ALeKk03AcgcZUWYwd7nHCmHNGhmBYKUM0w%3A1587245370332&ei=OnGbXrbIEtLmrgSYlqnoDw&q=mts+%D0%B0%D0%BA%D1%86%D0%B8%D0%B8&oq=mts+%D0%B0%D0%BA%D1%86%D0%B8%D0%B8&gs_lcp=CgZwc3ktYWIQAzIFCAAQywEyBQgAEMsBMgcIABAKEMsBMgQIABAeMgYIABAHEB4yBggAEAcQHjIGCAAQBxAeMgYIABAHEB4yCAgAEAcQBRAeMggIABAHEAUQHjoECAAQRzoECCMQJzoFCAAQkQI6BAgAEEM6AggAOg4IIxAnEBMQnQIQRhD6AToICAAQFhAKEB46DwgjELACECcQnQIQRhD6AToICAAQBxAeEBM6CggAEAcQBRAeEBM6CAgAEAcQChAeOgYIIxAnEBNQ3Z8BWJOcAmCTnQJoCnABeACAAfoCiAGUCZIBBjEyLjMtMZgBAKABAaoBB2d3cy13aXo&sclient=psy-ab&ved=0ahUKEwi2zd_j9fLoAhVSs4sKHRhLCv0Q4dUDCAw&uact=5', 328, 328.2),
(12, 'alrs', 'https://www.google.com/search?sxsrf=ALeKk01cOlJchEEFfsrlZVbReaHYxD_7CA%3A1587245407717&ei=X3GbXqucK4uNrwSX_bb4DQ&q=akhjcf+%D0%B0%D0%BA%D1%86%D0%B8%D0%B8&oq=akhjcf+%D0%B0%D0%BA%D1%86%D0%B8%D0%B8&gs_lcp=CgZwc3ktYWIQAzIGCAAQDRAeOgQIABBHOgcIIxCwAhAnOgYIABAHEB46BAgAEA06BAgjECc6BggjECcQEzoFCAAQywE6CAgAEAcQChAeOggIABAIEAcQHlDT-ANYzI0EYNWOBGgAcAF4AIABS4gBjwSSAQE4mAEAoAEBqgEHZ3dzLXdpeg&sclient=psy-ab&ved=0ahUKEwjrx8r19fLoAhWLxosKHZe-Dd8Q4dUDCAw&uact=5', 97.78, 97.79),
(13, 'yndx', 'https://www.google.com/search?sxsrf=ALeKk004UXdkcnoerk9zqJ5X_hyUkJv_3A%3A1587245476006&ei=o3GbXuTqPOSprgTI8KiwDQ&q=yandex+frwbb&oq=yandex+frwbb&gs_lcp=CgZwc3ktYWIQAzIMCAAQChDLARBGEPoBMgYIABANEB4yBggAEA0QHjIGCAAQFhAeMgYIABAWEB4yBggAEBYQHjIGCAAQFhAeMgYIABAWEB4yBggAEBYQHjIGCAAQFhAeOgQIABBHOgQIIxAnOgYIIxAnEBM6BQgAEJECOgIIADoECAAQQzoFCAAQywE6BwgAEAoQywFQtnRY7JYBYIqYAWgBcAF4AIABTYgBtQaSAQIxM5gBAKABAaoBB2d3cy13aXo&sclient=psy-ab&ved=0ahUKEwikyJKW9vLoAhXklIsKHUg4CtYQ4dUDCAw&uact=5', 5031.2, 5033.4),
(14, 'five', 'https://www.google.com/search?sxsrf=ALeKk03c8F1hsakPJ7T95GZmsz48lJ75fQ%3A1587245496356&ei=uHGbXqqzFfDmrgT4xJ2wDQ&q=x5+retail+group+%D0%B0%D0%BA%D1%86%D0%B8%D0%B8&oq=x5+retail+group+&gs_lcp=CgZwc3ktYWIQAxgAMgUIABDLATIFCAAQywEyBQgAEMsBMgUIABDLATIFCAAQywEyBQgAEMsBMgUIABDLATICCAAyBQgAEMsBMgUIABDLAToECAAQRzoFCAAQkQI6BwgAEAoQywE6BggAEBYQHlD-qwFY7MoBYKHPAWgBcAF4AIABS4gB1AKSAQE1mAEAoAEBqgEHZ3dzLXdpeg&sclient=psy-ab', 2752.5, 2754.5),
(15, 'chmf', 'https://www.google.com/search?sxsrf=ALeKk01P3oJnAde-b9ulRWVSmzfJlA8UgQ%3A1587245523799&ei=03GbXp6sMIuwrgSYnIOYDQ&q=ctdthcnfkm+frwbb&oq=ctdthcnfkm+frwbb&gs_lcp=CgZwc3ktYWIQAzIQCAAQChABEMsBECoQRhD6ATIGCAAQFhAeMggIABAWEAoQHjoECAAQRzoECCMQJzoFCAAQkQI6AggAOgQIABBDOgcIIxDqAhAnOgQIABAKOgYIABAKECo6CwgAEAoQARDLARAqOgkIABAKEAEQywFQ65YBWO61AWCytwFoBHABeACAAU2IAfcHkgECMTaYAQCgAQGqAQdnd3Mtd2l6sAEK&sclient=psy-ab&ved=0ahUKEwje4fes9vLoAhULmIsKHRjOANMQ4dUDCAw&uact=5', 1370.4, 1370.2);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `action` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `extra_data` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `signals`
--
ALTER TABLE `signals`
  ADD UNIQUE KEY `stock_id` (`stock_id`,`user_id`);

--
-- Indexes for table `stocks`
--
ALTER TABLE `stocks`
  ADD PRIMARY KEY (`stock_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `stocks`
--
ALTER TABLE `stocks`
  MODIFY `stock_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
