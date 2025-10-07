CREATE TABLE [users] (
  [user_id] integer PRIMARY KEY,
  [username] nvarchar(255),
  [email] nvarchar(255),
  [password] nvarchar(255),
  [created_at] timestamp
)
GO

CREATE TABLE [customers] (
  [customer_id] integer PRIMARY KEY,
  [customer_name] nvarchar(255),
  [phone] varchar(10),
  [address] nvarchar(255),
  [customer_type] nvarchar(255) DEFAULT 'Retail',
  [join_date] timestamp,
  [created_at] timestamp,
  [updated_at] timestamp
)
GO

CREATE TABLE [sales] (
  [sales_id] integer PRIMARY KEY,
  [sales_number] nvarchar(255) UNIQUE,
  [customer_id] integer,
  [customer_name] nvarchar(255),
  [customer_address] nvarchar(255),
  [gst_number] nvarchar(255),
  [subtotal_amount] decimal(10,2),
  [gst_amount] decimal(10,2),
  [discount_amount] decimal(10,2),
  [total_amount] decimal(10,2),
  [paid_amount] decimal(10,2),
  [balance_amount] decimal(10,2),
  [status] nvarchar(255),
  [payment_method] nvarchar(255),
  [notes] nvarchar(255),
  [issue_date] timestamp,
  [due_date] timestamp,
  [created_at] timestamp,
  [updated_at] timestamp
)
GO

CREATE TABLE [notes] (
  [notes_id] integer PRIMARY KEY,
  [notes_title] nvarchar(255),
  [notes_content] nvarchar(255),
  [notes_operation] varchar(1),
  [notes_flag] nvarchar(255),
  [created_at] timestamp,
  [updated_at] timestamp
)
GO

CREATE TABLE [sales_notes] (
  [sales_id] integer,
  [notes_id] integer
)
GO

CREATE TABLE [item_category] (
  [category_id] integer PRIMARY KEY,
  [category_name] nvarchar(255),
  [created_at] timestamp
)
GO

CREATE TABLE [item_unit] (
  [unit_id] integer PRIMARY KEY,
  [unit_name] nvarchar(255),
  [created_at] timestamp
)
GO

CREATE TABLE [inventory] (
  [item_id] integer PRIMARY KEY,
  [item_code] nvarchar(255) UNIQUE,
  [item_name] nvarchar(255) UNIQUE,
  [category_name] nvarchar(255),
  [unit_name] nvarchar(255),
  [available_quantity] decimal(10,2),
  [reorder_level] decimal(10,2),
  [stock_status] nvarchar(255),
  [sale_cost] decimal(10,2),
  [order_status] nvarchar(255),
  [created_at] timestamp,
  [updated_at] timestamp
)
GO

CREATE TABLE [sold_items] (
  [sold_item_id] integer PRIMARY KEY,
  [sale_number] nvarchar(255),
  [item_id] integer,
  [item_name] nvarchar(255),
  [item_unit] nvarchar(255),
  [sold_quantity] decimal(10,2),
  [sold_cost] decimal(10,2),
  [sold_amount] decimal(10,2),
  [is_processed] bool DEFAULT (0),
  [created_at] timestamp
)
GO

ALTER TABLE [sales] ADD FOREIGN KEY ([customer_id]) REFERENCES [customers] ([customer_id])
GO

ALTER TABLE [sales_notes] ADD FOREIGN KEY ([sales_id]) REFERENCES [sales] ([sales_id])
GO

ALTER TABLE [sales_notes] ADD FOREIGN KEY ([notes_id]) REFERENCES [notes] ([notes_id])
GO

ALTER TABLE [inventory] ADD FOREIGN KEY ([category_name]) REFERENCES [item_category] ([category_name])
GO

ALTER TABLE [inventory] ADD FOREIGN KEY ([unit_name]) REFERENCES [item_unit] ([unit_name])
GO

ALTER TABLE [sold_items] ADD FOREIGN KEY ([item_id]) REFERENCES [inventory] ([item_id])
GO

ALTER TABLE [sales] ADD FOREIGN KEY ([sales_number]) REFERENCES [sold_items] ([sale_number])
GO
