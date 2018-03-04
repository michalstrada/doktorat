function [ic, wg] = CalculateInconsistency_Saaty(A)
    [Vectors, eig_vector] = eig(A, 'vector');
    [eig_value, eig_pos] = max(eig_vector);
    
    ic = (eig_value - size(A, 1))/(size(A, 1) - 1);
    wg = Vectors(:, eig_pos)*eig_value;
    wg = wg./sum(wg);
end

