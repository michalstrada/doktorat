repeatNumber = 1000;

result = zeros(1, repeatNumber);

for i=1:1:repeatNumber
   [reschangedPositions, resMatrix] = algorytmzmniejszajacyIC(7, 70, 0.3);
   result(1, i) = reschangedPositions;

   if (mod(i, 100) == 0)
      i
   end

end;
