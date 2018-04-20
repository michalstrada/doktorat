basicBetter = [];
basicWorser = [];
basicEqual = [];

for i = 1:1:size(result, 2) 
    if(result{4,i} < result{6,i})
        basicBetter = [basicBetter, i];
    end
end

for i = 1:1:size(result, 2)
    if(result{4,i} > result{6,i})
        basicWorser = [basicWorser, i];
    end
end

for i = 1:1:size(result, 2)
    if(result{3,i} < result{7,i})
        basicEqual = [basicEqual, i];
    end
end