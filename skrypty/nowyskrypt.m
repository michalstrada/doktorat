%function [reschangedPositions, resMatrix] = algorytmzmniejszajacyIC(A_begin, changePercentage, changePossibilityThreshold)
function [reschangedPositions, resMatrix] = nowyskrypt(A_begin)

delta = 0.0001;
ic_minimal = 1/4;

changes_limit = 100;

[ic_begin, wg_begin] = CalculateInconsistency_Saaty(A_begin);

%wg_begin
[~, pos_max_begin] = max(wg_begin);
[~, pos_min_begin] = min(wg_begin);


% Macierz jest spojna co do IC
if(ic_begin <= ic_minimal)

   A = A_begin;
   positionsToChange = [pos_max_begin]

%   A(pos_min_begin, pos_min_begin) = 1; % zawsze jest rowne 1?
%   A(pos_min_begin, pos_max_begin) = k;
%   A(pos_max_begin, pos_min_begin) = 1/A(pos_min_begin, pos_max_begin);
%   iterations = 1;

%   changedPositionsIndexes = []; 
%   positionToMaximalize = [pos_min_begin];

   while (1 == 1)
      [ic, wg] = CalculateInconsistency_Saaty(A);
      [~, pos_max] = max(wg);

      if ((ic <= ic_minimal) && (pos_max == pos_min_begin))
          break;
      end

      %find the best element which should be changed
      changeResults = zeros(1, length(positionsToChange));

      for changeElement = 1:1:length(positionsToChange)
         A_temp = A;
         A_temp(pos_min_begin, positionsToChange(changeElement)) = A_temp(pos_min_begin, positionsToChange(changeElement)) + delta;
         A_temp(positionsToChange(changeElement), pos_min_begin) = 1/A_temp(pos_min_begin, positionsToChange(changeElement));

         [ic_temp, wg_temp] = CalculateInconsistency_Saaty(A_temp);
         [max_value_temp, pos_max_temp] = max(wg_temp);

         if (ic_temp <= ic_minimal)

            if (pos_max_temp == pos_min_begin)
             %  succesfully_calculated = true;
               A = A_temp;
               break;
            end

            if (ic_temp <= ic)
               %changeResults(changeElement) = (wg_temp(positionsToChange(changeElement)) - wg_temp(pos_min_begin));
               %changeResults(changeElement) = 1/(max_value_temp - wg_temp(pos_min_begin));
               changeResults(changeElement) = (wg_begin(positionsToChange(changeElement)))/(max_value_temp - wg_temp(pos_min_begin));
            else
               %changeResults(changeElement) = (wg_temp(positionsToChange(changeElement)) - wg_temp(pos_min_begin))*(ic_temp - ic);
               %changeResults(changeElement) = 1/(max_value_temp - wg_temp(pos_min_begin))*(ic_temp - ic);
               changeResults(changeElement) = (wg_begin(positionsToChange(changeElement)))/(max_value_temp - wg_temp(pos_min_begin))*(ic - ic_temp);
            end
         end
      end

      [best_change_value, best_change_pos] = max(changeResults);

      if (best_change_value == 0)

         A = A_begin;
         positionToMaximalize = [positionsToChange, pos_min_begin];

         v_temp = A(pos_min_begin, :);
         v_temp(positionToMaximalize) = 2*max(v_temp);
         [~, pos] = min(v_temp);

         positionsToChange = [positionsToChange, pos]

      else
         A(pos_min_begin, positionsToChange(best_change_pos)) = A(pos_min_begin, positionsToChange(best_change_pos)) + delta;
         A(positionsToChange(best_change_pos), pos_min_begin) = 1/A(pos_min_begin, positionsToChange(best_change_pos));
      end

   end

end

reschangedPositions = length(positionsToChange);
resMatrix = A;

end

