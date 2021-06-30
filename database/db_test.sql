-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 25, 2021 at 01:07 PM
-- Server version: 8.0.23
-- PHP Version: 7.4.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_test`
--

-- --------------------------------------------------------

--
-- Table structure for table `table_absent`
--

CREATE TABLE `table_absent` (
  `id_absent` int NOT NULL,
  `id_user_absent` varchar(255) NOT NULL,
  `date_absent` varchar(255) NOT NULL,
  `absen_in_absent` varchar(255) NOT NULL,
  `absen_out_absent` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `table_absent`
--

INSERT INTO `table_absent` (`id_absent`, `id_user_absent`, `date_absent`, `absen_in_absent`, `absen_out_absent`) VALUES
(3, '1', '2021-06-19', '2021-06-19 08:00', '2021-06-19 21:30'),
(4, '1', '2021-06-21', '2021-06-21 07:00', '2021-06-21 20:00');

-- --------------------------------------------------------

--
-- Table structure for table `table_user`
--

CREATE TABLE `table_user` (
  `id_user` int NOT NULL,
  `name_user` varchar(255) NOT NULL,
  `email_user` varchar(255) NOT NULL,
  `pass_user` varchar(255) NOT NULL,
  `token_login_user` varchar(255) NOT NULL,
  `last_login_user` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `table_user`
--

INSERT INTO `table_user` (`id_user`, `name_user`, `email_user`, `pass_user`, `token_login_user`, `last_login_user`) VALUES
(1, 'Test', 'eddyhu71@gmail.com', '72399361da6a7754fec986dca5b7cbaf1c810a28ded4abaf56b2106d06cb78b0', '56add208e6d2c4b07c7920cf1c6e2b31', '16-06-2021 11:47');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `table_absent`
--
ALTER TABLE `table_absent`
  ADD PRIMARY KEY (`id_absent`);

--
-- Indexes for table `table_user`
--
ALTER TABLE `table_user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `table_absent`
--
ALTER TABLE `table_absent`
  MODIFY `id_absent` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `table_user`
--
ALTER TABLE `table_user`
  MODIFY `id_user` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
