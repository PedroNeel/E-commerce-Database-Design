CREATE TABLE `brand` (
  `brand_id` int PRIMARY KEY AUTO_INCREMENT,
  `brand_name` varchar(100) UNIQUE NOT NULL,
  `brand_description` text,
  `brand_logo_url` varchar(255),
  `founded_year` year,
  `headquarters` varchar(100),
  `is_active` boolean DEFAULT true,
  `created_at` timestamp DEFAULT (now()),
  `updated_at` timestamp DEFAULT (now())
);

CREATE TABLE `product_category` (
  `category_id` int PRIMARY KEY AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  `parent_category_id` int,
  `category_description` text,
  `category_image_url` varchar(255),
  `is_active` boolean DEFAULT true,
  `created_at` timestamp DEFAULT (now()),
  `updated_at` timestamp DEFAULT (now())
);

CREATE TABLE `product` (
  `product_id` int PRIMARY KEY AUTO_INCREMENT,
  `product_name` varchar(255) NOT NULL,
  `product_description` text,
  `brand_id` int NOT NULL,
  `category_id` int NOT NULL,
  `base_price` decimal(10,2) NOT NULL,
  `tax_rate` decimal(5,2) DEFAULT 0,
  `is_digital` boolean DEFAULT false,
  `is_active` boolean DEFAULT true,
  `avg_rating` decimal(3,2) DEFAULT 0,
  `total_reviews` int DEFAULT 0,
  `created_at` timestamp DEFAULT (now()),
  `updated_at` timestamp DEFAULT (now())
);

CREATE TABLE `size_category` (
  `size_category_id` int PRIMARY KEY AUTO_INCREMENT,
  `category_name` varchar(50) UNIQUE NOT NULL,
  `description` varchar(255)
);

CREATE TABLE `size_option` (
  `size_id` int PRIMARY KEY AUTO_INCREMENT,
  `size_category_id` int NOT NULL,
  `size_value` varchar(20) NOT NULL,
  `size_description` varchar(100),
  `display_order` int DEFAULT 0
);

CREATE TABLE `color` (
  `color_id` int PRIMARY KEY AUTO_INCREMENT,
  `color_name` varchar(50) UNIQUE NOT NULL,
  `hex_code` varchar(7) UNIQUE NOT NULL,
  `is_active` boolean DEFAULT true
);

CREATE TABLE `product_variation` (
  `variation_id` int PRIMARY KEY AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `variation_name` varchar(100) NOT NULL,
  `variation_type` enum(size,color,style,material,other) NOT NULL,
  `is_required` boolean DEFAULT true,
  `display_order` int DEFAULT 0
);

CREATE TABLE `product_variation_option` (
  `option_id` int PRIMARY KEY AUTO_INCREMENT,
  `variation_id` int NOT NULL,
  `option_value` varchar(100) NOT NULL,
  `linked_size_id` int,
  `linked_color_id` int,
  `display_order` int DEFAULT 0
);

CREATE TABLE `product_item` (
  `item_id` int PRIMARY KEY AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `sku` varchar(50) UNIQUE NOT NULL,
  `barcode` varchar(50) UNIQUE,
  `inventory_count` int NOT NULL DEFAULT 0,
  `price_adjustment` decimal(10,2) DEFAULT 0,
  `weight` decimal(8,2) COMMENT 'in grams',
  `length` decimal(8,2) COMMENT 'in cm',
  `width` decimal(8,2) COMMENT 'in cm',
  `height` decimal(8,2) COMMENT 'in cm',
  `is_active` boolean DEFAULT true,
  `created_at` timestamp DEFAULT (now()),
  `updated_at` timestamp DEFAULT (now())
);

CREATE TABLE `product_item_variation` (
  `item_variation_id` int PRIMARY KEY AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `variation_id` int NOT NULL,
  `option_id` int NOT NULL
);

CREATE TABLE `product_image` (
  `image_id` int PRIMARY KEY AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `alt_text` varchar(255),
  `display_order` int DEFAULT 0,
  `is_primary` boolean DEFAULT false,
  `color_id` int
);

CREATE TABLE `product_video` (
  `video_id` int PRIMARY KEY AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `video_url` varchar(255) NOT NULL,
  `thumbnail_url` varchar(255),
  `display_order` int DEFAULT 0,
  `is_primary` boolean DEFAULT false
);

CREATE TABLE `attribute_category` (
  `attribute_category_id` int PRIMARY KEY AUTO_INCREMENT,
  `category_name` varchar(100) UNIQUE NOT NULL,
  `description` text,
  `display_order` int DEFAULT 0
);

CREATE TABLE `attribute_type` (
  `attribute_type_id` int PRIMARY KEY AUTO_INCREMENT,
  `type_name` varchar(50) UNIQUE NOT NULL,
  `input_type` enum(text,number,boolean,select,multiselect,date) NOT NULL,
  `validation_regex` varchar(255)
);

CREATE TABLE `product_attribute` (
  `attribute_id` int PRIMARY KEY AUTO_INCREMENT,
  `attribute_name` varchar(100) UNIQUE NOT NULL,
  `attribute_category_id` int,
  `attribute_type_id` int NOT NULL,
  `is_filterable` boolean DEFAULT false,
  `is_required` boolean DEFAULT false,
  `display_order` int DEFAULT 0
);

CREATE TABLE `product_attribute_value` (
  `value_id` int PRIMARY KEY AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `attribute_id` int NOT NULL,
  `text_value` text,
  `number_value` decimal(15,5),
  `boolean_value` boolean,
  `date_value` date
);

CREATE TABLE `attribute_option` (
  `option_id` int PRIMARY KEY AUTO_INCREMENT,
  `attribute_id` int NOT NULL,
  `option_value` varchar(255) NOT NULL,
  `display_order` int DEFAULT 0
);

CREATE UNIQUE INDEX `product_category_index_0` ON `product_category` (`category_name`, `parent_category_id`);

CREATE INDEX `product_index_1` ON `product` (`product_name`, `product_description`) USING FULLTEXT;

CREATE UNIQUE INDEX `size_option_index_2` ON `size_option` (`size_category_id`, `size_value`);

CREATE UNIQUE INDEX `product_variation_option_index_3` ON `product_variation_option` (`variation_id`, `option_value`);

CREATE UNIQUE INDEX `product_item_variation_index_4` ON `product_item_variation` (`item_id`, `variation_id`);

CREATE UNIQUE INDEX `product_attribute_value_index_5` ON `product_attribute_value` (`product_id`, `attribute_id`);

CREATE UNIQUE INDEX `attribute_option_index_6` ON `attribute_option` (`attribute_id`, `option_value`);

ALTER TABLE `product_category` ADD FOREIGN KEY (`parent_category_id`) REFERENCES `product_category` (`category_id`);

ALTER TABLE `product` ADD FOREIGN KEY (`brand_id`) REFERENCES `brand` (`brand_id`);

ALTER TABLE `product` ADD FOREIGN KEY (`category_id`) REFERENCES `product_category` (`category_id`);

ALTER TABLE `size_option` ADD FOREIGN KEY (`size_category_id`) REFERENCES `size_category` (`size_category_id`);

ALTER TABLE `product_variation` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `product_variation_option` ADD FOREIGN KEY (`variation_id`) REFERENCES `product_variation` (`variation_id`);

ALTER TABLE `product_variation_option` ADD FOREIGN KEY (`linked_size_id`) REFERENCES `size_option` (`size_id`);

ALTER TABLE `product_variation_option` ADD FOREIGN KEY (`linked_color_id`) REFERENCES `color` (`color_id`);

ALTER TABLE `product_item` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `product_item_variation` ADD FOREIGN KEY (`item_id`) REFERENCES `product_item` (`item_id`);

ALTER TABLE `product_item_variation` ADD FOREIGN KEY (`variation_id`) REFERENCES `product_variation` (`variation_id`);

ALTER TABLE `product_item_variation` ADD FOREIGN KEY (`option_id`) REFERENCES `product_variation_option` (`option_id`);

ALTER TABLE `product_image` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `product_image` ADD FOREIGN KEY (`color_id`) REFERENCES `color` (`color_id`);

ALTER TABLE `product_video` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `product_attribute` ADD FOREIGN KEY (`attribute_category_id`) REFERENCES `attribute_category` (`attribute_category_id`);

ALTER TABLE `product_attribute` ADD FOREIGN KEY (`attribute_type_id`) REFERENCES `attribute_type` (`attribute_type_id`);

ALTER TABLE `product_attribute_value` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `product_attribute_value` ADD FOREIGN KEY (`attribute_id`) REFERENCES `product_attribute` (`attribute_id`);

ALTER TABLE `attribute_option` ADD FOREIGN KEY (`attribute_id`) REFERENCES `product_attribute` (`attribute_id`);
