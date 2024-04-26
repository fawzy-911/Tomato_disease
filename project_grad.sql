-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 27, 2024 at 01:19 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project_grad`
--

-- --------------------------------------------------------

--
-- Table structure for table `tomato_disease`
--

CREATE TABLE `tomato_disease` (
  `id` int(11) NOT NULL,
  `disease_name` varchar(100) NOT NULL,
  `treatment_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tomato_disease`
--

INSERT INTO `tomato_disease` (`id`, `disease_name`, `treatment_id`) VALUES
(1, 'Bacterial Spot', 1),
(2, 'Early Blight', 2),
(3, 'Late Blight ', 3),
(4, 'Leaf Mold', 4),
(5, 'Septoria_leaf_spot', 5),
(6, 'Mosaic_Virus', 9),
(7, 'Yellow_Leaf_Curl_Virus', 8),
(8, 'Target_Spot', 7),
(9, 'Spider_mites', 6),
(10, 'Two-spotted-spider-mite', 6);

-- --------------------------------------------------------

--
-- Table structure for table `treatment`
--

CREATE TABLE `treatment` (
  `id` int(11) NOT NULL,
  `about_disease` text NOT NULL,
  `preventing_spread` text NOT NULL,
  `protect_healthy_tomato` text NOT NULL,
  `treatment` text NOT NULL,
  `disease_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `treatment`
--

INSERT INTO `treatment` (`id`, `about_disease`, `preventing_spread`, `protect_healthy_tomato`, `treatment`, `disease_id`) VALUES
(1, 'A bacterial disease causing small, dark spots with yellowish halos on leaves.  ', 'Rotate crops every 2-3 years.\r\nKeep weeds and old tomato/pepper plants under control.\r\nRemove and dispose of infected leaves early on.', 'Use disease-free seeds and transplants.\r\nTreat seeds by soaking in a 10% bleach solution.\r\nHot water treatment can reduce bacteria in seeds.\r\nRotate crops and follow good cultural practices.\r\nAvoid watering overhead.\r\nHandle plants when dry to prevent spread.', 'Copper products or copper with mancozeb can control bacterial spot.\r\nFor greenhouse transplants, use Streptomycin to control bacterial spot.', 1),
(2, 'A fungal disease causing brown spots with concentric rings on lower leaves.', 'Remove infected plant residues from fields.\r\nRotate crops to reduce early blight spores.', 'Change farming practices to deter disease and pests.\r\nRotate different crops in the same area each season.\r\nUse mulch to prevent soil splashing onto tomato leaves.\r\nPlant resistant tomato varieties.\r\nStart with disease-free seeds.', 'Consider using biocontrol agents for eco-friendly management.\r\nApply the fungicide mancozeb to control early blight and boost yields.\r\nSome plant extracts have antimicrobial properties against early blight', 2),
(3, 'Destructive fungal disease affecting all parts of tomato plants.', 'Avoid planting tomatoes near or in areas previously used for potatoes.', 'Use bottom-watering with drip irrigation.\r\nSpace plants widely for better air circulation.\r\nAvoid handling plants when foliage is wet.\r\nMulch with plastic or organic material to reduce disease.\r\nApply protectant fungicides like chlorothalonil or mancozeb.\r\nOrganic gardeners can use fixed copper products like Kocide.\r\nBegin weekly fungicide sprays after transplanting in favorable conditions.', 'Continue weekly fungicide sprays to prevent further infection.\r\nRemove severely infected plants and dispose of them properly.\r\nDo not compost diseased plants.\r\nAvoid harvesting tomatoes with visible disease lesions.', 3),
(4, 'Disease causing yellowish spots on older leaves, leading to overall yellowing.', 'Remove and burn all plant debris after harvest.', 'Optimal row and plant spacing for better air circulation.\r\nAvoid excessive nitrogen fertilization, as it promotes foliage diseases.\r\nMaintain humidity below 85%, especially in greenhouses.\r\nEnsure good air circulation in greenhouses.\r\nConsider early planting and seed treatment with hot water.\r\nUse resistant cultivars when possible.', 'Remove infected plants immediately and sanitize the greenhouse.\r\nSpray fungicides like chlorothalonil, maneb, mancozeb, or copper upon symptom appearance.', 4),
(5, 'Fungal disease causing small, dark-centered circular spots on leaves.\r\n', 'Remove and burn all plant debris after harvest.\r\nControl weeds and practice crop rotation.', 'Optimal row and plant spacing for improved air circulation.\r\nAvoid excessive nitrogen fertilization to prevent disease development.\r\nConsider using resistant cultivars.', 'Remove diseased leaves promptly.\r\nEnhance air circulation around plants.\r\nApply fungicidal sprays as needed.', 5),
(6, 'Tiny pests that feed on plant sap, causing yellow stippling on leaves.', 'Management Actions:\r\nRotate miticides to prevent chemical resistance.\r\nManage weeds, especially blackberry nightshade and glossy nightshade.\r\nTreat, remove, or quarantine infested plants to prevent spread.', 'Maintain adequate row and plant spacing to promote air circulation, reducing humidity.\r\nAvoid excessive nitrogen fertilization, as it can exacerbate foliage disease development.\r\nUse resistant cultivars when available.\r\nImplement proper weed control measures to reduce potential disease hosts.\r\nPractice early planting to mitigate disease severity.\r\nConsider seed treatment with hot water for additional protection against disease.', 'Implement biosecurity best practices to prevent pest entry, establishment, and spread.\r\nPractice good farm hygiene (\"Come Clean, Go Clean\").\r\nEnsure staff and visitors follow hygiene protocols.\r\nSource propagation material from reputable suppliers with high health status.\r\nRegularly monitor crops for signs of infestation.\r\nMaintain thorough records of pest management activities.', 9),
(7, 'Target spot, a fungal disease, manifests as concentric rings on tomato leaves, resembling a target pattern.', 'Collect and burn crop residues post-harvest to reduce overwintering potential.\r\nPractice crop rotation, allowing at least a 3-year gap before replanting tomatoes in the same area.', 'Prune lower branches to improve airflow around the base of plants.\r\nPromptly remove and burn lower leaves upon disease detection, especially post lower fruit truss harvest.\r\nMaintain weed-free plots to eliminate potential fungal hosts.\r\nAvoid overhead irrigation to mitigate spore production and infection risks.', 'Fungicides are necessary in warm, wet conditions for effective control.\r\nRecommended fungicides include chlorothalonil, copper oxychloride, or mancozeb.\r\nInitiate treatment upon spotting initial signs, continuing at 10-14-day intervals until 3-4 weeks before the final harvest.\r\nEnsure thorough spraying of both leaf surfaces for optimal efficacy.', 8),
(8, 'This viral infection induces leaf curling and yellowing in tomato plants.', 'Cultural Practices:\r\nBegin the season with virus-free transplants.\r\nUtilize certified disease-free seeds or treat seeds accordingly.\r\nEmploy methods like soaking seeds in a trisodium phosphate solution or heat treatment.\r\nPurchase transplants from reputable sources with strict sanitation procedures.\r\nInspect transplants for symptoms before purchase.\r\nAvoid greenhouse environments with potential virus reservoirs like perennial ornamentals.\r\nRotation:\r\nRefrain from planting in fields containing tomato root debris to prevent long-term virus survival.\r\nSanitation:\r\nWash hands before and during plant handling to minimize transmission.\r\nRegularly disinfect tools, preferably between each plant, using effective solutions.\r\nAvoid using tobacco products around tomato plants and practice proper hand hygiene.\r\nEmploy stringent sanitation procedures upon virus confirmation, including burning infected plants and disinfecting tools.\r\nKeep separate tools for diseased and healthy plant areas to prevent cross-contamination.\r\nEnd-of-Season Measures:\r\nDispose of all plants from diseased areas, including seemingly healthy ones, through burning or burying.\r\nDisinfect equipment between growing seasons using appropriate methods.\r\nPesticide Use:\r\nChemical options are currently ineffective against these viruses.\r\nManage aphids and thrips during transplant production to mitigate virus spread.', '(Not applicable for viral diseases as there are no direct protective measures.)', '(Not applicable for viral diseases as there are no direct treatment options.)', 7),
(9, 'Characterized by a mottled appearance on leaves, displaying patches of yellow and green', 'Cultural Practices:\r\nBegin the season with virus-free transplants.\r\nUtilize certified disease-free seeds or treat seeds accordingly.\r\nEmploy methods like soaking seeds in a trisodium phosphate solution or heat treatment.\r\nPurchase transplants from reputable sources with strict sanitation procedures.\r\nInspect transplants for symptoms before purchase.\r\nAvoid greenhouse environments with potential virus reservoirs like perennial ornamentals.\r\nRotation:\r\nRefrain from planting in fields containing tomato root debris to prevent long-term virus survival.\r\nSanitation:\r\nWash hands before and during plant handling to minimize transmission.\r\nRegularly disinfect tools, preferably between each plant, using effective solutions.\r\nAvoid using tobacco products around tomato plants and practice proper hand hygiene.\r\nEmploy stringent sanitation procedures upon virus confirmation, including burning infected plants and disinfecting tools.\r\nKeep separate tools for diseased and healthy plant areas to prevent cross-contamination.\r\nEnd-of-Season Measures:\r\nDispose of all plants from diseased areas, including seemingly healthy ones, through burning or burying.\r\nDisinfect equipment between growing seasons using appropriate methods.\r\nPesticide Use:\r\nChemical options are currently ineffective against these viruses.\r\nManage aphids and thrips during transplant production to mitigate virus spread.', '(Not applicable for viral diseases as there are no direct protective measures.)', '(Not applicable for viral diseases as there are no direct treatment options.)', 6);

-- --------------------------------------------------------

--
-- Table structure for table `treatments`
--

CREATE TABLE `treatments` (
  `id` int(11) NOT NULL,
  `treatment` text NOT NULL,
  `disease_id` int(11) NOT NULL,
  `disease_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `treatments`
--

INSERT INTO `treatments` (`id`, `treatment`, `disease_id`, `disease_name`) VALUES
(1, 'Remove diseased leaves promptly.\r\nEnhance air circulation around plants.\r\nApply fungicidal sprays as needed.', 5, 'Septoria_leaf_spot'),
(2, 'Copper products or copper with mancozeb can control bacterial spot.\r\nFor greenhouse transplants, use Streptomycin to control bacterial spot.', 1, '');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`) VALUES
(1, 'ahmed12', 'ahmed@9.com', '1234567'),
(2, 'Salma8', 'salma@bravo.com', '123456789'),
(3, 'fawzy19', 'fawzy19@gmail.com', '1234567'),
(4, 'sara9', 'Sarabravo@gmail.com', '123456'),
(5, 'Dina', 'dina@jeo.com', '123456'),
(6, 'nada8', 'nada@gmail.com', '123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tomato_disease`
--
ALTER TABLE `tomato_disease`
  ADD PRIMARY KEY (`id`),
  ADD KEY `treatment_id` (`treatment_id`),
  ADD KEY `treatment_id_2` (`treatment_id`),
  ADD KEY `treatment_id_3` (`treatment_id`);

--
-- Indexes for table `treatment`
--
ALTER TABLE `treatment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `disease_id` (`disease_id`),
  ADD KEY `disease_id_2` (`disease_id`);

--
-- Indexes for table `treatments`
--
ALTER TABLE `treatments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `disease_id` (`disease_id`),
  ADD KEY `disease_id_2` (`disease_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tomato_disease`
--
ALTER TABLE `tomato_disease`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `treatment`
--
ALTER TABLE `treatment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `treatments`
--
ALTER TABLE `treatments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tomato_disease`
--
ALTER TABLE `tomato_disease`
  ADD CONSTRAINT `tomato_disease_ibfk_1` FOREIGN KEY (`treatment_id`) REFERENCES `treatment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `treatment`
--
ALTER TABLE `treatment`
  ADD CONSTRAINT `treatment_ibfk_1` FOREIGN KEY (`disease_id`) REFERENCES `tomato_disease` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `treatments`
--
ALTER TABLE `treatments`
  ADD CONSTRAINT `treatments_ibfk_1` FOREIGN KEY (`disease_id`) REFERENCES `tomato_disease` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
