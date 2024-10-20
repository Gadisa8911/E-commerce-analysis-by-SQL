-- THE ORIGINAL DATASET WAS TAKEN FROM KAGGLE WHICH IS ABOUT ONLINE E_COMMERCE MARKET AND I TRIED TO ANALYZE BY USING SOME PARAMETERS
-- ANYONE WHO INTERESTED IN DATA ANALYTICS CAN DOWNLOAD AND RUN IT OVER HIS OR HER MYSQL WORKBENCH
-- HOWEVER,USING FOR ANOTHER PURPOSE IS MORALLY WRONG! AND FINALLY I AM VERY GRATEFUL TO THEM WHO PREPARED THIS DATA AND GIVES US FOR FREE 
-- TO ANALYZE.
-- BY THE WAY WE CAN ANSWER MANY BUSINNES QUESTION BASED ON THESE DATA BUT I TOOK ONLY THE FOLLOWING 7 PARAMETERS TO ANALYZE THE MARKET
-- DONE BY GADISA FIKADU

-- this dataset is taken from the Kaggles website to analysis the E-commerce market
-- which contains product_id ,product_name product_category,product_price,customer review_score,
-- customer review_count and sale_month from january to December.

--  1) let Identifying which products are generating the most revenues

SELECT category,
	SUM(sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + sales_month_5+ sales_month_6
	+ sales_month_7 + sales_month_8 + sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12) AS total_sales
FROM data_sales
GROUP BY category
ORDER BY total_sales DESC;
-- FROM THIS WE CAN CONCLUDE THAT BOOKS ARE GENERATING THE MOST REVENUE AND HOME AND KITCHEN ARE GENERATING THE LEAST REVENUE.

-- 2) IDENTIFYING WHICH PRODUCTS HAVE THE HIGHEST CUSTOMER REVIEW AND WHICH PRODUCTS HAS THE LEAST CUSTOMER REVIEW

SELECT product_name,MAX(review_count) AS MAX_review
FROM data_sales
GROUP BY product_name
ORDER BY MAX_review DESC
LIMIT 10;
-- so, product_903 have maximum review from the whole 1000 products which is 999 that means 999 people commented on the product

-- 3) NOW LET SEE WHICH PRODUCT HAS MINIMUM CUSTOMER REVIEW

SELECT product_name,MIN(review_count) AS MIN_review
FROM data_sales
GROUP BY product_name
ORDER BY MIN_review ASC
LIMIT 10;
-- SO, BOTH PRODUCT_616 AND PRODUCT_339 HAVE THE LEAST CUSTOMER REVIEW WHICH IS EQUAL 
-- TO 1 REVIEW RHIS MEANS THAT ONLY ONE CUSTOMERS COMMENTED ON THE PRODUCT

-- 4) so let analyze which product has maximum review score which means highely liked by the customers

SELECT product_name,MAX(review_score) AS MAX_review_score
FROM data_sales
GROUP BY product_name
ORDER BY MAX_review_score DESC
LIMIT 20;
-- THIS IMPLIES OUT 1000 PRODUCTS ONLY 19 PRODUCTS GET 5 OUT OF 5 RATING 

-- 5) NOW LET SEE WHICH PRODUCT HAS MINIMUM REVIEW SCORE SO THAT WE CAN EASLY IDENTIFY WHICH PRODUCT
--  IS  LESS LIKED BY OUR CUSTOMER OR MAY BE HAS POOR QUALITY

SELECT product_name,MIN(review_score) AS MIN_review_score
FROM data_sales
GROUP BY product_name
ORDER BY MIN_review_score ASC
LIMIT 20;
-- SO, 'Product_484'
-- 'Product_753'
-- 'Product_284'
-- 'Product_744'
-- 'Product_800'
-- 'Product_516'
-- 'Product_922'
-- 'Product_265'
-- 'Product_887'
-- 'Product_902'
-- 'Product_169' ARE THE LEAST LIKED PRODUCT BY OUR CUSTOMERS BECUASE MAY BE IT IS EXPENSIVE OR OUTDATED OR HAS LESS QUALITY
-- SO WE NEED TO LOOK AFTER THESE PRODUCTS IN ORDER TO SATISFY OUR CUSTOMERS ALTHOUGH WE CANNOT CONCLUDE WITH ONLY THESE INFORMAIOM, MORE OR LESS IT SHOWS 
-- OUR CUSTOMERS ARE LESS SATISFIED WITH THESE PRODUCTS

-- 6) SALES TREND OVER TIME
SELECT SUM(sales_month_1) AS month1_sales,
       SUM(sales_month_2) AS month2_sales,
       SUM(sales_month_3) AS month3_sales,
       SUM(sales_month_4) AS month4_sales,
       SUM(sales_month_5) AS month5_sales,
       SUM(sales_month_6) AS month6_sales,
       SUM(sales_month_7) AS month7_sales,
       SUM(sales_month_8) AS month8_sales,
       SUM(sales_month_9) AS month9_sales,
       SUM(sales_month_10) AS month10_sales,
       SUM(sales_month_11) AS month11_sales,
       SUM(sales_month_12) AS month12_sales
FROM data_sales;
-- FROM THIS WE CAN SEE THAT FROM MONTH1 TO MONTH2 OUR SALES INCREASES 
-- FROM 2 TO 3 DECREASE,FROM 3 TO 4 DECREASE,FROM 4 TO 5 DECREASE, FROM 5 TO 6 INCREASE,FROM 6 TO 7 INCREASE,
-- FROM 7 TO 8 DECREASE, FROM 8 TO 9 DECREASE,FROM 9 TO 10 INCREASE, FROM 10 TO 11 DECREASE,FROM 11 TO 12 DECREASE 
-- WHICH IMPLIES THAT FOR THE MOST PARTS OUR SALES TENDS TO DECREASE FROM TIME TO TIME 

-- 7) IDENTIFY WHICH PRODUCTS ARE UNDERPERFORMING BASED ON LOW CUSTOMER REVIEW SCORE AND LOWER SALES

SELECT product_id,product_name,category,review_score,
	(sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + sales_month_5+ sales_month_6
	+ sales_month_7 + sales_month_8 + sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12) AS total_sales
FROM data_sales
WHERE review_score < 3 AND (sales_month_1 + sales_month_2 + sales_month_3 + sales_month_4 + sales_month_5+ sales_month_6
	+ sales_month_7 + sales_month_8 + sales_month_9 + sales_month_10 + sales_month_11 + sales_month_12) < 10000;
-- so we filtered our product which have low customer review score and overall sales of less than 10000 as low performing products
-- so that we will improve or discontinue that product 

