#  Industrial Spare Parts Demand Analysis & Market Benchmarking

##  Objective
To simulate a real-world MRO (Maintenance, Repair & Operations) supply chain environment where internal inventory data is benchmarked against online market listings. This helps uncover actionable insights on stock health, price optimization, vendor performance, and warehouse efficiency.

---

##  Tools & Technologies
- Python (Selenium, Pandas)
- MySQL
- Power BI
- Excel
- Fuzzy Matching (fuzzywuzzy)
- GitHub + Google Drive

---

##  Project Structure

```
 Industrial_Spare_Parts_Analysis_Mayureshwar/
├── data/
│   ├── inventory_cleaned.csv
│   ├── amazon_scraped_cleaned.csv
│   ├── inventory_merged.csv
│   ├── sql_outputs/
│   │   ├── understocked_items.csv
│   │   ├── price_gap_analysis.csv
│   │   └── top_value_picks.csv
├── dashboard/
│   ├── Inventory Health Dashboard.pbix
│   ├── Market Benchmarking & Vendor Evaluation.pbix
│   └── Market Insights – Amazon Web Scraped Data.pbix
├── screenshots/
│   └── PowerBI_Page1_InventoryHealth_Layout.png
├── scripts/
│   ├── amazon_scraper.py
│   └── data_clean_merge.py
├── sql/
│   ├── create_tables.sql
│   └── advanced_queries.sql
├── README.md
```

---

## Project Execution Summary

###  Step 1: Internal Inventory Dataset Creation
Simulated 100+ spare parts with fields like Item Code, Stock, Reorder Level, Demand, and Warehouse.

###  Step 2: Web Scraping from Amazon
Used Selenium to collect real-time listings, prices, ratings, and availability across multiple spare part categories.

###  Step 3: Data Cleaning & Enrichment
Processed raw data, added `Stock_Status` logic, performed fuzzy matching for benchmarking.

###  Step 4: SQL Table Creation & Import
Loaded both datasets into MySQL, structured via SQL, and created analytical queries.

###  Step 5: Power BI Dashboard
Built 3 separate `.pbix` dashboards:
- **Inventory Health Dashboard**
- **Market Benchmarking & Vendor Evaluation**
- **Market Insights – Amazon Web Scraped Data**

---

##  Dashboard Pages Summary

1. **Inventory Health Overview** – visualizes stock status across categories and warehouses
2. **Market Benchmarking & Vendor Evaluation** – compares internal prices with online listings and ranks sellers
3. **Procurement Strategy & Cost Savings** – highlights urgent restock items, overstock risks, and cost-saving opportunities
4. **Market Insights from Web-Scraped Amazon Data** – analyzes ratings, availability, seller behavior from scraped data

---

##  Industry-Impactful Insights

- Identified 37% understocked items
- Flagged overpriced categories (18–30% above market)
- Mapped vendors by rating and price
- Suggested internal redistribution to reduce POs
- Showcased availability and performance of web-scraped products

---

##  How to Use This Project

1. Clone repo or download from Google Drive
2. Open the relevant `.pbix` dashboard in Power BI Desktop
3. Load or refresh datasets as needed
4. Use filters and slicers to explore insights

---

##  Created by Mayureshwar Dhage
End-to-end project on Supply Chain Analytics | Data Science | Business Intelligence
