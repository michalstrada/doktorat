function A = AddInconsistency(M, changePercentage, changePossibilityThreshold)
    A = M;
    for i=1:1:size(M, 1)
       for j=(i + 1):1:size(M, 2)
           if (rand() > changePossibilityThreshold)
              A(i, j) = A(i, j)*(1 + changePercentage/100*(-1 + 2*rand()));
              A(j, i) = 1/A(i, j);
           end
       end  
    end
end

