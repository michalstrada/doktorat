matrixSize = 7;
changePercentage = 70;
changePossibilityThreshold = 0.3;

[A_consistent, wg_consistent] = GenerateConsistentMatrix(matrixSize);
%changedPositions = size(A_consistent, 2);

A_begin = AddInconsistency(A_consistent, changePercentage, changePossibilityThreshold);
[ic_begin, wg_begin] = CalculateInconsistency_Saaty(A_begin);

A = A_begin;
w = wg_begin;

for i = 1:1:size(A, 1)
   for j = 1:1:size(A, 2)

        A(i, j) = abs(A(i, j) - w(i)/w(j));
%        A(j, i) = abs(A(j, i) - w(j)/w(i));

   end  
end

A
