## 🎵Apple iTunes Music Analysis 

### 📌Project Overview
The Apple iTunes Music Analysis project aims to analyze sales and customer behavior data from the Apple iTunes Store to derive insights that can help the marketing, product, and operations teams make informed decisions.

#### 🎯Objectives: 
- Identify the most popular music genres and tracks. 
- Analyze sales performance by country and city. 
- Determine peak sales periods for promotional campaigns.
- Understand customer behavior and preferences.
- Recommend actionable strategies to improve sales and user engagement.

### 📂Data Source
The dataset is based on Apple iTunes sample database containing multiple relational tables:

- **Customer** – customer details (name, email, country)
- **Invoice** – purchase transactions
- **Invoice_Line** – detailed items in each invoice
- **Track** – track details (name, genre, composer)
- **Genre** – list of genres
- **Artist** – music artists
- **Album** – album details
- **Playlist** – playlists
- **Playlist_Track** – mapping between tracks and playlists
- **Media_Type** – types of media (audio, video)
- **Employee** – sales/support employees

### 🛠️Tools Used:
- **SQL (MySQL)** - data extraction and preprocessing
- **Power BI** - dashboard creation and visualisation

### 🧹Data Cleaning and Preprocessing
- Checked for missing values and inconsistencies.
- Standardized data formats(dates, currency).
- Created joins between tables for analysis.

## 🗄️ SQL Analysis
- Performed joins across multiple tables
- Created revenue and customer metrics
- Identified top genres and artists
- Wrote optimized queries using GROUP BY and JOIN

#### 📄SQL File: [View Queries](LINK)

### 📈Power BI Dashboard

The interactive dashboard includes:

- Revenue by Country (Tree Map)
- Top Tracks & Genres (Bar Chart)
- Sales Over Time (Line Chart)
- Revenue by Genre (Pie Chart)
- Inactive Customers (Last 6 Months – Table)
- Repeat vs One-Time Customers (Bar Chart)
- Most Popular Songs (Column Chart)
- KPIs (Cards: Total Revenue, Customers, Top Genre, Top Track)
- Slicers (Interactive filters for Country, City, Date, Genre)

#### 📄Dashboard Preview: [View Dashboard PDF](https://github.com/ChamaKaushik/Apple_iTunes_Music_Analysis_SQL_Power-BI/blob/main/Dashboard_pdf.pdf)

### 📊Key Insights

- **Sales by Country**: USA generated the highest revenue, followed by Canada and the UK.

- **Top-Selling Genres**: Rock and Pop dominated sales.

- **Top Artists**: Queen, Jimi Hendrix were among the most popular.

- **Sales Trends**: Peak sales occurred during weekends and holidays.

- **Customer Behavior**: Many customers bought multiple tracks together → recommendation system can improve bundles.


### 6.Recommendations

- **Marketing**: Focus campaigns in high-revenue countries, align promotions with peak sales periods.
- **Product**: Promote top genres (Rock, Pop), introduce track bundles.
- **Operations**: Ensure availability/licensing for high-demand tracks, optimize infrastructure during peak load.
