
# Ecommerce-Data-Analysis-By-using-Sql
![image](https://github.com/Sudhansu352010/Ecommerce-Data-Analysis-By-using-Sql/assets/131376814/7bbda105-5a93-4cd9-a9f2-0232060dde10)

#  Tools & Technology Used
![image](https://github.com/Sudhansu352010/Ecommerce-Data-Analysis-By-using-Sql/assets/131376814/964ff773-111f-4f9b-9283-f06ea680d192)


# Our Approach For The Project
![image](https://github.com/Sudhansu352010/Ecommerce-Data-Analysis-By-using-Sql/assets/131376814/ff417b46-2ab8-4e1b-92e7-f674464acd37)


# Data Dictionary
![Capture55](https://github.com/Ashraf7474/Ecommerace_Database_Analysis/assets/131772000/73384311-b2b5-432e-bab3-aab343b1be84)

# --Introduction-- 

In this comprehensive E-commerce database analysis, we delve into the performance metrics of the platform to gain profound insights. We focus on critical indicators including highest sales, new customer acquisitions, revenue generation, top-selling products, and products with the highest profit margins. By harnessing the power of SQL queries, we extract valuable information from the database. Subsequently, we transform this data into an interactive and visually compelling Power BI dashboard. This dashboard serves as a window into the underlying data, providing a clear and actionable understanding of the platform's performance dynamics.

# --Problem aimed to solve--

Our analysis endeavors to provide a deeper understanding of the E-commerce platform's performance by dissecting vital metrics like sales, customer acquisition, revenue, and product profitability. Through an interactive Power BI dashboard, we intend to offer stakeholders actionable insights for informed decision-making and strategic enhancements, fostering the platform's growth and optimization.

# --Data Description-- 

The database comprises multiple CSV files containing diverse datasets, including customer information, order details, payment types, product data, order item specifics, shipper details, and seller records. These files collectively offer a comprehensive view of your e-commerce operations, enabling comprehensive analysis and informed decision-making.

# --Methodology--

The project methodology involves crafting SQL queries to extract meaningful insights from the diverse CSV files, followed by the creation of an interactive dashboard. This approach leverages data analysis and visualization to provide actionable information for informed decision-making and strategic planning.

# --Phases--

Data Collection: Acquire the comprehensive database from Kaggle, encompassing multiple CSV files containing essential information such as customer data, order details, payment types, product data, and more.

SQL Query Development: Craft intricate SQL queries to efficiently extract valuable insights from the diverse datasets. These queries will uncover trends, relationships, and patterns within the data, providing a solid foundation for analysis.

Power BI Dashboard Creation: Utilize the extracted insights to design an interactive and visually engaging Power BI dashboard. This dashboard will present a comprehensive view of the e-commerce operations, offering stakeholders the ability to explore data and gain actionable insights.

PowerPoint Presentation: Compile the project's findings, methodologies, and dashboard visuals into a concise PowerPoint presentation. This presentation will serve as a medium to effectively communicate the project's results, insights, and potential business implications.



# SQL Query Snapshot
![image](https://github.com/Sudhansu352010/Ecommerce-Data-Analysis-By-using-Sql/assets/131376814/fad3d2d8-f760-43ec-9bbe-7e58e9928275)

# Ecommerce Database Analysis by using SQL Query 

# 1.Print the Overall revenue made by the E- Commerce Company
select sum(total_order_amount) as Total_Revenue from orders;

# 2. Print the average total order amount across all orders in the database.
select avg(Total_order_amount) as Average_Total_Order_Amount from orders;

# 3. Print details of orders which have total order amount between 10000 and 20000 (both inclusive).Sort your output in ascending order of OrderID.
select * from orders 
where total_order_amount between 10000 and 20000
order by orderid asc;

# 4. Print details of orders which either have Total Order Amount less than 2000 or greater than 90000. Sort your output in ascending order of OrderID.
select * from orders
where total_order_amount<2000 or total_order_amount>90000
order by orderid  asc;

# 5. Find the Number of Customers belonging to each City of every Country.Print City, Country and Number of Customers belonging to each City and Country combination in your output.Sort the result set in alphabetical order of City names.
 select city, country, count(distinct customerid) as cnt from customers
 group by city, country
 order by city, country asc;
 
 # 6. Get the average Market Price across combinations of each Brand and Type. Print Brand in first column, Type in second column, followed by corresponding average Market Price in the third column.Sort the result set in alphabetical order of Brand, for rows with same Brand, sort them in alphabetical order of Type.
 select brand, type, avg(market_price) as avg_market_price from  products
 group by brand, type
 order by brand, type asc;
 
 # 7. Get the MAX Sale Price of Products across each Sub-Category. Sort the result set in alphabetical order of sub category.
 select sub_category, max(sale_price) as Max_Sale_Price from products
 group  by sub_category
 order by sub_category;
 
 # 8. Get the number of Customers from each city.Print City names in reverse alphabetical order in First column, count of customers in second column.
 select city, count(distinct customerid) as Count_of_Customers from customers
 group  by city
 order by city desc;
 

 
  
# 9. Identify top 10 most expensive orders. Identify the customers who placed these orders. Print Customer ID, First Name, Last Name and Total Order amount in the result set.Sort the result set in descending order of Total Order Amount.
select c.customerid, firstname, lastname, max(total_order_amount) as Expensive_Orders from customers
as c join orders as o on c.customerid=o.customerid
group by c.customerid, firstname, lastname
order by Expensive_Orders desc limit 10;



# 10. Identiy top 10 customers who placed the most number of orders. Print Customer ID, First Name, Last Name and Number of orders placed. Sort the result set in descending order of Number of orders, for same Number of orders sort such records in ascending order of Customer ID.
select c.customerid, firstname, lastname, count(distinct o.orderid) as Most_Number_Of_Orders from customers 
as c join orders as o on c.customerid=o.customerid
group by c.customerid, firstname, lastname
order by Most_Number_Of_Orders desc, c.customerid limit 10;




# 11. Print all details of the Customer who ordered only once.
select c.* from customers  as c 
join(select customerid, count(customerid) as Count_Of_Order
from orders 
group by customerid
having count(customerid)=1) as o
on c.customerid=o.customerid;

# 12. Identify top 3 Countries whose customers placed the most orders. Print Country and Number of Orders. Sort the result set in descendng order of Number of orders.
select country, count(distinct o.orderid) as Most_Orders from customers as c 
join orders as o on c.customerid=o.customerid
group by country
order by Most_Orders  desc limit 3;



# 13. Identify top 3 Countries whose customers placed the least orders. Print Country and Number of Orders. Sort the result set in ascending order of Number of orders.
select country, count(distinct o.orderid) as Least_Orders from customers as c 
join orders as o on c.customerid=o.customerid
group by country
order by Least_Orders  asc limit 3;



# 14. Identify top 3 Products which were ordered the most in quantity across all orders. Print Product ID, Product Name and corresponding total quantity. Sort the result set in descending order of total quantity.
select p.productid, product, sum(distinct quantity) as Total_Quantity from products as p
join orderdetails as od on p.productid=od.productid
group by p.productid, product
order by Total_Quantity desc limit 3;






# 15. Findout  how many repetitive customers who ordered more than once
select count(*) as Repetitive_Customers_Count
from(select customerid, count(*) as count_of_customers from orders
group by customerid
having count(*)>1) as repetitive_customers;



# 16. To generate the Total_Order_Amount, Total Revenue, Total Profit and Profit Margin for each orderid.
select o.orderid, Total_Order_Amount , sum(p.Sale_Price * od.Quantity) as Total_Revenue,
(sum(p.Sale_Price * od.Quantity)-p.Sale_Price) as Profit,
(sum(p.Sale_Price * od.Quantity)-p.Sale_Price)/ (sum(p.Sale_Price * od.Quantity))*100 as Profit_Margin
from orders as o join orderdetails as od on o.orderid=od.orderid
join products as p on p.productid=od.productid
group by o.orderid, Total_Order_Amount
order by o.orderid;

# 17. Print the details of different payment methods along with the total amount of money transacted through them in the years 2020 and 2021. Print Payment Type, Allowed, Transaction value in 2020, Transaction value in 2021. Order your output in alphabetical order of Payment Type. Include all payment types that exist in the database.
select paymenttype, allowed, sum(distinct(case when year(orderdate)='2020' then total_order_amount end)) as Transaction_value_in_2020,
sum(distinct(case when year(orderdate)='2021' then total_order_amount end)) as Transaction_value_in_2021
from orders as o join payments as p on o.paymentid=p.paymentid
group by paymenttype, allowed
order by paymenttype asc;






# 18. Print Customer ID and days difference between their first order and third order.If two or more orders are placed in a same day then prioritize the order with highest order amount.Filter the output for the customer Id where the days difference is less than 60. Sort the result in ascending order of customer Id.
with cte as(select customerid,orderdate,total_order_amount,dense_rank()
 over(partition by customerid order by orderdate, total_order_amount desc) as rnk from orders)
 select customerid,timestampdiff(day,min(case when rnk=1 then orderdate end),min(case when rnk=3 then orderdate end)) as third_order 
 from cte 
 where rnk between 1 and 3 
 group by customerid
 having third_order < 60 order by customerid;




 
 # 19. Print the Productid, Quantity and Orderdate for daily top - 3 selling products between January 2020 to March 2020. Essentially you are trying to identify the top 3 products sold for each date between the given date range. Sort the result in ascending order of OrderDate, for records with same orderdate, sort them in ascending order of Quantity.
 with cte as(select productid,sum(quantity) as total,orderdate from orders a join orderdetails b 
 on a.orderid = b.orderid where orderdate between '2020-01-01'and'2020-03-31' 
 group by productid,orderdate) 
 select productid,total,orderdate from 
 (select productid,total,orderdate, dense_rank()over(partition by orderdate order by total desc) as rnk from cte) as x 
 where rnk<=3 
 order by orderdate,total;

 
 # 20. How much payment collected through paymentId equal to 2 by each shippers in their first 10 orders. Print Shipper ID and Total payment Collection by that shipper. Sort the table in ascending order of shipper id.
 with cte as(select shipperid,orderid,sum(total_order_amount) as total from payments as p
 join orders as o on p.paymentid=o.paymentid where p.paymenttype="POD" 
 group by shipperid,orderid), 
 cte2 as(select shipperid,orderid,total,dense_rank() over(partition by shipperid order by orderid) as rnk from cte) 
 select shipperid,sum(total) as revenue from cte2
 where rnk<=10
 group by shipperid 
 order by shipperid;
 

 
 # 21. Rank the countries in terms of quantity of coffee ordered. Conside only the sub category's Coffee. If two or more country's consumptions are same assign them same rank.Print Rank, Country Name, Total Qunatity.Sort the Output on Ranking in ascending order, if two country rank is same then consider Country name in ascending order.
with cte as(select country,sum(quantity) as total from products p join orderdetails od on p.productid=od.productid 
join orders o on od.orderid=o.orderid join customers c on o.customerid=c.customerid 
where sub_category="coffee" 
group by country) 
select dense_rank() over(order by total desc) as rnk,country,total from cte;

# Aggregation on Different KPI’s
![image](https://github.com/Sudhansu352010/Ecommerce-Data-Analysis-By-using-Sql/assets/131376814/2441e243-7c59-4b5d-b5bf-c64ea2131590)
--------------------------------------------------------------------------------------------------------------------------------------
![image](https://github.com/Sudhansu352010/Ecommerce-Data-Analysis-By-using-Sql/assets/131376814/da363ca7-c514-406c-b72a-16d72107d90a)
--------------------------------------------------------------------------------------------------------------------------------------
![image](https://github.com/Sudhansu352010/Ecommerce-Data-Analysis-By-using-Sql/assets/131376814/f03eea5f-afd0-414f-86a8-a526d7db2ee7)
--------------------------------------------------------------------------------------------------------------------------------------
![image](https://github.com/Sudhansu352010/Ecommerce-Data-Analysis-By-using-Sql/assets/131376814/6deffd66-5172-454b-8d0a-b6f3149696ed)

# --DashBoard Creation--
Here is the main dashboard which is dynamic in nature and the slicer added

![E-commerace Dashboard Image](https://github.com/Ashraf7474/Swiggy_Restrauant_Recommendation_Model/assets/131772000/4ffc6a7f-d1ac-4cd7-b755-7a5789f6da20)



# Key Insights
1. Sales growth in each of the respective quarters of the year is not satisfactory.
2. Revenue continuously decreases; the company should take precautionary action for that.
3. The company mainly focuses on its average delivery time for each order.
4. The retention rate of customers is good.
5. Alpha Imports generate the highest percentage of revenue, while Tasha Apparel generates the lowest percentage of revenue.
6. Brands like Prestige generate the highest revenue.
7. The category Beauty and Hygiene generates the highest revenue.
8. The brand with the highest average ratings is Alkalen, i.e., 4.50, and the brand with the lowest average ratings is Raw Pressery, i.e., 3.35.
9. Skin care, Fragrances, and Cookware are the top-selling subcategories by revenue.
10. Organic, Herbs, and Marinade are the least selling subcategories by revenue.
11. Beauty & Hygiene, Kitchen, and World Food are the top-selling categories by revenue.
12. Fruits & Vegetables, Eggs Meat & Fish, and Bakery are the highest selling categories by revenue.
13. BB Home, bb Royal, and Fresho are the top-selling brands according to quantity.
14. Stainless steel Contura pressure cooker products generate the maximum revenue, while Marie Light Oats Biscuits generate the least revenue in terms of product.


# Challenges Faced

In this comprehensive E-commerce database analysis project, our objective is to leverage SQL queries to extract crucial insights from a multitude of CSV files, covering customer data, order details, payment types, product information, and more. These insights will be transformed into an interactive Power BI dashboard, providing stakeholders with a clear understanding of sales, customer acquisition, revenue generation, and product profitability.

Throughout the project, we anticipate challenges such as data quality issues, the complexity of SQL queries, and the design of an effective dashboard. We will address these challenges by implementing data cleaning techniques, breaking down complex queries, and following best practices in data visualization. Our ultimate goal is to empower decision-makers with actionable insights, fostering the growth and optimization of the E-commerce platform while ensuring data privacy and compliance with security protocols.





