CREATE DATABASE smartphone;
use smartphone;

ALTER TABLE smartphones_cleaned_v6
RENAME TO mobile;

select * from mobile;
-- Q-1 1. find the top 5 Samsung phones with the biggest screen size
SELECT brand_name,model,screen_size
FROM mobile
where brand_name='samsung'
ORDER BY screen_size desc
limit 5;

-- 2. sort all the phones in descending order of the number of total cameras 
select*, num_rear_cameras+num_front_cameras as "total_cameras"
from mobile
order by total_cameras desc;

-- 3.Sort data on the basis of ppi in decreasing order
select *,Round(SQRT(resolution_width*resolution_width*+resolution_height*resolution_height)/screen_size) as "ppi"
from mobile
order by ppi desc;

-- 4 find the phone with 2nd largest battery
select model,battery_capacity 
from mobile
order by battery_capacity desc
limit 1,1;

-- 5 find the phone with 3rd largest battery
select model,battery_capacity 
from mobile
order by battery_capacity desc
limit 3,1;

-- 6 find the phone with 2nd lowest battery
select model,battery_capacity 
from mobile
order by battery_capacity asc
limit 1,1;

-- 7 find the name and rating of the worst rated apple phone
select model,rating from mobile
where brand_name='apple'
order by rating asc
limit 1;

-- 8 Sort the  phones alphabetically and then on the basis of price in desc order

select * 
from mobile
order by brand_name ,price desc;

-- 9  Sort the  phones alphabetically and then on the basis of rating in desc order

select * 
from mobile
order by brand_name ,rating desc;

-- 10.Group smartphones by brand and get the count, average price, max rating, avg screen size, and avg battery capacity

select brand_name,count(*),round(avg(price)),round(avg(screen_size)),round(avg(battery_capacity)),max(rating)
from mobile
group by brand_name
limit 5;

--  11. Group smartphones by whether they have an NFC or not and get the average price and rating

select has_nfc,round(avg(price)) as avg_price,round(avg(Rating)) as avg_rating
from mobile
group by has_nfc;

--  12.Avg price of 5g phones vs avg price of non 5g phones

select has_5g,round(avg(price))
from mobile
group by has_5g;

-- 13 Analysis of Fast Charging Available
select fast_charging_available,round(avg(price)),round(avg(rating))
from mobile
group by fast_charging_available;

-- 14 Group smartphones by the extended memory available or not and get the average price

select extended_memory_available,round(avg(price)) as avg_price
from mobile
group by extended_memory_available;

select * from mobile;

-- Group smartphones by the brand and processor brand and get the count of models and the average primary camera resolution (rear)

Select brand_name,processor_brand, count(model),round(avg(primary_camera_rear)) 
from mobile
group by brand_name,processor_brand;

-- Find the top 5 most costly phone brands

Select brand_name,avg(price) as avg_price
from mobile
group by brand_name
order by avg_price desc
limit 5;

-- Find the top 5 smallest screen smartphones

Select brand_name,avg(screen_size) as avg_price
from mobile
group by brand_name
order by avg_price
limit 5;

-- Group smartphones by the brand, and find the brand with the highest number of models that have both NFC and an IR blaster
select brand_name,count(model) as count_model
from mobile
where has_nfc='True' and has_ir_blaster='True'
group by brand_name
order by count_model desc
limit 1;

--  Find all Samsung 5g enabled smartphones and find out the avg price for NFC and Non-NFC phones

select brand_name,has_nfc,avg(price)
from mobile
where brand_name='samsung'
group by has_nfc;

-- Costliest Brand which has at least 20 phones.
select brand_name,count(*) as 'count_total',avg(price) as 'avg_price'
from mobile
group by brand_name
having count_total>20
order by avg_price desc;

-- find the avg rating of smartphone brands that have more than 20 phones
select brand_name,count(*) as 'count_total',avg(rating) as 'avg_rating'
from mobile
group by brand_name
having count_total>20
order by avg_rating desc;

-- Find the top 3 brands with the highest avg ram that has a refresh rate of at least 90 Hz and fast charging available and don't consider brands that have less than 10 phones
select brand_name,avg(ram_capacity) as avg_ram
from mobile
where refresh_rate>90 and fast_charging_available=1
group by brand_name
having count(*)>20
order by avg_ram desc
limit 3;

-- Find the avg price of all the phone brands with avg rating of 70 and num_phones more than 10 among all 5g enabled phones

select brand_name,avg(price) as avg_price,avg(rating) as avg_rating
from mobile
where has_5g='True'
group by brand_name
having avg_rating>70 and count(*)>10;



