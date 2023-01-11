# change data formating 

 update nashville_housing_data
 set saledate=STR_TO_DATE(saledate, '%m/%d/%Y')

 -------------------------------------------------------------
 #split address 
 
Select propertyaddress ,SUBSTRING_INDEX(propertyaddress,',', 1) ,SUBSTRING_INDEX(SUBSTRING_INDEX(propertyaddress,',',2)," ",-1) 
from nashville_housing_data 
 
 ALTER TABLE nashville_housing_data  add
owneraddress_splite varchar(255)

update nashville_housing_data 
set propertyaddres_1=SUBSTRING_INDEX(propertyaddress,',', 1)



ALTER TABLE nashville_housing_data  add
propertyaddres_2 varchar(255)

update nashville_housing_data 
set propertyaddres_2=SUBSTRING_INDEX(SUBSTRING_INDEX(propertyaddress,',',2)," ",-1)


 -------------------------------------------------------------
 
 # update column soldasvacant from y to Yes ,n to NO
 
 select count(soldasvacant),soldasvacant
from nashville_housing_data
group by soldasvacant


update nashville_housing_data
set soldasvacant_1=
case 
	when soldasvacant = "y" then "Yes"
	when soldasvacant = "N" then "No"
    else soldasvacant
end ;
 -------------------------------------------------------------
# check if there any duplicate and 
 
 
select * from(
Select *,
     ROW_NUMBER() OVER (
     PARTITION BY ParcelID,
                PropertyAddress,
                 SalePrice,
                 SaleDate,
                 LegalReference
			
                     ) new
 FROM nashville_housing_data) 
 as newtable 
 where new > 1;

 
 #-------------------------------------------------------------

alter table nashville_housing_data  drop  column soldasvacant  