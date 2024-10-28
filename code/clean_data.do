global MainDir "/Users/talhanaeem/Documents/GitHub/Agroecology4Climate_2024/data"

insheet using "$MainDir/UBC_Farm_Data_GHG.csv", clear

**** SUMMARY

*-> we have data on 38 plots

*-> task_date, seed_date, germination_date, transplant_date, harvest_date, area, crop variety and group, harvest, 
***---> can help us get the crop-specific growing period
***---> focus on vegetables / varieties 
***---> can compute yields(!?!)

*-> grid points 
***---> crop-specific exposure 

*-> 31 crop varieties, 22 crops, 11 crop genus, 5 crop subgroups, 4 crop groups. 

**** QUESTIONS

* What are the tasks that are associated with task_id? 
* if task_complete_date and task_abandon_date are empty, what should we infer about those tasks? 22/70 such cases reflect that. 
* actual_quantity_kg seems to be missing even where harvest_everything is TRUE
* It also seems like that there is only 1 data point for most of the "plots" within UBC Farm -- we need at least a few years of data to do any sort of analysis, ideally from the start of when emissions were monitored. 
* For the plots that we have at the UBC Farm, we need emissions data from Alan that we could complement to this data. 
* Is soil homogenous across plots? measures of soil quality/health at the plot-level? 




gen task_end_date = task_complete_date
replace task_end_date = task_abandon_date if task_end_date==""
order task_end_date, after(task_abandon_date)
count if task_end_date==""

ren (seed_dateaddedincropplan germination_dateaddedincropplan transplant_dateaddedincropplan harvest_dateaddedincropplan) ///
(seed_date germination_date transplant_date harvest_date)

ren (location_name location_type) (plot_name plot_type)
ren (location_area_ha location_perimeter_m) (plot_area_ha plot_perimeter_m)

unique plot_name
tab task_complete_date

drop farm_id farm_name plot_type projected_quantity harvest_use_type_name harvest_use_quantity 

bys plot_name
