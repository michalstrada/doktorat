function [A, wg] = GenerateConsistentMatrix(dimension)
    A = ones(dimension);

    wg = rand([dimension, 1]);
    wg = wg./sum(wg);

    for i = 1:1:dimension
%        for j = 1:1:dimension
%           A(i, j) = v(i)/v(j);        
%        end

% TODO: Consider another method
       for j = (i + 1):1:dimension
          A(i, j) = wg(i)/wg(j);        
       end

       for j = 1:1:(i - 1)
          A(i, j) = 1/A(j, i);        
       end

    end

end

