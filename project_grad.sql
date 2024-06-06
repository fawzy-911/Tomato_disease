-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 06, 2024 at 10:36 PM
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
-- Table structure for table `additional_tasks`
--

CREATE TABLE `additional_tasks` (
  `id` int(11) NOT NULL,
  `task` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `disease_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `additional_tasks`
--

INSERT INTO `additional_tasks` (`id`, `task`, `user_id`, `disease_id`) VALUES
(2, 'Remove heavily infected leaves and debris', 15, 5),
(3, 'Identify and prune out the infected leaves.', 16, 2);

-- --------------------------------------------------------

--
-- Table structure for table `journals`
--

CREATE TABLE `journals` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `Plant_age` varchar(100) NOT NULL,
  `image` varchar(255) NOT NULL,
  `Disease_name` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `treatment_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `journals`
--

INSERT INTO `journals` (`id`, `title`, `date`, `Plant_age`, `image`, `Disease_name`, `user_id`, `treatment_id`) VALUES
(8, 'Journal3', '0000-00-00 00:00:00', '4', 'tomato2.jpeg', 'Septoria_leaf_spot', 15, 5),
(10, 'journal4', '2024-05-29 20:47:58', '10', '', 'Bacterial Spot', 15, 1),
(11, 'Journal5', '2024-06-16 21:00:00', '7', 'tomato.jpeg', 'Early_blight', 16, 2);

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
(2, 'Early_blight', 2),
(3, ' Late_blight', 3),
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
  `Detailed_instructions` text NOT NULL,
  `disease_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `treatment`
--

INSERT INTO `treatment` (`id`, `about_disease`, `preventing_spread`, `protect_healthy_tomato`, `treatment`, `Detailed_instructions`, `disease_id`) VALUES
(1, 'A bacterial disease causing small, dark spots with yellowish halos on leaves.  ', 'Rotate crops every 2-3 years.\r\nKeep weeds and old tomato/pepper plants under control.\r\nRemove and dispose of infected leaves early on.', 'Use disease-free seeds and transplants.\r\nTreat seeds by soaking in a 10% bleach solution.\r\nHot water treatment can reduce bacteria in seeds.\r\nRotate crops and follow good cultural practices.\r\nAvoid watering overhead.\r\nHandle plants when dry to prevent spread.', 'Copper products or copper with mancozeb can control bacterial spot.\r\nFor greenhouse transplants, use Streptomycin to control bacterial spot.\r\n\r\n\"  Apply a copper-based bactericide *or* a combination bactericide containing copper and mancozeb.  *Note:* Some strains of bacterial spot have shown resistance to copper.\r\n Remove heavily infected leaves and debris.\r\n Improve air circulation by pruning and spacing plants.\r\n\"\r\n', '\" 1. *Choose Bactericide:* Look for a bactericide labeled for tomatoes and specifically for bacterial spot.  *Check for copper resistance warnings on the label.*\r\n\r\n2. *Mix Properly:* Always follow the instructions for dilution and mixing provided on the specific product label.\r\n\r\n3. *Apply Thoroughly:* Apply the bactericide solution, making sure to thoroughly coat the undersides of leaves and all plant parts.\r\n\r\n4. *Repeat Regularly:* Depending on the product and disease severity, reapply every 7-14 days, following the instructions on the label.\r\n\r\n5. *Stay Safe:* Wear protective clothing, gloves, and eye protection when handling and applying bactericides.\r\n\r\n6. *Dispose Properly:*  Follow local regulations for disposal of unused bactericide and empty containers.\r\n\r\n* Following these steps will help manage bacterial spot in your tomatoes while minimizing risks.																																																													\r\n', 1),
(2, 'A fungal disease causing brown spots with concentric rings on lower leaves.', 'Remove infected plant residues from fields.\r\nRotate crops to reduce early blight spores.', 'Change farming practices to deter disease and pests.\r\nRotate different crops in the same area each season.\r\nUse mulch to prevent soil splashing onto tomato leaves.\r\nPlant resistant tomato varieties.\r\nStart with disease-free seeds.', 'Consider using biocontrol agents for eco-friendly management.\r\nApply the fungicide mancozeb to control early blight and boost yields.\r\nSome plant extracts have antimicrobial properties against early blight\r\n\r\n\"* Apply fungicide containing copper or sulfur *or* a biological fungicide containing Bacillus subtilis.\r\n* Remove heavily infected leaves and debris.\r\n* Improve air circulation by pruning and spacing plants.\r\n\"\r\n', '\" 1. *Choose Fungicide:* Select a fungicide labeled for tomatoes and early blight. Look for options containing copper, sulfur, or Bacillus subtilis (a biological control).\r\n\r\n2. *Mix Properly:* Always follow the specific instructions for dilution and mixing provided on the product label.\r\n\r\n3. *Apply Thoroughly:* Apply the fungicide solution, making sure to saturate the undersides of leaves and all plant parts.\r\n\r\n4. *Repeat Regularly:* Reapply every 7-14 days, depending on the product and weather conditions, following the label instructions.\r\n\r\n5. *Stay Safe:* Wear protective clothing, gloves, and eye protection when handling and applying fungicides.\r\n\r\n6. *Dispose Properly:* Follow local regulations for disposal of unused fungicide and empty containers.\r\n\r\n* Following these steps will help manage early blight in your tomatoes and minimize the risk of further spread.\"				\r\n', 2),
(3, 'Destructive fungal disease affecting all parts of tomato plants.', 'Avoid planting tomatoes near or in areas previously used for potatoes.', 'Use bottom-watering with drip irrigation.\r\nSpace plants widely for better air circulation.\r\nAvoid handling plants when foliage is wet.\r\nMulch with plastic or organic material to reduce disease.\r\nApply protectant fungicides like chlorothalonil or mancozeb.\r\nOrganic gardeners can use fixed copper products like Kocide.\r\nBegin weekly fungicide sprays after transplanting in favorable conditions.', 'Continue weekly fungicide sprays to prevent further infection.\r\nRemove severely infected plants and dispose of them properly.\r\nDo not compost diseased plants.\r\nAvoid harvesting tomatoes with visible disease lesions.\r\n\r\n\"* Apply a fungicide containing copper *or* a broad-spectrum fungicide labeled for oomycete diseases (like late blight). *Note:* Late blight can develop resistance to fungicides, so rotating modes of action is important.\r\n* Remove and destroy all infected plant parts immediately.\r\n* Avoid overhead watering and improve air circulation by pruning and spacing plants.\"\r\n', '\" 1. *Choose Fungicide:* Select a fungicide labeled for tomatoes and specifically for late blight. Look for copper-based fungicides or broad-spectrum fungicides effective against oomycete diseases. *Consider rotating fungicide types to prevent resistance.*\r\n\r\n2. *Mix Properly:* Always follow the specific instructions for dilution and mixing provided on the product label.\r\n\r\n3. *Apply Thoroughly:* Apply the fungicide solution thoroughly, making sure to saturate the undersides of leaves, stems, and fruits.\r\n\r\n4. *Repeat Regularly:* Depending on the weather conditions and severity of the outbreak, reapply every 7-10 days, following the label instructions.\r\n\r\n5. *Stay Safe:* Wear protective clothing, gloves, and eye protection when handling and applying fungicides.\r\n\r\n6. *Dispose Properly:* Follow local regulations for disposal of unused fungicide and empty containers.\"				\r\n', 3),
(4, 'Disease causing yellowish spots on older leaves, leading to overall yellowing.', 'Remove and burn all plant debris after harvest.', 'Optimal row and plant spacing for better air circulation.\r\nAvoid excessive nitrogen fertilization, as it promotes foliage diseases.\r\nMaintain humidity below 85%, especially in greenhouses.\r\nEnsure good air circulation in greenhouses.\r\nConsider early planting and seed treatment with hot water.\r\nUse resistant cultivars when possible.', 'Remove infected plants immediately and sanitize the greenhouse.\r\nSpray fungicides like chlorothalonil, maneb, mancozeb, or copper upon symptom appearance.\r\n\"* Apply a fungicide containing copper or sulfur *or* a biological fungicide containing Bacillus subtilis.\r\n* Improve air circulation by pruning and spacing plants.\r\n* Remove heavily infected leaves, if possible.\"\r\n', '\" 1. *Choose Fungicide:* Select a fungicide labeled for tomatoes and specifically for leaf mold. Look for options containing copper, sulfur, or Bacillus subtilis (a biological control).\r\n\r\n2. *Mix Properly:* Always follow the specific instructions for dilution and mixing provided on the product label.\r\n\r\n3. *Apply Thoroughly:* Apply the fungicide solution, making sure to saturate both the upper and lower surfaces of leaves, focusing on areas with visible signs of infection.\r\n\r\n4. *Repeat Regularly:* Depending on the product and weather conditions, reapply every 7-14 days, following the label instructions.\r\n\r\n5. *Stay Safe:* Wear protective clothing, gloves, and eye protection when handling and applying fungicides.\r\n\r\n6. *Dispose Properly:* Follow local regulations for disposal of unused fungicide and empty containers.\"			\r\n', 4),
(5, 'Fungal disease causing small, dark-centered circular spots on leaves.\r\n', 'Remove and burn all plant debris after harvest.\r\nControl weeds and practice crop rotation.', 'Optimal row and plant spacing for improved air circulation.\r\nAvoid excessive nitrogen fertilization to prevent disease development.\r\nConsider using resistant cultivars.', 'Remove diseased leaves promptly.\r\nEnhance air circulation around plants.\r\nApply fungicidal sprays as needed.\r\n\r\n\"* Apply a fungicide containing copper or sulfur.\r\n* Remove heavily infected leaves.\r\n* Improve air circulation by pruning and spacing plants.\"\r\n', '\" 1. *Choose Fungicide:* Select a fungicide labeled for tomatoes and specifically for Septoria leaf spot. Look for options containing copper or sulfur.\r\n\r\n2. *Mix Properly:* Always follow the specific instructions for dilution and mixing provided on the product label.\r\n\r\n3. *Apply Thoroughly:* Apply the fungicide solution, making sure to saturate the undersides of leaves and all plant parts, focusing on areas with visible signs of infection.\r\n\r\n4. *Repeat Regularly:* Depending on the severity of the outbreak and weather conditions, reapply every 7-14 days, following the label instructions.\r\n\r\n5. *Stay Safe:* Wear protective clothing, gloves, and eye protection when handling and applying fungicides.\r\n\r\n6. *Dispose Properly:* Follow local regulations for disposal of unused fungicide and empty containers.\"				\r\n', 5),
(6, 'Tiny pests that feed on plant sap, causing yellow stippling on leaves.', 'Management Actions:\r\nRotate miticides to prevent chemical resistance.\r\nManage weeds, especially blackberry nightshade and glossy nightshade.\r\nTreat, remove, or quarantine infested plants to prevent spread.', 'Maintain adequate row and plant spacing to promote air circulation, reducing humidity.\r\nAvoid excessive nitrogen fertilization, as it can exacerbate foliage disease development.\r\nUse resistant cultivars when available.\r\nImplement proper weed control measures to reduce potential disease hosts.\r\nPractice early planting to mitigate disease severity.\r\nConsider seed treatment with hot water for additional protection against disease.', 'Implement biosecurity best practices to prevent pest entry, establishment, and spread.\r\nPractice good farm hygiene (\"Come Clean, Go Clean\").\r\nEnsure staff and visitors follow hygiene protocols.\r\nSource propagation material from reputable suppliers with high health status.\r\nRegularly monitor crops for signs of infestation.\r\nMaintain thorough records of pest management activities.\r\n\r\n\"* Using insecticidal oil (neem oil, horticultural oil, or dormant oil).\r\n* Using a miticide.\r\n* Spraying plants with water to wash away spider mites.\r\n* Adding insecticidal soap or oil to the spray.\r\n* Physically wiping them away with your fingers or soft cloth.\"\r\n', '\" 1. *Monitor for Signs:* Regularly inspect the undersides of leaves for webbing, tiny moving specks (the mites), and stippling (yellowish or bronzed flecks) on leaf surfaces.\r\n\r\n2. *Choose Management Option:* Select the most appropriate method based on the severity of the infestation and your preference for organic or conventional control.\r\n\r\n3. *Apply Thoroughly:* If using insecticidal soap, oil, or a strong water spray, ensure thorough coverage of the undersides of leaves, where mites reside and feed.\r\n\r\n4. *Repeat as Needed:* Depending on the chosen method and infestation level, repeat treatments every 3-7 days for several weeks until mites are under control.\r\n\r\n5. *Monitor and Adjust:* Continuously monitor your plants and adjust your management strategy as needed.\"				\r\n', 9),
(7, 'Target spot, a fungal disease, manifests as concentric rings on tomato leaves, resembling a target pattern.', 'Collect and burn crop residues post-harvest to reduce overwintering potential.\r\nPractice crop rotation, allowing at least a 3-year gap before replanting tomatoes in the same area.', 'Prune lower branches to improve airflow around the base of plants.\r\nPromptly remove and burn lower leaves upon disease detection, especially post lower fruit truss harvest.\r\nMaintain weed-free plots to eliminate potential fungal hosts.\r\nAvoid overhead irrigation to mitigate spore production and infection risks.', 'Fungicides are necessary in warm, wet conditions for effective control.\r\nRecommended fungicides include chlorothalonil, copper oxychloride, or mancozeb.\r\nInitiate treatment upon spotting initial signs, continuing at 10-14-day intervals until 3-4 weeks before the final harvest.\r\nEnsure thorough spraying of both leaf surfaces for optimal efficacy.\r\n\r\n\"* Apply a fungicide containing chlorothalonil, copper oxychloride, or mancozeb. *Note:* Preventive application is most effective.\r\n* Remove and destroy infected leaves and debris.\r\n* Improve air circulation by pruning and spacing plants.\r\n* Avoid overhead watering.\"\r\n', '\" 1. *Choose Fungicide:* Select a fungicide labeled for tomatoes and specifically for target spot. Look for products containing chlorothalonil, copper oxychloride, or mancozeb.\r\n\r\n2. *Mix Properly:* Always follow the specific instructions for dilution and mixing provided on the product label.\r\n\r\n3. *Apply Thoroughly:* Apply the fungicide solution thoroughly, ensuring good coverage of the undersides of leaves, stems, and fruits, especially during periods of warm, wet weather favorable for disease development.\r\n\r\n4. *Repeat Regularly:* Begin preventative applications before symptoms appear, typically at the start of flowering or fruit set. Continue at 10-14 day intervals until 3-4 weeks before your last expected harvest, following the label instructions.\r\n\r\n5. *Stay Safe:* Wear protective clothing, gloves, and eye protection when handling and applying fungicides.\r\n\r\n6. *Dispose Properly:* Follow local regulations for disposal of unused fungicide and empty containers.\"				\r\n', 8),
(8, 'This viral infection induces leaf curling and yellowing in tomato plants.', 'Cultural Practices:\r\nBegin the season with virus-free transplants.\r\nUtilize certified disease-free seeds or treat seeds accordingly.\r\nEmploy methods like soaking seeds in a trisodium phosphate solution or heat treatment.\r\nPurchase transplants from reputable sources with strict sanitation procedures.\r\nInspect transplants for symptoms before purchase.\r\nAvoid greenhouse environments with potential virus reservoirs like perennial ornamentals.\r\nRotation:\r\nRefrain from planting in fields containing tomato root debris to prevent long-term virus survival.\r\nSanitation:\r\nWash hands before and during plant handling to minimize transmission.\r\nRegularly disinfect tools, preferably between each plant, using effective solutions.\r\nAvoid using tobacco products around tomato plants and practice proper hand hygiene.\r\nEmploy stringent sanitation procedures upon virus confirmation, including burning infected plants and disinfecting tools.\r\nKeep separate tools for diseased and healthy plant areas to prevent cross-contamination.\r\nEnd-of-Season Measures:\r\nDispose of all plants from diseased areas, including seemingly healthy ones, through burning or burying.\r\nDisinfect equipment between growing seasons using appropriate methods.\r\nPesticide Use:\r\nChemical options are currently ineffective against these viruses.\r\nManage aphids and thrips during transplant production to mitigate virus spread.', '(Not applicable for viral diseases as there are no direct protective measures.)', '(Not applicable for viral diseases as there are no direct treatment options.)\r\n\r\n\"* Spraying tomato plants with garlic\r\n* Spraying tomato plants with neem oil\r\n* Spraying tomato plants with chili pepper extract\r\n\r\n', '\" 1. Remove and destroy infected plants:* This helps prevent further spread by whiteflies, the insect vector that transmits TYLCV.\r\n2. Control whiteflies:* Use insecticidal soaps, oils, or other whitefly-specific insecticides to reduce populations and prevent them from transmitting the virus.\r\n3. Use insect netting:* Covering tomato plants with fine mesh netting can physically exclude whiteflies and prevent them from feeding and transmitting the virus.\r\n4. Plant resistant varieties:* Some tomato varieties have shown tolerance or resistance to TYLCV. Look for these varieties when planting.\r\n5. Sanitize tools and equipment:* Disinfect tools and equipment between handling healthy and infected plants to avoid spreading the virus.\"				\r\n', 7),
(9, 'Characterized by a mottled appearance on leaves, displaying patches of yellow and green', 'Cultural Practices:\r\nBegin the season with virus-free transplants.\r\nUtilize certified disease-free seeds or treat seeds accordingly.\r\nEmploy methods like soaking seeds in a trisodium phosphate solution or heat treatment.\r\nPurchase transplants from reputable sources with strict sanitation procedures.\r\nInspect transplants for symptoms before purchase.\r\nAvoid greenhouse environments with potential virus reservoirs like perennial ornamentals.\r\nRotation:\r\nRefrain from planting in fields containing tomato root debris to prevent long-term virus survival.\r\nSanitation:\r\nWash hands before and during plant handling to minimize transmission.\r\nRegularly disinfect tools, preferably between each plant, using effective solutions.\r\nAvoid using tobacco products around tomato plants and practice proper hand hygiene.\r\nEmploy stringent sanitation procedures upon virus confirmation, including burning infected plants and disinfecting tools.\r\nKeep separate tools for diseased and healthy plant areas to prevent cross-contamination.\r\nEnd-of-Season Measures:\r\nDispose of all plants from diseased areas, including seemingly healthy ones, through burning or burying.\r\nDisinfect equipment between growing seasons using appropriate methods.\r\nPesticide Use:\r\nChemical options are currently ineffective against these viruses.\r\nManage aphids and thrips during transplant production to mitigate virus spread.', '(Not applicable for viral diseases as there are no direct protective measures.)', '(Not applicable for viral diseases as there are no direct treatment options.)\r\n\r\n\"* Practice good sanitation practices to prevent spread of infection.\r\n* Remove and destroy infected plants.\r\n* Dip hands in milk to inactivate the virus\"\r\n', '\" 1. Remove and destroy infected plants. Pull plants with mosaic symptoms immediately. Remove the debris from the garden area and bury them if possible.\r\n\r\n2. Keep your garden weed-free. Some weeds may be harboring the virus. These represent sources of inoculum.\r\n\r\n3. Always wash your hands thoroughly and disinfect tools. Before handling plants, wash them with soap and water, especially if you\'re a smoker.\r\n\r\n4. Plant resistant varieties of tomato. Suggested varieties include: ‘Big Pick’, ‘Celebrity’, ‘President’, and ‘Park\'s Extra Early Hybrid’. Other resistant varieties will be labeled TMV resistant.\"				\r\n', 6);

-- --------------------------------------------------------

--
-- Table structure for table `treatment_tasks`
--

CREATE TABLE `treatment_tasks` (
  `id` int(11) NOT NULL,
  `one-time` text NOT NULL,
  `immediate` text NOT NULL,
  `frequency-based` text NOT NULL,
  `disease_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `treatment_tasks`
--

INSERT INTO `treatment_tasks` (`id`, `one-time`, `immediate`, `frequency-based`, `disease_id`) VALUES
(1, '\r\n1-Remove heavily infected leaves and debris:\r\n - Identify and prune out the infected leaves.\r\n - Properly dispose of the debris to prevent the spread of the bacteria.', '1- Improve air circulation:\r\n - Prune plants to enhance airflow.\r\n - Ensure adequate spacing between plants \r\n   to reduce humidity and leaf wetness, \r\n   which can promote bacterial growth.', ' 1- Apply a copper-based bactericide or a combination bactericide containing copper and mancozeb:\r\n\r\n - Regularly apply as recommended by the \r\n  product instructions, keeping in mind \r\n  that some strains of bacterial spot \r\n  may be resistant to copper.\r\n - Monitor plants regularly for signs of \r\n  bacterial spot and reapply treatments \r\n  as necessary.\r\n\r\n 2- For greenhouse transplants, use Streptomycin to control bacterial spot:\r\n\r\n - Follow a regular treatment schedule \r\n  as prescribed for Streptomycin use.\r\n - Observe plants closely and reapply \r\n  treatments as indicated for ongoing \r\n  control of bacterial spot.', 1),
(2, ' 1- Remove heavily infected leaves and \r\n  debris:\r\n - Identify and prune out the infected \r\n  leaves.\r\n - Properly dispose of the debris to \r\n  prevent the spread of the disease.', ' 1- Improve air circulation: \r\n - Prune plants to enhance airflow.\r\n - Ensure adequate spacing between plants \r\n to reduce humidity and leaf wetness, \r\n which can promote disease growth.', ' 1- Apply fungicide containing copper or \r\n  sulfur or a biological fungicide \r\n  containing Bacillus subtilis:\r\n - Regularly apply as recommended by the \r\n  product instructions to control early \r\n  blight.\r\n - Monitor plants regularly for signs of \r\n  early blight and reapply treatments as \r\n  necessary.\r\n\r\n 2- Consider using biocontrol agents for \r\n  eco-friendly management:\r\n - Incorporate biocontrol agents into \r\n  the regular plant care routine.\r\n - Follow the application guidelines \r\n  provided for the specific biocontrol \r\n  agents.\r\n 3- Apply the fungicide mancozeb to \r\n control early blight and boost yields:\r\n - Follow a regular treatment schedule \r\n  as prescribed for mancozeb use.\r\n - Observe plants closely and reapply \r\n  treatments as indicated for ongoing \r\n  control of early blight.\r\n\r\n 4- Utilize plant extracts with \r\n  antimicrobial properties against early \r\n  blight:\r\n - Incorporate plant extracts into the \r\n  regular disease management routine.\r\n - Follow the recommended application \r\n  frequency and guidelines for the \r\n  specific plant extracts.', 2),
(3, ' 1- Remove severely infected plants and \r\n  dispose of them properly:\r\n - Identify and remove plants that are \r\n   severely infected.\r\n - Dispose of these plants in a way that \r\n   prevents the spread of disease (do not \r\n   compost).\r\n\r\n 2- Avoid harvesting tomatoes with visible \r\n  disease lesions:\r\n - Inspect tomatoes carefully before \r\n  harvesting and avoid picking those with \r\n  visible lesions.', ' 1- Remove and destroy all infected plant \r\n  parts immediately:\r\n - As soon as infected parts are \r\n  identified, remove and destroy them to \r\n  prevent the spread of the disease.\r\n\r\n 2- Avoid overhead watering and improve \r\n  air circulation by pruning and spacing \r\n  plants:\r\n - Adjust watering methods to avoid \r\n  overhead watering.\r\n - Prune plants and ensure they are spaced \r\n  adequately to improve air circulation.', ' 1- Continue weekly fungicide sprays to \r\n   prevent further infection:\r\n - Apply fungicides on a weekly schedule \r\n  to maintain control over the \r\n  infection.\r\n\r\n 2- Apply a fungicide containing copper \r\n   or a broad-spectrum fungicide labeled \r\n   for oomycete diseases (like late \r\n    blight):\r\n - Regularly apply these fungicides as \r\n   recommended by the product \r\n    instructions.\r\n - Rotate fungicides to prevent the \r\n   development of resistance.\r\n\r\n 3- Monitor for signs of late blight and \r\n   adjust treatment plans accordingly:\r\n - Regularly check plants for symptoms \r\n   of late blight and adjust fungicide \r\n  applications to rotate modes of action \r\n   and maintain effectiveness.', 3),
(4, ' 1- Sanitize the greenhouse:\r\n - Thoroughly clean and disinfect the \r\n  greenhouse after removing infected \r\n  plants to prevent the spread of disease.', ' 1- Remove infected plants immediately:\r\n - Identify and remove plants that show \r\n   signs of infection promptly.\r\n\r\n 2- Remove heavily infected leaves, if \r\n  possible:\r\n - Prune out leaves that are heavily \r\n   infected to minimize disease spread.', ' 1- Spray fungicides like \r\n   chlorothalonil, maneb, mancozeb, or \r\n   copper upon symptom appearance:\r\n - Apply these fungicides when symptoms \r\n   of disease are first noticed and \r\n   continue as per product guidelines.\r\n\r\n 2- Apply a fungicide containing copper \r\n   or sulfur or a biological fungicide \r\n   containing Bacillus subtilis:\r\n - Regularly apply these fungicides as \r\n  recommended by the product \r\n  instructions to maintain disease \r\n  control.\r\n\r\n 3-Improve air circulation by pruning \r\n  and spacing plants:\r\n - Continuously monitor plant growth and \r\n   prune or adjust spacing to ensure \r\n   good air circulation, which helps \r\n   reduce disease incidence.', 4),
(5, ' 1- Enhance air circulation around plants:\r\n - Adjust the layout and spacing of plants \r\n   to ensure good airflow.\r\n - Prune plants to open up the canopy and \r\n   improve ventilation.', ' 1-Remove diseased leaves promptly:\r\n - Identify and promptly remove leaves \r\n   showing signs of disease.\r\n\r\n 2- Remove heavily infected leaves:\r\n - Identify and remove leaves that are \r\n   heavily infected to prevent further \r\n   spread of disease.', ' 1- Apply fungicidal sprays as needed:\r\n - Monitor plants regularly and apply \r\n   fungicidal sprays when symptoms of \r\n   disease appear or as recommended by the \r\n   product instructions.\r\n\r\n 2- Apply a fungicide containing copper or \r\n   sulfur:\r\n - Regularly apply these fungicides as \r\n   part of a preventive or curative \r\n   treatment plan, following product \r\n   guidelines.', 5),
(6, ' 1- Implement biosecurity best practices \r\n   to prevent pest entry, establishment, \r\n   and spread:\r\n - Set up protocols and infrastructure to \r\n   minimize pest entry.\r\n - Establish quarantine areas for new \r\n   plants.\r\n\r\n 2- Source propagation material from \r\n  reputable suppliers with high health \r\n  status:\r\n - Identify and establish relationships \r\n   with trusted suppliers.', ' 1- Practice good farm hygiene (\"Come \r\n    Clean, Go Clean\"):\r\n - Ensure all farm personnel clean \r\n   tools, equipment, and themselves \r\n   before and after entering different \r\n   areas of the farm.\r\n\r\n 2- Ensure staff and visitors follow \r\n    hygiene protocols:\r\n - Brief staff and visitors on hygiene \r\n    protocols and monitor compliance.\r\n\r\n 3- Spray plants with water to wash away \r\n    spider mites:\r\n - Use a water spray to dislodge spider \r\n   mites from plants.\r\n\r\n 4- Physically wipe away pests with your \r\n   fingers or a soft cloth:\r\n - Manually remove visible pests from \r\n   plants.', ' 1- Regularly monitor crops for signs of \r\n   infestation:\r\n - Conduct regular inspections of crops \r\n   to identify and address pest issues \r\n    early.\r\n\r\n 2- Maintain thorough records of pest \r\n    management activities:\r\n - Keep detailed records of pest \r\n   sightings, treatments applied, and \r\n    their outcomes.\r\n\r\n 3- Using insecticidal oil (neem oil, \r\n   horticultural oil, or dormant oil):\r\n - Apply insecticidal oils as per the \r\n   recommended schedule to control \r\n   pests.\r\n\r\n 4- Using a miticide:\r\n - Apply miticides regularly according \r\n   to the product instructions to \r\n   control mite populations.\r\n\r\n 5- Adding insecticidal soap or oil to \r\n    the spray:\r\n - Incorporate insecticidal soap or oil \r\n   into regular spray routines to \r\n   enhance pest control.', 9),
(7, ' 1- Improve air circulation by pruning and \r\n    spacing plants:\r\n - Prune plants to enhance airflow.\r\n - Ensure adequate spacing between plants \r\n   to reduce humidity and leaf wetness, \r\n   which can promote fungal growth.', ' 1- Remove and destroy infected leaves and \r\n    debris:\r\n - Identify and promptly remove infected \r\n   leaves.\r\n - Properly dispose of debris to prevent \r\n   the spread of the fungus.\r\n\r\n 2- Avoid overhead watering:\r\n - Adjust watering methods to avoid \r\n   wetting the foliage, which can \r\n   encourage fungal growth.', ' 1- Initiate treatment upon spotting \r\n    initial signs, continuing at 10-14- \r\n    day intervals until 3-4 weeks before \r\n    the final harvest:\r\n - Start fungicide treatments as soon as \r\n   symptoms are observed.\r\n - Continue treatments at regular \r\n   intervals to maintain control.\r\n\r\n 2- Apply a fungicide containing \r\n   chlorothalonil, copper oxychloride, \r\n   or mancozeb:\r\n - Regularly apply these fungicides as \r\n   recommended, focusing on preventive \r\n   applications in warm, wet conditions.\r\n - Ensure thorough spraying of both leaf \r\n   surfaces for optimal efficacy.\r\n\r\n 3- Monitor weather conditions and \r\n    adjust fungicide application \r\n    frequency as needed:\r\n - In warm, wet conditions, be vigilant \r\n   and adjust the frequency of fungicide \r\n   applications to ensure effective \r\n   control.', 8),
(8, '(None for viral diseases as there are no direct treatment options.)', '(None, as the provided tasks are ongoing treatments rather than immediate single actions.)', ' 1- Spraying tomato plants with garlic:\r\n - Prepare and apply garlic spray \r\n   regularly, according to the \r\n   recommended schedule, to help deter \r\n   pests and potentially mitigate viral \r\n   transmission vectors.\r\n\r\n 2- Spraying tomato plants with neem \r\n    oil:\r\n - Apply neem oil spray at regular \r\n   intervals to control pests that can \r\n   act as vectors for viral diseases.\r\n\r\n 3- Spraying tomato plants with chili \r\n    pepper extract:\r\n - Regularly spray chili pepper extract \r\n   on tomato plants as a deterrent for \r\n   pests and potential disease vectors.\r\n\r\n\r\n\r\n\r\n', 7),
(9, '(None, as there are no direct treatment options for viral diseases.)', ' 1- Remove and destroy infected plants:\r\n - Identify and promptly remove plants \r\n   that show signs of viral infection.\r\n - Properly dispose of the infected plants \r\n   to prevent the spread of the virus.', ' 1- Practice good sanitation practices to \r\n    prevent the spread of infection:\r\n - Regularly clean and disinfect tools, \r\n   equipment, and surfaces that come into \r\n   contact with plants.\r\n - Ensure all staff and visitors follow \r\n   proper hygiene protocols to minimize \r\n   the risk of virus transmission.\r\n\r\n 2- Dip hands in milk to inactivate the \r\n    virus:\r\n - Before and after handling plants, dip \r\n   hands in milk regularly to inactivate \r\n   any viral particles and prevent their \r\n   spread.', 6);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `image`) VALUES
(15, 'fawzy19', 'fawzy19@gmail.com', '23d23af5339b2d5fbfc9d964aeced00bf729584c', 'person.jpg'),
(16, 'salma19', 'salma19@gmail.com', 'd37f6349dfcd49a253b792c57b8d180996e32b22', 'person.jpg'),
(17, 'sara11', 'sara@gmail.com', 'b216d3a047c056c83bdc990817e94805c5a8cd3a', 'person.jpg'),
(18, 'sara', 'sara@gmail.com', 'b216d3a047c056c83bdc990817e94805c5a8cd3a', 'person.jpg'),
(19, 'ahmed', 'ahmed@gmail.com', '97201ccb7ba72fa02146af66dd07fa9f5fa4d087', 'WhatsApp_Image_2024-05-21_at_12.18.21_AM_3.jpeg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `additional_tasks`
--
ALTER TABLE `additional_tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `disease_id` (`disease_id`);

--
-- Indexes for table `journals`
--
ALTER TABLE `journals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `treatment_id` (`treatment_id`);

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
-- Indexes for table `treatment_tasks`
--
ALTER TABLE `treatment_tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `disease_id` (`disease_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `additional_tasks`
--
ALTER TABLE `additional_tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `journals`
--
ALTER TABLE `journals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
-- AUTO_INCREMENT for table `treatment_tasks`
--
ALTER TABLE `treatment_tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `additional_tasks`
--
ALTER TABLE `additional_tasks`
  ADD CONSTRAINT `additional_tasks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `additional_tasks_ibfk_2` FOREIGN KEY (`disease_id`) REFERENCES `tomato_disease` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `journals`
--
ALTER TABLE `journals`
  ADD CONSTRAINT `journals_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `journals_ibfk_2` FOREIGN KEY (`treatment_id`) REFERENCES `treatment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
-- Constraints for table `treatment_tasks`
--
ALTER TABLE `treatment_tasks`
  ADD CONSTRAINT `treatment_tasks_ibfk_1` FOREIGN KEY (`disease_id`) REFERENCES `tomato_disease` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
