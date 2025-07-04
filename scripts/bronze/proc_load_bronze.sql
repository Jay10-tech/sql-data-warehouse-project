/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
-- Turn and Store this script into a STORED PROC for Bronz Layer.
-- Run this script daily inorder to insert new content into the Bronze tables.

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
     --TRACK ETL DURATION : Decalre start and end time variables and Set them to a GETDATE() function to get the real time of execution of ETL.
	 DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	 
	 -- Add 'TRY....CATCH': Ensures error handling, data integrity, and issue logging for easier debugging.
	 BEGIN TRY
		 
		 --Track ETL for the "Whole Batch"
		 SET @batch_start_time = GETDATE();

		-- Adding 'PRINT' as seperator.THis is for the purpose of tracking execution, debug issues and understanding its flow.
		PRINT'===============================================================';
		PRINT'LOADING BRONZE LAYER';
		PRINT'===============================================================';

		-- BRONZE LAYER
		--DEVELOPE SQL LOAD SCRIPTS
		-- METHOD: use "Bulk Insert"
			-- This script below will insert all the data from the source files into all the tables specified.

		PRINT'-----------------------------------------------------------------';
		PRINT'Loading CRM Tables';
		PRINT'-----------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT'>>Inserting Table: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\isemu\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
				FIRSTROW = 2,
				FIELDTERMINATOR =',',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT'------------------------------------------------------';
/*
		SELECT COUNT(*)
		FROM bronze.crm_cust_info;

		SELECT *
		FROM bronze.crm_cust_info;
		*/
		----------------------------------------------------

		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT'>>Inserting Table: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\isemu\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
				FIRSTROW = 2,
				FIELDTERMINATOR =',',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT'------------------------------------------------------';
/*
		SELECT COUNT(*)
		FROM bronze.crm_prd_info;

		SELECT *
		FROM bronze.crm_prd_info;
		*/
		----------------------------------------------------

		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT'>>Inserting Table: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\isemu\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
				FIRSTROW = 2,
				FIELDTERMINATOR =',',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT'------------------------------------------------------';
/*
		SELECT COUNT(*)
		FROM bronze.crm_sales_details;

		SELECT *
		FROM bronze.crm_sales_details;
		*/
		----------------------------------------------------

		SET @start_time = GETDATE();
		PRINT'-----------------------------------------------------------------';
		PRINT'Loading ERP Tables';
		PRINT'-----------------------------------------------------------------';

		PRINT'>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT'>>Inserting Table: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\isemu\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
				FIRSTROW = 2,
				FIELDTERMINATOR =',',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT'------------------------------------------------------';
/*
		SELECT COUNT(*)
		FROM bronze.erp_cust_az12;

		SELECT *
		FROM bronze.erp_cust_az12;
		*/
		----------------------------------------------------

		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT'>>Inserting Table: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\isemu\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH(
				FIRSTROW = 2,
				FIELDTERMINATOR =',',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT'------------------------------------------------------';
/*
		SELECT COUNT(*)
		FROM bronze.erp_loc_a101;

		SELECT *
		FROM bronze.erp_loc_a101;
		*/
		----------------------------------------------------

        SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT'>>Inserting Table: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\isemu\OneDrive\Desktop\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
				FIRSTROW = 2,
				FIELDTERMINATOR =',',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT'------------------------------------------------------';

		SET @batch_end_time = GETDATE();
		PRINT'Loading Bronze layer is completed';
		PRINT' - Total Load duration:' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';
		PRINT'=====================================================';
/*
		SELECT COUNT(*)
		FROM bronze.erp_px_cat_g1v2;

		SELECT *
		FROM bronze.erp_px_cat_g1v2;
  */   
   END TRY
   BEGIN CATCH
       	PRINT'===============================================================';
		PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT'Error Message:' + ERROR_MESSAGE();
		PRINT'Error Message:' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT'Error Message:' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT'===============================================================';
   END CATCH
END
----------------------------------------------------
