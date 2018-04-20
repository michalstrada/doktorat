function A = CalculateGlobalInconsistencyMatrix(M)

   A = M;
   [~, wg] = CalculateInconsistency_Saaty(M);

   for i = 1:1:size(A, 1)
      for j = 1:1:size(A, 2)
           A(i, j) = abs(A(i, j) - wg(i)/wg(j));

           if(i == j)
              A(i, j) = 1;
           end
      end  
   end
end
