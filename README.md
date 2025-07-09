# 📱 Google Play Store App Analysis – EDA Using SQL

## 📌 Project Overview  
This project analyzes Google Play Store data to understand trends in app categories, user reviews, ratings, monetization types, and sentiment patterns. The goal is to uncover insights into user behavior and app performance using data cleaning, SQL queries, and exploratory analysis.

## 🛠 Tools Used  
- **Excel**: For initial data cleaning (type conversion, handling NaNs, formatting issues)  
- **MS SQL Server**: For EDA and querying structured datasets  
- **Power BI** *(optional visualization not shown in SQL)*

## 🎯 Objective  
- Clean, categorize, and analyze app metadata and user reviews  
- Understand the distribution of installs, ratings, and review sentiment  
- Identify high-performing apps and categories  
- Compare paid vs. free app dynamics and audience content ratings

## ⚙️ Key SQL Analysis Performed  
- Cleaned nulls and standardized numeric fields in Excel and SQL  
- Calculated total apps per category and sub-category  
- Identified top-rated and most-reviewed apps  
- Grouped installs into ranges for performance tiers  
- Analyzed sentiment polarity and subjectivity from user reviews  
- Calculated sentiment trends by app and category  
- Compared reviews based on facts vs. opinions  
- Computed mean and standard deviation for sentiment metrics

## 📊 Key Insights  
- Most apps fall under the **Tools**, **Education**, and **Entertainment** categories  
- Highly-rated apps (rating > 4.5) tend to have higher install counts and more reviews  
- Positive sentiment is more frequent in apps with higher installs  
- **Subjective reviews (opinions)** were far more common than **objective (factual)** ones  
- The average sentiment polarity across reviews was slightly positive, with notable standard deviation

## 📁 Files Included  
- `playstore_analysis.sql`: SQL script containing all EDA and sentiment queries  
- `README.md`: This project summary  
-  `PowerBidashboard_screenshot`: Screenshots of Power BI dashboard

## 🚀 Possible Extensions  
- Visualize key trends in Power BI or Tableau  
- Perform category-wise sentiment comparison  
- Track app performance over time with monthly review trends
