SELECT
    f.farm_id,
    f.farm_name,
    t.task_id,
    t.due_date as task_due_date,
    t.complete_date as task_complete_date,
    t.abandon_date as task_abandon_date,
    cmp.seed_date as "seed_date added in crop plan",
    cmp.germination_date as "germination_date added in crop plan",
    cmp.transplant_date as "transplant_date added in crop plan",
    cmp.harvest_date as "harvest_date added in crop plan",
    l.name as location_name,
    fig.type as location_type,
    a.total_area/10000 as location_area_ha,
    a.perimeter as location_perimeter_m,
    a.grid_points,
    cv.crop_variety_name,
    c.crop_common_name,
    c.crop_genus,
    c.crop_subgroup,
    c.crop_group,
    c.lifecycle,
    ht.projected_quantity,
    ht.actual_quantity as actual_quantity_kg,
    ht.harvest_everything,
    hu.quantity as harvest_use_quantity,
    hut.harvest_use_type_name
FROM
    task t
JOIN
    task_type tt on tt.task_type_id = t.task_type_id
JOIN
    harvest_task ht on ht.task_id = t.task_id
LEFT JOIN
    harvest_use hu on hu.task_id = ht.task_id
LEFT JOIN
    harvest_use_type hut on hut.harvest_use_type_id = hu.harvest_use_type_id
JOIN
    management_tasks mt ON mt.task_id = t.task_id
JOIN
    planting_management_plan pmp ON pmp.planting_management_plan_id = mt.planting_management_plan_id
JOIN
    location l ON l.location_id = pmp.location_id
JOIN
    figure fig ON fig.location_id = l.location_id
JOIN
    area a ON a.figure_id = fig.figure_id
JOIN
    management_plan mp ON mp.management_plan_id = pmp.management_plan_id
JOIN
    crop_management_plan cmp ON cmp.management_plan_id = mp.management_plan_id
JOIN
    crop_variety cv ON cv.crop_variety_id = mp.crop_variety_id
JOIN
    crop c on c.crop_id = cv.crop_id
JOIN
    farm f on f.farm_id = cv.farm_id
JOIN
    countries con ON con.id = f.country_id
WHERE
    t.deleted = false
    AND mp.deleted = false
    AND cv.deleted = false
    AND f.deleted = false
    AND f.sandbox_farm = false
    AND l.deleted = false
    AND mp.deleted = false
    AND c.deleted = false
    AND cv.farm_id = '47e212a6-075f-11ec-a016-0242ac140002'