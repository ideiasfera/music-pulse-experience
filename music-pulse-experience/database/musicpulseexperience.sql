-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 01-Nov-2020 às 06:26
-- Versão do servidor: 10.4.14-MariaDB
-- versão do PHP: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `musicpulseexperience`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `beat`
--

CREATE TABLE `beat` (
  `beatId` int(10) UNSIGNED NOT NULL,
  `beatperminute` int(11) NOT NULL,
  `users` int(10) UNSIGNED NOT NULL,
  `dateregister` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `image`
--

CREATE TABLE `image` (
  `imageId` int(10) UNSIGNED NOT NULL,
  `image` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `music` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `music`
--

CREATE TABLE `music` (
  `musicId` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `artist` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `duration` int(11) NOT NULL,
  `image` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `creationdate` date NOT NULL,
  `link` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `channel` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `way` varchar(10) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `suggestion`
--

CREATE TABLE `suggestion` (
  `suggestionId` int(10) UNSIGNED NOT NULL,
  `image` int(10) UNSIGNED NOT NULL,
  `beat` int(10) UNSIGNED NOT NULL,
  `liked` tinyint(1) NOT NULL,
  `dateregister` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

CREATE TABLE `users` (
  `userId` int(10) UNSIGNED NOT NULL,
  `name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `dateofbirth` date DEFAULT NULL,
  `height` float DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `sex` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `way` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`userId`, `name`, `email`, `password`, `dateofbirth`, `height`, `weight`, `sex`, `way`) VALUES
(4, '', 'fernando.maransatto@gmail.com', '$2b$10$YdCPbK7w05ybJmPQJXvhu.uJCm0YXHvLVYjbPOclf53TuMIpxkjIG', NULL, NULL, NULL, NULL, NULL),
(5, '', 'ideiasfera@gmail.com', '$2b$10$h1YWu/SaHzUClkHQJGdSa.kuOwh5WwSRuuMxVqpcx/fEp7FMxJQve', NULL, NULL, NULL, NULL, NULL);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `beat`
--
ALTER TABLE `beat`
  ADD PRIMARY KEY (`beatId`),
  ADD UNIQUE KEY `beatId_UNIQUE` (`beatId`),
  ADD KEY `userbeat_idx` (`users`);

--
-- Índices para tabela `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`imageId`),
  ADD UNIQUE KEY `imageId_UNIQUE` (`imageId`),
  ADD KEY `musicimage_idx` (`music`);

--
-- Índices para tabela `music`
--
ALTER TABLE `music`
  ADD PRIMARY KEY (`musicId`),
  ADD UNIQUE KEY `musicId_UNIQUE` (`musicId`);

--
-- Índices para tabela `suggestion`
--
ALTER TABLE `suggestion`
  ADD PRIMARY KEY (`suggestionId`),
  ADD UNIQUE KEY `suggestionId_UNIQUE` (`suggestionId`),
  ADD KEY `suggestionimage_idx` (`image`),
  ADD KEY `beatsuggestion_idx` (`beat`);

--
-- Índices para tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userId`),
  ADD UNIQUE KEY `userId_UNIQUE` (`userId`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `beat`
--
ALTER TABLE `beat`
  MODIFY `beatId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `image`
--
ALTER TABLE `image`
  MODIFY `imageId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `music`
--
ALTER TABLE `music`
  MODIFY `musicId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `suggestion`
--
ALTER TABLE `suggestion`
  MODIFY `suggestionId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `userId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `beat`
--
ALTER TABLE `beat`
  ADD CONSTRAINT `userbeat` FOREIGN KEY (`users`) REFERENCES `users` (`userId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `image`
--
ALTER TABLE `image`
  ADD CONSTRAINT `musicimage` FOREIGN KEY (`music`) REFERENCES `music` (`musicId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `suggestion`
--
ALTER TABLE `suggestion`
  ADD CONSTRAINT `beatsuggestion` FOREIGN KEY (`beat`) REFERENCES `beat` (`beatId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `suggestionimage` FOREIGN KEY (`image`) REFERENCES `image` (`imageId`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
