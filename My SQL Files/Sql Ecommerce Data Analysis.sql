use cricket_db_database;
# Ecommerce Database Analysis by using SQL Query 
##Some easy type questions that necessary for project consideration

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
 
 # 9. Get the city and states which have less than 3 customers. Print City, State and Count of customers who belong to that city. Sort the result set in alphabetical order of City names.
 select city, state, count(distinct customerid) as Count_of_Customers from customers
 group by city, state
 having count(distinct customerid)<3
 order by city asc;
 
 
 # 10. Print all the details of Customers whose First Names start with a vowel. Sort the output in ascending order of Customer ID.
select * from customers 
where firstname like 'a%' or firstname like 'e%' or firstname like 'i%' or firstname like 'o%' or firstname like 'u%'
order  by customerid asc;
 
 
 
 
 
 #Some Medium type questions that necessary for project consideration
 
# 1. Count the Number of Orders placed through each Payment Method. Print the PaymentID and the Number of Orders placed in the output. Sort the result set in ascending order of PaymentiD.
 select p.paymentid, count(distinct o.orderid) as Number_of_Orders from orders 
  as o join payments as p on o.paymentid=p.paymentid
  group by p.paymentid
  order by p.paymentid;
  
  
# 2. Identify top 10 most expensive orders. Identify the customers who placed these orders. Print Customer ID, First Name, Last Name and Total Order amount in the result set.Sort the result set in descending order of Total Order Amount.
select c.customerid, firstname, lastname, max(total_order_amount) as Expensive_Orders from customers
as c join orders as o on c.customerid=o.customerid
group by c.customerid, firstname, lastname
order by Expensive_Orders desc limit 10;



# 3. Identiy top 10 customers who placed the most number of orders. Print Customer ID, First Name, Last Name and Number of orders placed. Sort the result set in descending order of Number of orders, for same Number of orders sort such records in ascending order of Customer ID.
select c.customerid, firstname, lastname, count(distinct o.orderid) as Most_Number_Of_Orders from customers 
as c join orders as o on c.customerid=o.customerid
group by c.customerid, firstname, lastname
order by Most_Number_Of_Orders desc, c.customerid limit 10;




# 4. Print all details of the Customer who ordered only once.
select c.* from customers  as c 
join(select customerid, count(customerid) as Count_Of_Order
from orders 
group by customerid
having count(customerid)=1) as o
on c.customerid=o.customerid;

# 5. Identify top 3 Countries whose customers placed the most orders. Print Country and Number of Orders. Sort the result set in descendng order of Number of orders.
select country, count(distinct o.orderid) as Most_Orders from customers as c 
join orders as o on c.customerid=o.customerid
group by country
order by Most_Orders  desc limit 3;



# 6. Identify top 3 Countries whose customers placed the least orders. Print Country and Number of Orders. Sort the result set in ascending order of Number of orders.
select country, count(distinct o.orderid) as Least_Orders from customers as c 
join orders as o on c.customerid=o.customerid
group by country
order by Least_Orders  asc limit 3;



# 7. Identify top 3 Products which were ordered the most in quantity across all orders. Print Product ID, Product Name and corresponding total quantity. Sort the result set in descending order of total quantity.
select p.productid, product, sum(distinct quantity) as Total_Quantity from products as p
join orderdetails as od on p.productid=od.productid
group by p.productid, product
order by Total_Quantity desc limit 3;



# 8. Identify the Average Amount spent by each customer across all the orders placed by them. Print Customer ID, First Name, Last Name and Average Amount Spent. Sort the result set in ascending order of Customer ID.
select c.customerid, firstname, lastname, avg(total_order_amount) as Average_Amount_Spent from customers 
as  c join orders as o on c.customerid=o.customerid
group by c.customerid, firstname,  lastname 
order by c.customerid asc;


# 9. For each customer identify the order which had the Least Total Order Amoun paid by them. Print Customer ID, First Name, Last Name,Least Total Order Amount. Sort the result set in ascending order of Customer ID.
select c.customerid, firstname, lastname, min(total_order_amount) as Least_Order_Amount from customers 
as c join orders as o on c.customerid=o.customerid
group by c.customerid, firstname, lastname
order by c.customerid asc;


# 10. Identify which was the highest transaction value for each payment method. Print Payment ID, Payment Type and Highest transaction value for that particular payment type. Include all payment methods irrespective of their active status. Sort the result set in ascending order of Payment ID.
select p.paymentid, paymenttype, max(total_order_amount) as Highest_Transaction from orders 
as o  left join payments as p on o.paymentid=p.paymentid
group by p.paymentid, paymenttype
order by p.paymentid asc;


# 11. Findout  how many repetitive customers who ordered more than once
select count(*) as Repetitive_Customers_Count
from(select customerid, count(*) as count_of_customers from orders
group by customerid
having count(*)>1) as repetitive_customers;


#Some Hard type questions that necessary for project consideration

# 1. To generate the Total_Order_Amount, Total Revenue, Total Profit and Profit Margin for each orderid.
select o.orderid, Total_Order_Amount , sum(o.Total_Order_Amount * od.Quantity) as Total_Revenue,
(sum(o.Total_Order_Amount * od.Quantity)-Total_Order_Amount) as Profit,
(sum(o.Total_Order_Amount * od.Quantity)-Total_Order_Amount)/ (sum(o.Total_Order_Amount * od.Quantity))*100 as Profit_Margin
from orders as o join orderdetails as od on o.orderid=od.orderid
join products as p on p.productid=od.productid
group by o.orderid, Total_Order_Amount
order by o.orderid;

# 2. Print the details of different payment methods along with the total amount of money transacted through them in the years 2020 and 2021. Print Payment Type, Allowed, Transaction value in 2020, Transaction value in 2021. Order your output in alphabetical order of Payment Type. Include all payment types that exist in the database.
select paymenttype, allowed, sum(distinct(case when year(orderdate)='2020' then total_order_amount end)) as Transaction_value_in_2020,
sum(distinct(case when year(orderdate)='2021' then total_order_amount end)) as Transaction_value_in_2021
from orders as o join payments as p on o.paymentid=p.paymentid
group by paymenttype, allowed
order by paymenttype asc;


# 3. Print CustomerID, Customer Full Name (with a single space in between first name and last name), number of orders ordered, total amount spent across all orders (consider Total Order Amount), Total product quantity (irrespective of the product ID). Identify top 10 customers according to decreasing order of Total spend.

select c.customerid, concat(firstname,' ',lastname) as Full_Name, count(distinct o.orderid) as Num_of_Orders, sum(total_order_amount) as Total_Spend, sum(Quantity) as Total_Quantity
from customers as c join orders as o on c.customerid=o.customerid
join orderdetails as od on o.orderid=od.orderid
group by c.customerid, Full_Name
order by Total_Spend desc limit 10;



# 4. Print Customer ID and days difference between their first order and third order.If two or more orders are placed in a same day then prioritize the order with highest order amount.Filter the output for the customer Id where the days difference is less than 60. Sort the result in ascending order of customer Id.
with cte as(select customerid,orderdate,total_order_amount,dense_rank()
 over(partition by customerid order by orderdate, total_order_amount desc) as rnk from orders)
 select customerid,timestampdiff(day,min(case when rnk=1 then orderdate end),min(case when rnk=3 then orderdate end)) as third_order 
 from cte 
 where rnk between 1 and 3 
 group by customerid
 having third_order < 60 order by customerid;



# 5. Identify the products whose names consist of the word 'Baby'. Then count the number of such products for each Category and Sub Category. Print Category ID, Category Name, Sub Category and followed by the Count. Sort the result in ascending order of Category ID. Secondary sort on the basis of alphabetical order of Sub Category.
select categoryid,categoryname,sub_category,count(*) from Category c
 join products p on c.categoryid=p.category_id 
 where product like '%Baby%' 
 group by c.categoryid,p.sub_category 
 order by p.category_id,sub_category;
 
 
 
 # 6. Print the Productid, Quantity and Orderdate for daily top - 3 selling products between January 2020 to March 2020. Essentially you are trying to identify the top 3 products sold for each date between the given date range. Sort the result in ascending order of OrderDate, for records with same orderdate, sort them in ascending order of Quantity.
 with cte as(select productid,sum(quantity) as total,orderdate from orders a join orderdetails b 
 on a.orderid = b.orderid where orderdate between '2020-01-01'and'2020-03-31' 
 group by productid,orderdate) 
 select productid,total,orderdate from 
 (select productid,total,orderdate, dense_rank()over(partition by orderdate order by total desc) as rnk from cte) as x 
 where rnk<=3 
 order by orderdate,total;

 
 # 7. How much payment collected through paymentId equal to 2 by each shippers in their first 10 orders. Print Shipper ID and Total payment Collection by that shipper. Sort the table in ascending order of shipper id.
 with cte as(select shipperid,orderid,sum(total_order_amount) as total from payments as p
 join orders as o on p.paymentid=o.paymentid where p.paymenttype="POD" 
 group by shipperid,orderid), 
 cte2 as(select shipperid,orderid,total,dense_rank() over(partition by shipperid order by orderid) as rnk from cte) 
 select shipperid,sum(total) as revenue from cte2
 where rnk<=10
 group by shipperid 
 order by shipperid;
 
 
 # 8. Get the Description of customer along with the Customerid and Domain of their email(like gmail.com, yahoo.com). For customer with no lastname take Web as their last name..The Final output should contain this columns Customerid, Domain of their email, Description.Get the details of description from the below attached sample output Description_ column.Sort the result by DateEntered desc, if date entered is same then CustomeId in ascending. Note- All letters are case sensetive take same case letters as given in sample output Description_. Every Day value will have 'th' in front of it.

select c.customerid, substring_index(email, '@', -1) as domain, concat(firstname, ' ', ifnull(lastname, 'Web'), ' was born on ', 
day(Date_of_birth),"th" ," ", monthname(date_of_birth)," ",year(date_of_birth)," ",'has ordered ', count(*) ,' orders yet.') 
as description from customers as c left join orders as o on c.customerid=o.customerid 
group by c.customerid
 order by dateentered desc;


# 9. Find and display the CategoryId and Product name of the product with the highest discount. Sort the results by CategoryId, and if there are multiple products with the same discount in the same category, sort them in ascending order by Product Name. Discount can be calculated on the difference between Market price and Sell price.
select p.category_id, p.product from ( select category_id, max(market_price-sale_price) as max_discount from products group by category_id ) 
AS c inner join products as p on p.category_id=c.category_id and p.market_price-p.sale_price=c.max_discount
 order by p.category_id, p.product asc;
 
 
 # 10. Rank the countries in terms of quantity of coffee ordered. Conside only the sub category's Coffee. If two or more country's consumptions are same assign them same rank.Print Rank, Country Name, Total Qunatity.Sort the Output on Ranking in ascending order, if two country rank is same then consider Country name in ascending order.
with cte as(select country,sum(quantity) as total from products p join orderdetails od on p.productid=od.productid 
join orders o on od.orderid=o.orderid join customers c on o.customerid=c.customerid 
where sub_category="coffee" 
group by country) 
select dense_rank() over(order by total desc) as rnk,country,total from cte;
