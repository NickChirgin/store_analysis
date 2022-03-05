--Dataset downloaded from Kaggle

/*Questions to answer:
 * 1. Preferred shipping mode?
 * 2. Buyers distribution by amount of orders
 * 3. Buyers distribution by amount of sales
 * 4. Region distribution by amount of orders
 * 5. Region distribution by amount of sales
 * 6. Top 3 sub-categories by quantity
 * 7. Which category is the most profitable?
 * 8. The best sub-categories across categories
 */

--Preferred  shipping mode:
SELECT  Ship_Mode, COUNT(ID) as cnt
from Sample s
GROUP BY Ship_Mode
ORDER BY cnt DESC;

--Standard Class is preferable method of dilevery by a huge margin.

--2. Buyers distribution by amount of orders
SELECT Segment, count(ID) as cnt
from Sample s
GROUP BY Segment 
ORDER BY cnt DESC;

--b2c segment making half of the orders.

--3. Buyers distribution by amount of sales
SELECT Segment, CAST(sum(Sales) as integer) as total_sales
from Sample s
GROUP BY Segment 
ORDER BY total_sales  DESC;

--b2c segment making half of the sales.

--4. Region distribution by amount of orders
SELECT Region, count(ID) as cnt
from Sample s
GROUP BY Region 
ORDER BY cnt DESC;

--Both coasts are making the most of orders.

--5. Region distribution by amount of sales
SELECT Region, CAST(sum(Sales) as integer) as total_sales
from Sample s
GROUP BY Region
ORDER BY total_sales  DESC;

--Same applies for sales.

--6. Top 3 categories by quantity
SELECT "Sub-Category" , sum(Quantity) as total_quantity
from Sample s
GROUP BY "Sub-Category"
ORDER BY total_quantity DESC
LIMIT 3;

--Binder, Paper and Furnishings purchased more often.

--7. Which category is the most profitable?
SELECT Category, CAST(sum(Profit) as integer) as total_profit
from Sample s
GROUP BY Category 
ORDER BY total_profit DESC;

--Furniture is the least profitable category

--8. The best sub-categories across categories by profit
SELECT Category, "Sub-Category", total_profit
	from (
		SELECT Category, "Sub-Category", total_profit, ROW_NUMBER() over(PARTITION BY Category order BY total_profit DESC) as rank_
			from (SELECT Category, "Sub-Category",  CAST(sum(Profit) as integer) as total_profit
				from Sample s
				GROUP BY 2
				ORDER BY 1, total_profit DESC) as p ) as t
WHERE rank_ < 2

-- Chairs, Paper and Copiers the best sub-category .

--9. Profit by region
SELECT State, CAST(sum(Profit) as integer) as total_profit
from Sample s
GROUP BY State
ORDER BY total_profit DESC;

-- California and New York are main sources of profit
