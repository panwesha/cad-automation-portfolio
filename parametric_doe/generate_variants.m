function generate_variants()
    % GENERATE_VARIANTS Generates a parametric design matrix for CAD variant optimization.
    % Simulates a full-factorial Design of Experiments (DoE) used to automate 
    % component variations (e.g., ECU bracket thickness and length) for Creo/NX.
    
    fprintf('Initializing Parametric Variant Generator...\n');

    % Define engineering design variables (discrete bounds)
    % Example: Length in mm, Width in mm, Material Thickness in mm
    length_range    =; 
    width_range     =;       
    thickness_range = [1.5, 2.0, 2.5]; 

    % Generate full-factorial grid arrangement
    [L, W, T] = ndgrid(length_range, width_range, thickness_range);
    
    % Flatten grids into design matrix columns
    design_matrix = [L(:), W(:), T(:)];
    total_variants = size(design_matrix, 1);
    
    fprintf('Successfully generated %d parametric design variations.\n', total_variants);
    
    % Format data into a structured table for export
    variant_ids = cellstr(num2str((1:total_variants)', 'VAR_ECU_%03d'));
    export_table = table(variant_ids, design_matrix(:,1), design_matrix(:,2), design_matrix(:,3), ...
        'VariableNames', {'Variant_ID', 'Length_mm', 'Width_mm', 'Thickness_mm'});
    
    % Define localized output file name
    output_file = 'CAD_Parametric_Variants.csv';
    
    try
        % Write table to CSV for CAD API processing
        writetable(export_table, output_file, 'Delimiter', ';');
        fprintf('Success: Variant matrix exported to %s\n', output_file);
    catch ME
        fprintf('Error occurred during file export: %s\n', ME.message);
    end
end
