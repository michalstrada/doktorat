repeatNumber = 1000;
matrixSize = 7;
changePercentage = 80;
changePossibilityThreshold = 0.3;

result = {7, repeatNumber};

for i=1:1:repeatNumber

   [A_consistent, wg_consistent] = GenerateConsistentMatrix(matrixSize);
   A_begin = AddInconsistency(A_consistent, changePercentage, changePossibilityThreshold);
   result{1, i} = A_begin;

   [reschangedPositions, resMatrix] = algorytmBasic(A_begin);
   result{2, i} = reschangedPositions;
   result{3, i} = CalculateInconsistency_Saaty(resMatrix);

   [reschangedPositions, resMatrix] = algorytmzmniejszajacyIC(A_begin);
   result{4, i} = reschangedPositions;
   result{5, i} = CalculateInconsistency_Saaty(resMatrix);

  % [reschangedPositions, resMatrix] = algorytmzmniejszajacyICzzastowowaniemdjikstry(A_begin);
   [reschangedPositions, resMatrix] = algorytmzmniejszajacyIC2(A_begin);
   result{6, i} = reschangedPositions;
   result{7, i} = CalculateInconsistency_Saaty(resMatrix);
i

end;
