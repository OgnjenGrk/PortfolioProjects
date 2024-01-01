----1. Прелазак са DATETIME на DATE формат

--UPDATE NashvilleHousing
--SET SaleDateConverted = CONVERT(DATETIME, SaleDate, 101)

--SELECT SaleDateConverted
--FROM NashvilleHousing

--2. Попунити податке о адреси имовине

--SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
--FROM NashvilleHousing as a
--JOIN NashvilleHousing as b
--ON a.ParcelID = b.ParcelID
--AND a.[UniqueID ] <> b.[UniqueID ]
--WHERE b.PropertyAddress IS NULL

--UPDATE a
--SET a.PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
--FROM NashvilleHousing as a
--JOIN NashvilleHousing as b
--ON a.ParcelID = b.ParcelID
--AND a.[UniqueID] <> b.[UniqueID]

--SELECT *
--FROM NashvilleHousing
--WHERE PropertyAddress IS NULL

----3. Поделити адресе на посебне колоне (адреса, град, држава)
--SELECT PropertyAddress, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress, 1)+1, LEN(PropertyAddress)) AS City,
--SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress, 1)-1) AS Street
--FROM NashvilleHousing

--ALTER TABLE NashvilleHousing
--ADD PropertyStreet varchar(100);

--ALTER TABLE NashvilleHousing
--ADD PropertyCity varchar(100);

--UPDATE NashvilleHousing
--SET NashvilleHousing.PropertyStreet = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress, 1)-1)

--UPDATE NashvilleHousing
--SET PropertyCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress, 1)+1, LEN(PropertyAddress))

--SELECT PropertyAddress, PropertyStreet, PropertyCity
--FROM NashvilleHousing
--ORDER BY [UniqueID ]

----4. Променити Y и N у Yes и No у колони SoldAsVacant

----ПРВИ НАЧИН
--SELECT SoldAsVacant
--FROM NashvilleHousing
--WHERE UPPER(SoldAsVacant) IN ('Y', 'N')

--UPDATE NashvilleHousing
--SET SoldAsVacant = 'Yes'
--WHERE UPPER(SoldAsVacant) = 'Y'

--UPDATE NashvilleHousing
--SET SoldAsVacant = 'No'
--WHERE UPPER(SoldAsVacant) = 'N'

---- ДРУГИ НАЧИН
--UPDATE NashvilleHousing
--SET SoldAsVacant =
--CASE 
--	WHEN SoldAsVacant = 'Da' THEN 'Yes'
--	WHEN SoldAsVacant = 'Ne' THEN 'No'
--	ELSE SoldAsVacant
--END
--FROM NashvilleHousing;

--SELECT SoldAsVacant
--FROM NashvilleHousing

----5. Уклањање дупликата

--WITH RowNumCTE AS(
--SELECT *,
--	ROW_NUMBER() OVER(
--		PARTITION BY ParcelID,
--					 PropertyAddress,
--					 SalePrice,
--					 SaleDate,
--					 LegalReference
--					 ORDER BY
--						UniqueID
--						) as BrojReda
--FROM NashvilleHousing)

--SELECT *
--FROM RowNumCTE
--WHERE BrojReda > 1

----6. Обрисати неупотребљене колоне

--ALTER TABLE NashvilleHousing
--DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress
