k = 5;
ic_minimal = 1/4;
k_min = 1.1;
changes_limit = 100;

[A_consistent, wg_consistent] = GenerateConsistentMatrix(20);
n_min = size(A_consistent, 2);

A_begin = AddInconsistency(A_consistent, 70, 0.3);
[ic_begin, wg_begin] = CalculateInconsistency_Saaty(A_begin);

%wg_begin
[~, pos_max_begin] = max(wg_begin);
[~, pos_min_begin] = min(wg_begin);

%
% A(pos_min_begin, pos_min_begin) = 1;
% A(pos_min_begin, pos_max_begin) = k;
% A(pos_max_begin, pos_min_begin) = 1/A(pos_min_begin, pos_max_begin);
% n = 1;
if(ic_begin <= ic_minimal)
    while k > k_min
        A = A_begin;

        A(pos_min_begin, pos_min_begin) = 1;
        A(pos_min_begin, pos_max_begin) = k;
        A(pos_max_begin, pos_min_begin) = 1/A(pos_min_begin, pos_max_begin);
        n = 1;

        changedPositions = [];

        while (1 == 1)
            [ic, wg] = CalculateInconsistency_Saaty(A);
            [~, pos_max] = max(wg);

            if ((ic <= ic_minimal) && (pos_max == pos_min_begin))
                break;
            end

            v_temp = A(pos_min_begin, :);
            v_temp(pos_min_begin) = 2*max(v_temp);
            [~, pos] = min(v_temp);
            A(pos_min_begin, pos) = k*wg(pos_max_begin)/wg(pos);%wg(pos_max_begin)/wg(pos);A(pos_max_begin, pos)
            A(pos, pos_min_begin) = 1/A(pos_min_begin, pos);

            changedPositions = [changedPositions, pos];
            if(length(changedPositions) > changes_limit)
                break;
            end

            n = n + 1;
        end

        if(length(changedPositions) <= changes_limit)
            %To minimalize inconsistency
            for i = 1:1:length(changedPositions)
                A(pos_min_begin, changedPositions(i)) = wg(pos_min_begin)/wg(changedPositions(i));
                A(changedPositions(i), pos_min_begin) = 1/A(pos_min_begin, changedPositions(i));
                %[ic, wg] = CalculateInconsistency_Saaty(A)
            end

            if n < n_min
                n_min = n;
                A_min = A;
            end
        end

        k = 0.99*k;
    end
end

n_min
A_begin - A_min

