
 /*Objective: Unveiling the Android App Market: Analyzing Google Play Store Data
Description:
 Clean, categorize, and visualize Google Play Store data to understand app market dynamics.
 Gain in-depth insights into the Android app market by leveraging data analytics, visualization,
 and enhanced interpretation skills*/
 /*After Primarily cleaing the data from excel. Imported all data in SQL*/
 /*formula- IsText is used to find number in TEXt format and data validation,Custom formula
 are used to convert the date,numbers in correct format.
 The "Nan" in user_reviewss are converted to neutral as Sentiment Polarity is marked as 0"*/
 

select * from appss;
select * from user_reviewss;

select count(*) from appss; /*No. of rows-9659*/
select count(*) from user_reviewss; /*No. of rows-64295*/


/*HANDLING NULL VALUE */
UPDATE appss
SET 
    Android_Ver = COALESCE(Android_Ver, 0),
    current_version = COALESCE(current_version, 0),
    Rating = COALESCE(Rating, 0),
	Reviews= COalesce(Reviews,0),
	Installs= COALESCE(INSTALLS,0)
WHERE 
    Rating IS NULL 
    OR current_version IS NULL 
    OR Android_Ver IS NULL
	OR Reviews is NULL
	OR INSTALLS IS NULL;


DELETE FROM appss
WHERE size IS null;

select * from appss;
select * from user_reviewss;



/*Number of app in each category*/
select  Category,count(*) as no_of_app
from appss 
group by Category
order by no_of_app desc;

/*Top 5 category*/
select top 3 Category,count(*) as no_of_app
from appss 
group by Category
order by no_of_app desc
select distinct installs from appss
;
/*TOP 10 APPS WITH RATING MORE THAN 4.5 AND HAVE REVIEW*/
SELECT TOP 10 app,
       installs,
       Rating,
       CASE
           WHEN installs < 1000000 THEN 'Less than 1 million'
           WHEN installs BETWEEN 1000000 AND 5000000 THEN '1 million to 5 million'
           WHEN installs BETWEEN 5000001 AND 10000000 THEN '5 million to 10 million'
           WHEN installs BETWEEN 10000001 AND 50000000 THEN '10 million to 50 million'
           WHEN installs BETWEEN 50000001 AND 100000000 THEN '50 million to 100 million'
           WHEN installs > 100000000 THEN 'Greater than 100 million'
           ELSE 'Other'
       END AS category
FROM appss
WHERE Rating > 4.5 AND Reviews > 0
ORDER BY installs DESC;

/*NUMBER OF FREE AND PAIDS APP IN EACH CATEGORY*/
SELECT CATEGORY,TYPE,COUNT(*) AS NO_OF_APP FROM APPSS
GROUP BY CATEGORY,TYPE
ORDER BY CATEGORY,NO_OF_APP DESC;

/*CONTENT RATING OF APP BY DIFFERNT GROUPS*/
SELECT CONTENT_RATING,COUNT(*) AS NO_OF_REIVEWS FROM APPSS
GROUP BY CONTENT_RATING

/*no. of  subcategory in each category */
SELECT category,count(genres)as sub_category FROM APPSS group by category;


/*app of  which reviews are present*/
select distinct appss.app from appss right join user_reviewss on appss.app=user_reviewss.app where appss.app is not null;

/*All app with All Review sentiment*/
select app as Apps_Name,sentiment as Sentiments,count(sentiment) as No_of_responses
from user_reviewss
group by app,sentiment
order by Apps,No_of_responses desc;



/*Top 3 App with Positive,Negative and neutal reivews*/

WITH Cte AS (
SELECT app AS Apps_Name,sentiment AS Sentiments,COUNT(sentiment) AS No_of_responses,
        ROW_NUMBER() OVER (PARTITION BY sentiment ORDER BY COUNT(sentiment) DESC) AS rn
FROM user_reviewss
GROUP BY app,sentiment
)
SELECT Apps_Name,Sentiments,No_of_responses
FROM Cte
WHERE rn <= 3
ORDER BY Sentiments, No_of_responses DESC;

/*Reviews of different app in each category which have rating>4.5*/
select a.category,u.app,count(*) as number_review from appss a right join user_reviewss u on a.app=u.app 
where a.app is not null and a.rating>4.5
group by a.category,u.app
order by Category ;

/*app reivew with positive review based on option as (Sentiment_Subjectivity >0)*/
select  distinct u.app,u.Sentiment,count(*) from appss a right join user_reviewss u on a.app=u.app 
where Sentiment_Subjectivity>0 and a.app is not null
group by u.app,u.Sentiment,Sentiment_Polarity

/*app reivew with differnt sentiments based on fact as (Sentiment_Subjectivity =0)*/
select  u.app,u.Sentiment,count(*) from appss a right join user_reviewss u on a.app=u.app 
where Sentiment_Subjectivity =0
group by u.app,u.Sentiment,Sentiment_Polarity

/*review on basis on opinions and fact*/
select count(case when Sentiment_Subjectivity =0 then 1 else null end)as facts,
		count(case when Sentiment_Subjectivity >0 then 1 else null end)as opinions 
from user_reviewss

/*review on differnt sentiments*/
select count(case when Sentiment_Polarity >0 then 1 else null end)as Postive,
		count(case when Sentiment_Polarity <0 then 1 else null end)as Negative,
		count(case when Sentiment_Polarity =0 then 1 else null end)as Neutral
from user_reviewss

/*differnt App review based on facts and opinions */
select Sentiment,count(case when Sentiment_Subjectivity =0 then 1 else null end)as facts,
		count(case when Sentiment_Subjectivity >0 then 1 else null end)as opinions 
from user_reviewss
group by Sentiment

/*Mean and Standard Deviation of Sentiment Polarity*/
SELECT
    AVG(sentiment_polarity) AS mean_polarity,
    STDEV(sentiment_polarity) AS standard_deviation_polarity
FROM user_reviewss;

/*Mean and Standard Deviation of Sentiment Subjectivity*/
SELECT
    AVG(sentiment_subjectivity) AS mean_subjectivity,
    STDEV(sentiment_subjectivity) AS standard_deviation_subjectivity
FROM user_reviewss;
