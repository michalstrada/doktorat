function A = CalculateLocalInconsistency(M)
    A = ones(size(M, 1));
    [~, wg] = CalculateInconsistency_Saaty(M);

    for i=1:1:size(M, 1)
       for j=1:1:size(M, 2)
          A(i, j) = M(i, j) - wg(i)/wg(j);
       end
    end
end

