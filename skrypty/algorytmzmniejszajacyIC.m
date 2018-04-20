%function [reschangedPositions, resMatrix] = algorytmzmniejszajacyIC(A_begin, changePercentage, changePossibilityThreshold)
function [reschangedPositions, resMatrix] = algorytmzmniejszajacyIC(A_begin)

k = 5;
ic_minimal = 1/4;
k_min = 1.1;
changes_limit = 100;

A_min = A_begin;

%[A_consistent, wg_consistent] = GenerateConsistentMatrix(matrixSize);
%A_begin = AddInconsistency(A_consistent, changePercentage, changePossibilityThreshold);

changedPositions = size(A_begin, 2);
[ic_begin, wg_begin] = CalculateInconsistency_Saaty(A_begin);

%wg_begin
[~, pos_max_begin] = max(wg_begin);
[~, pos_min_begin] = min(wg_begin);

%
% A(pos_min_begin, pos_min_begin) = 1;
% A(pos_min_begin, pos_max_begin) = k;
% A(pos_max_begin, pos_min_begin) = 1/A(pos_min_begin, pos_max_begin);
% n = 1;



% Macierz jest spojna co do IC
if(ic_begin <= ic_minimal)
    while k > k_min
        succesfully_calculated = true;
        A = A_begin;

        A(pos_min_begin, pos_min_begin) = 1; % zawsze jest rowne 1?
        A(pos_min_begin, pos_max_begin) = k;
        A(pos_max_begin, pos_min_begin) = 1/A(pos_min_begin, pos_max_begin);
        iterations = 1;

        changedPositionsIndexes = []; 
        positionToMaximalize = [pos_min_begin];

        while (1 == 1)
            [ic, wg] = CalculateInconsistency_Saaty(A);
            [~, pos_max] = max(wg);

            if ((ic <= ic_minimal) && (pos_max == pos_min_begin))
                break;
            end

            % Wsyzstkie wartosci ktore zostaly zmienione w poprzednich krokach dzialania algorytmu sa updatowane

     %       for(i = 1:1:size(changedPositionsIndexes, 2))
     %           A(pos_min_begin, changedPositionsIndexes(i)) = k*wg(pos_max_begin)/wg(changedPositionsIndexes(i));
     %           A(changedPositionsIndexes(i), pos_min_begin) = 1/A(pos_min_begin, changedPositionsIndexes(i));
     %      end

            v_temp = A(pos_min_begin, :);
            v_temp(positionToMaximalize) = 2*max(v_temp); %Aby miec pewnosc ze nie zmienimy 1 -> wi/wi
            [~, pos] = min(v_temp);

            posInChangedPositionIndexes = find(changedPositionsIndexes == pos);

            if (size(posInChangedPositionIndexes, 2) == 0)
                changedPositionsIndexes = [changedPositionsIndexes, pos];
                
                A(pos_min_begin, pos) = k*wg(pos_max_begin)/wg(pos);
                A(pos, pos_min_begin) = 1/A(pos_min_begin, pos);
            else
                if (size(find(positionToMaximalize == pos), 2) ~= 0)
                    succesfully_calculated = false;
                    break;
                end

                positionToMaximalize = [positionToMaximalize, pos];

  %              if (A(pos_min_begin, pos) < wg(pos_max_begin)/wg(pos))
  %                 A(pos_min_begin, pos) = k*(A(pos_min_begin, pos) + 2*wg(pos_max_begin)/wg(pos));
  %              else
                  A(pos_min_begin, pos) = k*A(pos_max_begin, pos);
  %              end

                A(pos, pos_min_begin) = 1/A(pos_min_begin, pos);
            end

            iterations = iterations + 1;
        end

        if(true == succesfully_calculated)
            % +1 Because pos_max_begin is not included in changedPositionsIndexes
            if (size(changedPositionsIndexes, 2) + 1) < changedPositions
                changedPositions = size(changedPositionsIndexes, 2) + 1;
                A_min = A;
            end
        end

        k = 0.99*k;
    end
end

reschangedPositions = changedPositions;
resMatrix = A_min;

end

