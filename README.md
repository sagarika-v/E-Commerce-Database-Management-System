# E-Commerce Database Management System

A relational database system for managing the core operations of an e-commerce platform, including customers, products, shopping carts, orders, payments, deliveries, and product reviews.

## Tech Stack

**MySQL · SQL · MySQL Workbench**

## Features

* Customer and supplier management
* Product and category management
* Shopping cart and cart item management
* Order and order item management
* Payment tracking
* Delivery and tracking management
* Product ratings and reviews
* Customer order management
* Product and category analysis

## Database

**Database:** `ecommerce`

### Tables

`CUSTOMER` · `CATEGORY` · `SUPPLIER` · `PRODUCT` · `CART` · `CART_ITEM` · `ORDERS` · `ORDER_ITEM` · `PAYMENT` · `DELIVERY` · `REVIEW`

## SQL Implementation

The project includes:

* Database and table creation
* Primary and foreign key relationships
* Data constraints and validation
* CRUD operations
* INNER, LEFT, RIGHT and CROSS JOINs
* FULL JOIN concept using `UNION`
* Subqueries
* Database Views
* Stored Procedures

### Views

* `Customer_Order_View`
* `Product_Details_View`
* `Order_Payment_View`

### Stored Procedures

* `GetCustomerOrders`
* `GetProductsByCategory`
* `GetOrderDetails`

## Project Structure

```text
E-Commerce-Database-Management-System/
│
├── E-commerce project.sql
└── README.md
```

## How to Run

1. Open **MySQL Workbench**.
2. Open `ecommerce_database.sql`.
3. Execute the script.
4. Select the database:

```sql
USE ecommerce;
```

5. Verify the tables:

```sql
SHOW TABLES;
```

