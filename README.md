# 📦 ShopFinity Database Schema

Welcome to the **ShopFinity** database schema! This project defines a flexible and scalable database design for a comprehensive e-commerce platform. The schema was designed using the [dbdiagram.io](https://dbdiagram.io) format and supports key functionalities for managing products, brands, categories, variations, attributes, and media assets.

---

## 🗂️ Overview

The **ShopFinity DB** is structured to support a modern product catalog and inventory system for both physical and digital goods. The schema is optimized for:

- Managing complex product variations (e.g. size, color, material)
- Associating multimedia (images/videos) with products
- Defining custom product attributes and filters
- Tracking inventory per product variation (SKU level)
- Supporting parent-child category hierarchies
- Ensuring referential integrity and normalized structure

---

## 🏗️ Entity Descriptions

### 🔖 `brand`
Represents product brands/manufacturers.
- Fields: `brand_id`, `brand_name`, `brand_description`, `founded_year`, etc.

### 📁 `product_category`
Hierarchical structure for organizing products into nested categories.
- Supports self-referencing via `parent_category_id`.

### 🛒 `product`
The main product catalog. Each product is associated with a `brand` and a `product_category`.

### 🎚️ `product_variation` & `product_variation_option`
Defines customizable product options (e.g. size, color), allowing complex variations and display orders.

### 📦 `product_item`
Represents a sellable item with a unique SKU. Handles stock and dimension tracking.

### 🎨 `color`, 🧷 `size_category`, `size_option`
Reusable color and size definitions for consistent option values across products.

### 🖼️ `product_image` & 🎥 `product_video`
Supports multiple media assets per product with primary/secondary indicators.

### 🧩 `attribute_category`, `attribute_type`, `product_attribute`, `attribute_option`, `product_attribute_value`
Custom and dynamic product specifications, including filterable or required product attributes with various input types.

---

## 🧠 Highlights

- ✅ **Normalization**: Avoids redundancy and supports scalability.
- 🔍 **Fulltext Search**: Enabled on `product_name` and `product_description`.
- 🧬 **Extensibility**: Add new variation types or attributes without major schema changes.
- 🔐 **Data Integrity**: Foreign keys and unique constraints ensure data consistency.
- 📈 **Analytics Friendly**: `created_at` and `updated_at` timestamps on key tables.

---

## 🔄 ERD & Visualization

You can visualize this schema directly using [dbdiagram.io](https://dbdiagram.io):


